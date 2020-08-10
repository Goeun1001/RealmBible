//
//  RealmManager.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    func getAllBibles() -> [RealmBible] {
        var bibleLsit : [RealmBible] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmBible.self)
            bibleLsit = result.map{$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return bibleLsit
    }
    
    func getKoreaBibleLists() -> [RealmBible] {
        var bibleLsit : [RealmBible] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmBible.self).filter{$0.vcode == "GAE"}
            bibleLsit = result.map{$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return bibleLsit
    }
    
    func getCustomBible(vcode: String, bcode: String) -> [RealmVerse] {
        var verseLsit : [RealmVerse] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmVerse.self).filter{$0.vcode == vcode}.filter{$0.bcode == Int(bcode)}
            verseLsit = result.map{$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return verseLsit
    }
}
