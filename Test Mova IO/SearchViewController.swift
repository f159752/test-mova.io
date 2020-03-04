//
//  ViewController.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchController = UISearchController(searchResultsController: nil)
    let tableView: UITableView = {
        let tab = UITableView()
        tab.translatesAutoresizingMaskIntoConstraints = false
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func setupUI(){
        self.view.backgroundColor = .white
        self.navigationItem.title = "Search history"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate(
            [self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
             self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
             self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
             self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]
        )
    }
    
    func showPhotoViewController(item: HistoryItem){
        let photoViewController = PhotoViewController()
        photoViewController.historyItem = item
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }


}


extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = History.shared.history[indexPath.row]
        self.showPhotoViewController(item: item)
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return History.shared.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = History.shared.history[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.imageView?.image = item.getImage()
        cell.textLabel?.text = item.text
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
//        print(text)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Flickr.shared.searchPhotos(text: text) { (image, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            guard let image = image else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Sorry", message: "Pictures on this request is not found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        searchBar.becomeFirstResponder()
                    }))
                    if let presentedVC = self.presentedViewController {
                        presentedVC.present(alert, animated: true, completion: nil)
                    } else {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                return
            }
            let newHistoryItem = HistoryItem()
            newHistoryItem.text = text
            newHistoryItem.imageData = image.pngData()
            History.shared.addToHistory(newHistoryItem)

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.showPhotoViewController(item: newHistoryItem)
            }
        }

    }
}
