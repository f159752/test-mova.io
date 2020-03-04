//
//  HistoryItem.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryItem: Object{
    @objc dynamic var text: String = ""
    @objc dynamic var imageData: Data?
    @objc dynamic var date: Date = Date()
    
    func getImage() -> UIImage?{
        guard let data = self.imageData else {
            return nil
        }
        return UIImage.init(data: data)
    }
}
