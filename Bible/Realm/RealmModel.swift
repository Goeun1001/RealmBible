//
//  RealmModel.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import RealmSwift
 
class RealmBible: Object {
    @objc dynamic var id = 0
    @objc dynamic var vcode = ""
    @objc dynamic var bcode = 0
    @objc dynamic var type = ""
    @objc dynamic var name = ""
    @objc dynamic var chapterCount = 0
}

class RealmVerse: Object {
    @objc dynamic var id = 0
    @objc dynamic var vcode = ""
    @objc dynamic var bcode = 0
    @objc dynamic var cnum = ""
    @objc dynamic var vnum = ""
    @objc dynamic var content = ""
    @objc dynamic var bookmarked = 0
}

class RealmDaily: Object {
    @objc dynamic var id = 0
    @objc dynamic var bible = ""
    @objc dynamic var content = ""
}

class RealmGyodok: Object {
    @objc dynamic var id = 0
    @objc dynamic var jang = 0
    @objc dynamic var title = ""
    @objc dynamic var sojul = 0
    @objc dynamic var note = ""
}

class RealmSong: Object {
    @objc dynamic var id = 0
    @objc dynamic var version = ""
    @objc dynamic var type = ""
    @objc dynamic var number = ""
    @objc dynamic var title = ""
}
