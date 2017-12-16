//
//  ProductViewController.swift
//  shopifyProduct
//
//  Created by Tianyi Zhang on 2017-12-15.
//  Copyright © 2017 Tianyi Zhang. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class ProductViewController: UIViewController {

    var product : Product?
    
    
//    @IBOutlet weak var productTitleLabel: UILabel!
//    @IBOutlet weak var productImageView: UIImageView!
    
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productTagsLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productTitleLabel.text = product?.title
        productDescriptionLabel.text = product?.body_html
        
        productTypeLabel.text =
        "Product Type: \((product?.product_type)!)"
        productTagsLabel.text = "Product Tags: \((product?.tags)!)"
        
        let urlString = product?.images[0].src
        let url = URL(string: urlString!)
        productImageView.downloadedFrom(url: url!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
