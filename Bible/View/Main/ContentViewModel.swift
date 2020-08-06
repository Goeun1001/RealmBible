//
//  ContentViewModel.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import RealmSwift

class BibleListViewModel: ObservableObject {
    
    @Published var bibles = [BibleViewModel]()
    
    init() {
//        getBible()
    }
    
    func getBible() -> RealmBible? {
        let realm = try! Realm()
        let result = realm.objects(RealmBible.self).filter("id == 1")
        return result.first
    }
}

class BibleViewModel {
    
    var bible: RealmBible
    
    init(bible: RealmBible) {
        self.bible = bible
    }
    
    var id: Int {
        return self.id
    }
    
    var vcode: String {
        return self.bible.vcode
    }
    
    var bcode: Int {
        return self.bible.bcode
    }
    
    var type: String {
        return self.bible.type
    }
    
    var name: String {
        return self.bible.name
    }
    
    var chapterCount: Int {
        return self.bible.chapterCount
    }
}
