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
    let pages: [Page]
    let coverImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
     
        var bookPages = [Page]()
        if let pageDictionaries = dictionary["pages"] as? [[String: Any]] {
            for pageDictionary in pageDictionaries {
                let number = pageDictionary["id"] as? Int ?? -1
                let text = pageDictionary["text"] as? String ?? ""
                let page = Page(number: number, text: text)
                
                bookPages.append(page)
            }
        }
        // the constant variable only initialize once
        self.pages = bookPages
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
