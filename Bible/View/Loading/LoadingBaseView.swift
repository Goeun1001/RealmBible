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
    @State private var hasTimeElapsed = false
    
    var body: some View {
        isLoadingView(isShowing: .constant(true)) {
            Image("Stub")
            .resizable()
                .aspectRatio(contentMode: .fill)
            }
            .onAppear(perform: delay)
    }
    private func delay() {
        // Delay of 7.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.hasTimeElapsed = true
            DataReader().setUpRealm()
            UserDefaults.standard.set("GAE", forKey: "vcode")
            UserDefaults.standard.set("1", forKey: "bcode")
            UserDefaults.standard.set("1", forKey: "cnum")
            UserDefaults.standard.set("old", forKey: "type")
            UserDefaults.standard.set(true, forKey: "isLoaded")
            UserDefaults.standard.set(true, forKey: "isChanged")
            UserDefaults.standard.set(0, forKey: "selectedIndex")
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
