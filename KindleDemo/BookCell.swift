//
//  BookCell.swift
//  KindleDemo
//
//  Created by jhow on 01/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    // Encapsulation
    var book: Book? {
        didSet {
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            
            coverImageView.image = nil
           
            guard let coverImageUrl = book?.coverImageUrl else { return }
            guard let url = URL(string: coverImageUrl) else { return }
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    print("failed to download the cover image: ", err)
                }
                
                guard let imageData = data else { return }
                guard let image = UIImage(data: imageData) else { return }
               
                // update the cover image in the main thread
                DispatchQueue.main.async {
                    // if you call object in the other thread, you better to add the self to mark where you from
                    self.coverImageView.image = image
                }
                
            }.resume()
        }
    }
    // This syntax is the closure created and used in the same spot.
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        /*
           Note that the autoresizing mask contraints fully specify the view's size
           and position; Therefore, you cannot add additional constraints to modify
           this size or position without introducing conflicts. 
         
           So if you want to use the Auto-Layout to dynamically calculate the size and
           position of your view, you must set this property to false.
        */
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Designated Initializer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        /* 
           Designated initializer must call the Designated initializer from parent
           class.
        */
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        backgroundColor = .clear
        
        addSubview(coverImageView)
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 16)
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
                                                               
        addSubview(authorLabel)
        authorLabel.textColor = .lightGray
        authorLabel.font = UIFont(name: authorLabel.font.fontName, size: 14)
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -2).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
                                                                
        print("Cell is being initialized..")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
