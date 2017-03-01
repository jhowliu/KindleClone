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
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        // Remove the unusable bottom line
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Kindle"
        
        setupBooks()
    }
    // DataSource (Must)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        // Question mark is to unwrap the optional varible
        let book = self.books?[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = books?.count {
            return rows
        }
        return 0 
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    fileprivate func setupBooks() {
        let page1 = Page(number: 1, text: "Hello, my name is Steve.")
        let page2 = Page(number: 2, text: "I'm CEO of the Apple.")
        
        let book1 = Book(title: "Steve Jobs", author: "Walter Isaacson", image:#imageLiteral(resourceName: "steve_jobs"), pages: [page1, page2])
        let book2 = Book(title: "Bill Gates", author: "Michael Becraft", image: #imageLiteral(resourceName: "bill_gates"), pages: [page1, page2])
        
        self.books = [book1, book2]
    }
    
}

