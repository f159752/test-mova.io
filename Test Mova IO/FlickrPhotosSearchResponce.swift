//
//  FlickrPhotosSearchResponce.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

struct FlickrPhotosSearchResponce: Codable {
    var photos: Photos
    var stat: String
}

struct Photos: Codable{
    var page: Int
    var pages: Int
    var perpage: Int
    var total: String
    var photo: [Photo]
}

struct Photo: Codable {
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: Int
    var isfriend: Int
    var isfamily: Int
}

