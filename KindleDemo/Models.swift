//
//  Models.swift
//  KindleDemo
//
//  Created by jhow on 01/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class Book {
    let author: String
    let title: String
    let image: UIImage
    let pages: [Page]
    
    init(title: String, author: String, image: UIImage, pages: [Page]) {
        self.title = title
        self.author = author
        self.image = image
        self.pages = pages
    }
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
