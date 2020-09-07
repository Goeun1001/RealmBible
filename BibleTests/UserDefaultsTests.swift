//
//  UserDefaultsTests.swift
//  BibleTests
//
//  Created by jge on 2020/09/07.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Daily_Bible

class UserDefaultsTests: XCTestCase {
    
    @ObservedObject private var verseVM = VerseViewModel()
    let setting = SettingUp()
    
    func test_setup() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            self.setting.setUp()
            XCTAssertEqual(UserDefaults.standard.value(forKey: "isChanged") as! Bool, true)
            XCTAssertEqual(UserDefaults.standard.value(forKey: "selectedIndex") as! Int, 0)
            XCTAssertEqual(UserDefaults.standard.value(forKey: "isLoaded") as! Bool, true)
            XCTAssertEqual(UserDefaults.standard.value(forKey: "type") as! String, "old")
            XCTAssertEqual(UserDefaults.standard.value(forKey: "cnum") as! String, "1")
            XCTAssertEqual(UserDefaults.standard.value(forKey: "bcode") as! String, "1")
            XCTAssertEqual(UserDefaults.standard.value(forKey: "vcode") as! String, "GAE")
        }
    }
    
    func test_viewModel_setUp() {
        viewModelSetUp()
        
        verseVM.apply(.onAppear)
  
        XCTAssertEqual("태초에 하나님이 천지를 창조하시니라", verseVM.verses[0].content)
        verseVM.LikeChange(id: 1, bool: false)
        XCTAssertEqual(0, verseVM.verses[0].bookmarked)

        verseVM.LikeChange(id: 1, bool: true)
        XCTAssertEqual(1, verseVM.verses[0].bookmarked)
    }
    
    func test_bible_changed() {
        UserDefaults.standard.set("GAE", forKey: "vcode")
        UserDefaults.standard.set("1", forKey: "bcode")
        UserDefaults.standard.set("2", forKey: "cnum")
        UserDefaults.standard.set(true, forKey: "isChanged")
        UserDefaults.standard.synchronize()
        
        verseVM.apply(.onAppear)
        
        if UserDefaults.standard.value(forKey: "isChanged") as! Bool == true {
            XCTAssertEqual("천지와 만물이 다 이루어지니라", verseVM.verses[0].content)
            UserDefaults.standard.set(false, forKey: "isChanged")
        } else {
            XCTFail("isChanged didn't be setted.")
        }
    }
    
    func test_english_changed() {
        UserDefaults.standard.set("NIV", forKey: "vcode")
        UserDefaults.standard.set(true, forKey: "isChanged")
        UserDefaults.standard.synchronize()
        
        verseVM.apply(.onAppear)
        
        if UserDefaults.standard.value(forKey: "isChanged") as! Bool == true {
            XCTAssertEqual("Thus the heavens and the earth were completed in all their vast array.", verseVM.verses[0].content)
        } else {
            XCTFail("isChanged didn't be setted.")
        }
    }

    func viewModelSetUp() {
        UserDefaults.standard.set("GAE", forKey: "vcode")
        UserDefaults.standard.set("1", forKey: "bcode")
        UserDefaults.standard.set("1", forKey: "cnum")
        UserDefaults.standard.set("old", forKey: "type")
        UserDefaults.standard.set(true, forKey: "isLoaded")
        UserDefaults.standard.set(true, forKey: "isChanged")
        UserDefaults.standard.set(0, forKey: "selectedIndex")
        UserDefaults.standard.synchronize()
    }
}
