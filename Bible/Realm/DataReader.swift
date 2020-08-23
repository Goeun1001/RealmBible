//
//  fetch.swift
//  Bible
//
//  Created by jge on 2020/08/05.
//  Copyright © 2020 jge. All rights reserved.
//

import UIKit
import SQLite3
import RealmSwift

class DataReader {
    func readBibles(_ queryString: String) {
        var db: OpaquePointer?
        var stmt:OpaquePointer?
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("holybible.db")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let realmBibleItem = RealmBible()
            
            let id = sqlite3_column_int(stmt, 0)
            realmBibleItem.id = Int(id)
            
            let vcode = String(cString: sqlite3_column_text(stmt, 1))
            realmBibleItem.vcode = String(vcode)
            
            let bcode = sqlite3_column_int(stmt, 2)
            realmBibleItem.bcode = Int(bcode)
            
            let type = String(cString: sqlite3_column_text(stmt, 3))
            realmBibleItem.type = String(type)
            
            let name = String(cString: sqlite3_column_text(stmt, 4))
            realmBibleItem.name = String(name)
            
            let chapter_count = sqlite3_column_int(stmt, 5)
            realmBibleItem.chapterCount = Int(chapter_count)
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(realmBibleItem)
            }
        }
    }

    func readVerses(_ queryString: String) {
        var db: OpaquePointer?
        var stmt:OpaquePointer?
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("holybible.db")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let realmVerseItem = RealmVerse()
            
            let id = sqlite3_column_int(stmt, 0)
            realmVerseItem.id = Int(id)
            
            let vcode = String(cString: sqlite3_column_text(stmt, 1))
            realmVerseItem.vcode = String(vcode)
            
            let bcode = sqlite3_column_int(stmt, 2)
            realmVerseItem.bcode = Int(bcode)
            
            let cnum = String(cString: sqlite3_column_text(stmt, 3))
            realmVerseItem.cnum = String(cnum)
            
            let vnum = String(cString: sqlite3_column_text(stmt, 4))
            realmVerseItem.vnum = String(vnum)
            
            let content = String(cString: sqlite3_column_text(stmt, 5))
            realmVerseItem.content = String(content)
            
            let bookmarked = sqlite3_column_int(stmt, 6)
            realmVerseItem.bookmarked = Int(bookmarked)
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(realmVerseItem)
            }
        }
        
    }

    func readDaily(_ queryString: String) {
        var db: OpaquePointer?
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("holybible.db")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let realmDailyItem = RealmDaily()
            
            let id = sqlite3_column_int(stmt, 0)
            realmDailyItem.id = Int(id)
            
            let bible = String(cString: sqlite3_column_text(stmt, 1))
            realmDailyItem.bible = String(bible)
            
            let content = String(cString: sqlite3_column_text(stmt, 2))
            realmDailyItem.content = String(content)
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(realmDailyItem)
            }
        }
        
    }

    func readGyodok(_ queryString: String) {
        var db: OpaquePointer?
        var stmt:OpaquePointer?
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("holybible.db")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let realmGyodokItem = RealmGyodok()
            
            let id = sqlite3_column_int(stmt, 0)
            realmGyodokItem.id = Int(id)
            
            let jang = sqlite3_column_int(stmt, 1)
            realmGyodokItem.jang = Int(jang)
            
            let title = String(cString: sqlite3_column_text(stmt, 2))
            realmGyodokItem.title = String(title)
            
            let sojul = sqlite3_column_int(stmt, 3)
            realmGyodokItem.sojul = Int(sojul)
            
            let note = String(cString: sqlite3_column_text(stmt, 4))
            realmGyodokItem.note = String(note)
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(realmGyodokItem)
            }
        }
        
    }

    func readSong(_ queryString: String){
        var db: OpaquePointer?
        var stmt:OpaquePointer?
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("holybible.db")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let realmSongItem = RealmSong()
            
            let id = sqlite3_column_int(stmt, 0)
            realmSongItem.id = Int(id)
            
            let version = String(cString: sqlite3_column_text(stmt, 1))
            realmSongItem.version = String(version)
            
            let type = String(cString: sqlite3_column_text(stmt, 2))
            realmSongItem.type = String(type)
            
            let number = String(cString: sqlite3_column_text(stmt, 3))
            realmSongItem.number = String(number)
            
            let title = String(cString: sqlite3_column_text(stmt, 4))
            realmSongItem.title = String(title)
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(realmSongItem)
            }
        }
    }
}

extension DataReader {
    func setUpRealm() {
        readBibles("SELECT * FROM bibles")
        readVerses("SELECT * FROM verses")
        readDaily("SELECT * FROM todaybible")
        readSong("SELECT * FROM hymns")
        readGyodok("SELECT * FROM gyodok")
    }
}
