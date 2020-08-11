//
//  RealmManager.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import RealmSwift
import Combine

class RealmManager {
    
    static let shared = RealmManager()
    
    func getBibleLists(vcode: String, type: String) -> [RealmBible] {
        var bibleList : [RealmBible] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmBible.self).filter{$0.vcode == vcode}.filter{$0.type == type}
            bibleList = result.map{$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return bibleList
    }
    
    func getCustomBible(vcode: String, bcode: String, cnum: String) -> AnyPublisher<[RealmVerse], RealmError> {
        print(cnum)
        var verseList : [RealmVerse] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmVerse.self).filter{$0.vcode == vcode}.filter{$0.bcode == Int(bcode)}.filter{$0.cnum == cnum}
            verseList = result.map{$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return Just(verseList)
        .setFailureType(to: RealmError.self)
        .eraseToAnyPublisher()
//        return verseList
    }
    
    func getNamefrombcode(bcode: String) -> AnyPublisher<RealmBible, RealmError> {
        var bible = RealmBible()
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmBible.self).filter{$0.bcode == Int(bcode)}
            bible = result.first!
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return Just(bible)
        .setFailureType(to: RealmError.self)
        .eraseToAnyPublisher()
    }
}
