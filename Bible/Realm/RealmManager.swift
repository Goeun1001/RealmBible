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
    
    // MARK: Bible
    
    func getBibleLists(vcode: String, type: String) -> [RealmBible] {
        var bibleList: [RealmBible] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmBible.self).filter {$0.vcode == vcode}.filter {$0.type == type}
            bibleList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return bibleList
    }
    
    func getCustomBible(vcode: String, bcode: String, cnum: String) -> AnyPublisher<[RealmVerse], RealmError> {
        
        var verseList: [RealmVerse] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmVerse.self).filter {$0.vcode == vcode}.filter {$0.bcode == Int(bcode)}.filter {$0.cnum == cnum}
            verseList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return Just(verseList)
        .setFailureType(to: RealmError.self)
        .eraseToAnyPublisher()
    }
    
    func getNamefrombcode(vcode: String, bcode: String) -> AnyPublisher<RealmBible, RealmError> {
        var bible = RealmBible()
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmBible.self).filter {$0.vcode == vcode}.filter {$0.bcode == Int(bcode)}
            bible = result.first!
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return Just(bible)
        .setFailureType(to: RealmError.self)
        .eraseToAnyPublisher()
    }
    
    // MARK: For Bookmark
    func writeBookmarked(id: Int, bool: Bool) {        
        do {
            let realm = try Realm()
            
            try realm.write {
                let book = realm.objects(RealmVerse.self).filter {$0.id == id}.first
                book?.bookmarked = bool ? 1 : 0
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getVerse(vcode: String, bcode: String, cnum: String) -> [RealmVerse] {
        
        var verseList: [RealmVerse] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmVerse.self).filter {$0.vcode == vcode}.filter {$0.bcode == Int(bcode)}.filter {$0.cnum == cnum}
            verseList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return verseList
    }
    
    func getBookmarkedVerse(vcode: String) -> [RealmVerse] {
        
        var verseList: [RealmVerse] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmVerse.self).filter {$0.vcode == vcode}.filter {$0.bookmarked == 1}
            verseList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return verseList
    }
    
    // MARK: Gyodok
    
    func getGyodokALL() -> [RealmGyodok] {
        
        var gyodokList: [RealmGyodok] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmGyodok.self).filter {$0.sojul == 1}
            gyodokList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return gyodokList
    }
    
    func getGyodokFromJang(jang: Int) -> [RealmGyodok] {
        
        var gyodokList: [RealmGyodok] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmGyodok.self).filter {$0.jang == jang}
            gyodokList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return gyodokList
    }
    
    func getGyodokFromSearch(search: String) -> [RealmGyodok] {
        
        var gyodokList: [RealmGyodok] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmGyodok.self).filter("title CONTAINS '\(search)'").filter {$0.sojul == 1}
            gyodokList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return gyodokList
    }
    
    // MARK: Song
    
    func getSongALL() -> [RealmSong] {
        
        var songList: [RealmSong] = []
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmSong.self)
            songList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return songList
    }
    
    func getSongFromSearch(search: String) -> [RealmSong] {
        let realSch = String(search.components(separatedBy: ["장"]).joined())
        var songList: [RealmSong] = []
        do {
            let realm = try Realm()
            let result = realm.objects(RealmSong.self).filter("title CONTAINS '\(realSch)' OR number CONTAINS '\(realSch)'")
            songList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return songList
    }
}
