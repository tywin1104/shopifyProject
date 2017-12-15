
//  Product.swift
//  shopifyProduct
//
//  Created by Tianyi Zhang on 2017-12-15.
//  Copyright © 2017 Tianyi Zhang. All rights reserved.
//

import Foundation

struct Product :Decodable {
    var body_html : String
    var images : [ProductImage] 
    var title : String
}

