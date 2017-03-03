//
//  PageCell.swift
//  KindleDemo
//
//  Created by jhow on 01/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Text Here Text Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here ext Here  Text Here"
        label.translatesAutoresizingMaskIntoConstraints = false
        // 0 represents no limit
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
