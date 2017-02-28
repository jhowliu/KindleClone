//
//  ViewController.swift
//  KindleDemo
//
//  Created by jhow on 22/01/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        navigationItem.title = "Kindle"
        
        setupBooks()
    }
    
    fileprivate func setupBooks() {
        let page1 = Page(number: 1, text: "Hello, my name is Steve.")
        let page2 = Page(number: 2, text: "I'm CEO of the Apple.")
        
        let book1 = Book(title: "Steve Jobs", author: "STEVE JOBS", pages: [page1, page2])
        let book2 = Book(title: "Donald Thrump", author: "DONALD THRUMP", pages: [page1, page2])
        
        self.books = [book1, book2]
        
        guard let books = self.books else { return }
        
        for book in books {
            print("Title: \(book.title), Author: \(book.author)")
            for page in book.pages {
                print("Page \(page.number) - \(page.text)")
            }
        }
    }

}

