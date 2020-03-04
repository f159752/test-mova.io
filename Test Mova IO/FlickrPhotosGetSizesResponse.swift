//
//  FlickrPhotosGetSizesResponse.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

struct FlickrPhotosGetSizesResponse: Codable {
    var sizes: Sizes
    var stat: String
}

struct Sizes: Codable {
    var size: [Size]
}

struct Size: Codable {
    var label: String
    var width: Int
    var height: Int
    var source: String
    var url: String
    var media: String
    
}

