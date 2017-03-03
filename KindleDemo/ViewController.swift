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
        
        fetchBooks()
    }
    // DataSource (Must)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        // Question mark is to unwrap the optional varible
        let book = self.books?[indexPath.row]
        
        // The logic move to the model. (decrease the controller loading)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: bookPageController)
       
        if let selectedBook = self.books?[indexPath.row] {
            bookPageController.book = selectedBook
        }
        
        present(navController, animated: true, completion: nil)
    }
    
    fileprivate func fetchBooks() {
        print("Start fetching the books")
        // wraping the url with string
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            
            // The beginning state of urlsession is stop, so we have to add resume() to start task.
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
               
                if let err = error {
                    print("Failed to fetch external json books: ", err)
                    return
                }
               
                // return if the data is nil
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    guard let bookDictionaries = json as? [[String: Any]] else { return }
                  
                    // we have to set the books initial value because it's given the nil in the beginning of program.
                    self.books = []
                    
                    for bookDictionary in bookDictionaries {
                        if let title = bookDictionary["title"] as? String, let author = bookDictionary["author"] as? String {
                            let book = Book(title: title, author: author, image: #imageLiteral(resourceName: "steve_jobs"), pages: [])
                            self.books?.append(book)
                        }
                    }
                   
                    // use the main thread to reload UI in safety
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let jsonError {
                    print("Failed to parse JSON property: ", jsonError)
                }
                
            }).resume()
        }
    }
    
}

