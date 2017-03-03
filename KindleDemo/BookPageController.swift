//
//  BookPageController.swift
//  KindleDemo
//
//  Created by jhow on 01/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class BookPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.book?.title
        // add the left button on the navigation bar.
        // target - who excute the action
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleCloseBtn))
        
        // we have to set backgroundcolor to while because default is black.
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        // Scroll like page to page
        collectionView?.isPagingEnabled = true
       
        /*
           Only UICollectionViewFlowLayout has the scrollDirection property so we
           down casting the collectionViewLayout to UICollectionViewFlowLayout.
        */
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        layout?.minimumLineSpacing = 0
    }
    
    func handleCloseBtn() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 44 is height of navigation bar, 20 is status bar's. (add these to fix the warnings)
        return CGSize(width: view.frame.width, height: view.frame.height - 44 - 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.book?.pages.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        cell.page = self.book?.pages[indexPath.row]
        
        return cell
    }
}
