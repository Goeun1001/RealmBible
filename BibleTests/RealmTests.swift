//
//  RealmTests.swift
//  BibleTests
//
//  Created by jge on 2020/09/07.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Daily_Bible

class RealmTests: XCTestCase {
    
    func test_add_realm_success() {
        let realmBibleItem = RealmBible()
        var bibleList = [RealmBible]()
        
        realmBibleItem.id = TestBible.id
        realmBibleItem.bcode = TestBible.bcode
        realmBibleItem.vcode = TestBible.vcode
        realmBibleItem.type = TestBible.type
        realmBibleItem.name = TestBible.name
        realmBibleItem.chapterCount = TestBible.chapter_count
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(realmBibleItem)
        }
        
        do {
            let realm = try Realm()
            let result = realm.objects(RealmBible.self).filter {$0.name == "창세기"}
            bibleList = result.map {$0}
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        XCTAssertEqual(1, bibleList[0].id)
        XCTAssertEqual("GAE", bibleList[0].vcode)
        XCTAssertEqual(1, bibleList[0].bcode)
        XCTAssertEqual("old", bibleList[0].type)
        XCTAssertEqual("창세기", bibleList[0].name)
        XCTAssertEqual(50, bibleList[0].chapterCount)
        
    }
    
}
