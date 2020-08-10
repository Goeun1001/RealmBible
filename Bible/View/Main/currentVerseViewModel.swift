//
//  currentBibleViewModel.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class currentVerseViewModel: ObservableObject {
    
    @Published var verses = [VerseViewModel]()
    
    init() {
        getVerse()
    }
    
    func getVerse() {
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let bibles = RealmManager.shared.getCustomBible(vcode: vcode, bcode: bcode)
        self.verses = bibles.map(VerseViewModel.init)
    }
}

class VerseViewModel {
    
    var verse: RealmVerse
    
    init(verse: RealmVerse) {
        self.verse = verse
    }
    
    var vcode: String {
        return self.verse.vcode
    }
    
    var bcode: Int {
        return self.verse.bcode
    }
    
    var cnum: String {
        return self.verse.cnum
    }
    
    var vnum: String {
        return self.verse.vnum
    }
    
    var content: String {
        return self.verse.content
    }
    
    var bookmarked: Int {
        return self.verse.bookmarked
    }
}
