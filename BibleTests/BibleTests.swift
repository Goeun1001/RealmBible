//
//  BibleTests.swift
//  BibleTests
//
//  Created by jge on 2020/09/07.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest
import SQLite3

struct TestBibleModel: Hashable, Codable, Identifiable {
    var id: Int
    var vcode: String
    var bcode: Int
    var type: String
    var name: String
    var chapter_count: Int
    
    init(id: Int, vcode: String, bcode: Int, type: String, name: String, chapter_count: Int) {
        self.id = id
        self.vcode = vcode
        self.bcode = bcode
        self.type = type
        self.name = name
        self.chapter_count = chapter_count
    }
}

var TestBible = TestBibleModel(id: 0, vcode: "", bcode: 0, type: "", name: "", chapter_count: 0)

class BibleTests: XCTestCase {
    
    func test_db_copy() {
        let fileManager = FileManager.default
        
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let finalDatabaseURL = documentsUrl.appendingPathComponent("holybible.db")
        
        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "holybible", ofType: "db") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                    
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }
    }
    
    func test_db_open() {
        
        let queryString = "SELECT * FROM bibles where name = '창세기'"
        var db: OpaquePointer?
        var stmt: OpaquePointer?
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("holybible.db")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            XCTFail("error opening database")
        }
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            XCTFail("error preparing insert: \(errmsg)")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let vcode = String(cString: sqlite3_column_text(stmt, 1))
            let bcode = sqlite3_column_int(stmt, 2)
            let type = String(cString: sqlite3_column_text(stmt, 3))
            let name = String(cString: sqlite3_column_text(stmt, 4))
            let chapter_count = sqlite3_column_int(stmt, 5)
            TestBible = TestBibleModel(id: Int(id), vcode: vcode, bcode: Int(bcode), type: type, name: name, chapter_count: Int(chapter_count))
        }
        
        XCTAssertEqual(1, TestBible.id)
        XCTAssertEqual("GAE", TestBible.vcode)
        XCTAssertEqual(1, TestBible.bcode)
        XCTAssertEqual("old", TestBible.type)
        XCTAssertEqual("창세기", TestBible.name)
        XCTAssertEqual(50, TestBible.chapter_count)
        
    }
    
}
