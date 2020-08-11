//
//  LoadingView.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct LoadingBaseView: View {
    @EnvironmentObject var settings: LoadingSettings
    
    var body: some View {
        LoadingView(isShowing: .constant(true)) {
            Text("Hi, please wait for load view")
            }
            .onAppear() {
                DataReader().setUpRealm()
                UserDefaults.standard.set("GAE", forKey: "vcode")
                UserDefaults.standard.set("1", forKey: "bcode")
                UserDefaults.standard.set("1", forKey: "cnum")
                UserDefaults.standard.set("old", forKey: "type")
                UserDefaults.standard.set(true, forKey: "isLoaded")
                UserDefaults.standard.synchronize()
                self.settings.isLoaded = true
        }
    }
    
}

struct LoadingBaseView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBaseView()
    }
}
