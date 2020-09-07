//
//  SettingUp.swift
//  Bible
//
//  Created by jge on 2020/09/07.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class SettingUp {
    func setUp() {
        DataReader().setUpRealm()
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
