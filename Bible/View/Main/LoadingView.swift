//
//  LoadingView.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    @EnvironmentObject var settings: LoadingSettings
    var body: some View {
        Text("Hi, please wait for load view")
            .onAppear() {
                DataReader().setUpRealm()
                UserDefaults.standard.set(true, forKey: "isLoaded")
                UserDefaults.standard.synchronize()
                self.settings.isLoaded = true
        }
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
