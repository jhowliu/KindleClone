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
       
        setupNavBarStyles()
        setupNavBarButtons()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        // Remove the unusable bottom line
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        navigationItem.title = "All Items"
        
        fetchBooks()
    }
    
    func setupNavBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPressed))
    }
    
    func setupNavBarStyles() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        // Navigation bars are translucent by default; that is, their background color is semitransparent
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        let segmentControl = UISegmentedControl(items: ["Cloud", "Device"])
        segmentControl.tintColor = .lightGray
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(segmentControl)
        
        segmentControl.widthAnchor.constraint(equalToConstant: 180).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
       
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "gird").withRenderingMode(.alwaysOriginal), for: .normal)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(gridButton)
        
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 20).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: 0).isActive = true
        
        
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(sortButton)
      
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -20).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: 0).isActive = true
        
        return footerView
    }
   
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func handleMenuPressed() {
        print("Menu pressed")
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
        return self.books?.count ?? 0
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
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
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

