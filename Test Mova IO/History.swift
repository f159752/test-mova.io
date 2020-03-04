//
//  History.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import RealmSwift

class History{
    static let shared = History()
    var history: Results<HistoryItem>!
    
    private init(){
        if let realm = try? Realm(){
            history = realm.objects(HistoryItem.self).sorted(byKeyPath: "date", ascending: false)
        }
    }
    
    func addToHistory(_ item: HistoryItem){
        guard let realm = try? Realm() else { return }
        try! realm.write {
            realm.add(item)
        }
    }
    
    
}

