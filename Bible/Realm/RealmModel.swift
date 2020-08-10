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
    dynamic var id = 0
    dynamic var bible = ""
    dynamic var content = ""
}

class RealmGyodok: Object {
    dynamic var id = 0
    dynamic var jang = 0
    dynamic var title = ""
    dynamic var sojul = 0
    dynamic var note = ""
}

class RealmSong: Object {
    dynamic var id = 0
    dynamic var version = ""
    dynamic var type = ""
    dynamic var number = 0
    dynamic var title = ""
}

