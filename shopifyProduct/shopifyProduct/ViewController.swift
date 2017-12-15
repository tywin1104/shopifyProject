//
//  ViewController.swift
//  shopifyProduct
//
//  Created by Tianyi Zhang on 2017-12-15.
//  Copyright © 2017 Tianyi Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var products = [Product]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadJSON {
            self.tableView.reloadData()
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.productTitleLabel.text = products[indexPath.row].title
        cell.productDescriptionLabel.text = products[indexPath.row].body_html
        return cell
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

