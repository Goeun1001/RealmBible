//
//  SettingView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @State private var select = UserDefaults.standard.value(forKey: "selectedIndex") as! Int
    @State private var optionsTitle = ["한", "영"]
    @State private var showingAlert = false
    
    var body: some View {
        List {
            Section(header: Text("환경설정")) {
                HStack {
                    Text("성경 한/영 전환")
                    Spacer()
                    Picker("Articles", selection: $select) {
                        ForEach(0 ..< optionsTitle.count) { index in
                            Text(self.optionsTitle[index])
                        }
                    }.onReceive([self.select].publisher.first(), perform: { (value) in
                        if value == 0 {
                            UserDefaults.standard.set("GAE", forKey: "vcode")
                            UserDefaults.standard.set(true, forKey: "isChanged")
                            UserDefaults.standard.set(0, forKey: "selectedIndex")
                            UserDefaults.standard.synchronize()
                        } else {
                            UserDefaults.standard.set("NIV", forKey: "vcode")
                            UserDefaults.standard.set(true, forKey: "isChanged")
                            UserDefaults.standard.set(1, forKey: "selectedIndex")
                            UserDefaults.standard.synchronize()
                        }
                    })
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 90)
                }
                NavigationLink(destination: BookmarkedView()) {
                    Text("북마크함")
                }
            }
            Section(header: Text("통독표")) {
                Text("통독표 초기화").onTapGesture {
                    self.showingAlert = true
                }.alert(isPresented: $showingAlert) { () -> Alert in
                    Alert(title: Text("통독표를 초기화하시겠습니까?"), primaryButton: .default(Text("YES"), action: {
                        SecondRealmManager.shared.changeAllDelete(isRead: false)
                    }), secondaryButton: .cancel())
                }
            }
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
