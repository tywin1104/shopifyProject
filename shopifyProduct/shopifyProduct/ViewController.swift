//
//  ViewController.swift
//  shopifyProduct
//
//  Created by Tianyi Zhang on 2017-12-15.
//  Copyright © 2017 Tianyi Zhang. All rights reserved.
//

import UIKit

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var products = [Product]()
    var filteredProducts = [Product]()
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadJSON {
            self.tableView.reloadData()
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search For Product Titles"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredProducts = products.filter({( product : Product) -> Bool in
            return product.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredProducts.count
        }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        var product : Product
        if isFiltering() {
            product = filteredProducts[indexPath.row]
        }else {
            product = products[indexPath.row]
        }
        cell.productTitleLabel.text = product.title
        cell.productDescriptionLabel.text = product.body_html
        
        let urlString = product.images[0].src
        let url = URL(string: urlString)
        cell.productImageView.downloadedFrom(url: url!)
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height/2
        cell.productImageView.layer.cornerRadius = cell.productImageView.frame.height/2
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductViewController {
            destination.product = products[(tableView.indexPathForSelectedRow?.row)!]
            if isFiltering() {
                destination.product = filteredProducts[(tableView.indexPathForSelectedRow?.row)!]
            } else {
                destination.product = products[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadJSON(completed:@escaping ()->()) {
        let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error == nil {
                do {
                    var pageJSON = try JSONDecoder().decode(shopifyAPI.self, from: data!)
                    self.products = pageJSON.products        
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("JSON ERROR!")
                }
            }
        }.resume()
    }

}

