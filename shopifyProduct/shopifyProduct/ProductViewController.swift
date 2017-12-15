//
//  ProductViewController.swift
//  shopifyProduct
//
//  Created by Tianyi Zhang on 2017-12-15.
//  Copyright © 2017 Tianyi Zhang. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    var product : Product?
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productTitleLabel.text = product?.title
        productDescriptionLabel.text = product?.body_html
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
