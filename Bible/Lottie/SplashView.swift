//
//  SplashView.swift
//  Bible
//
//  Created by jge on 2020/08/24.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                VerseView()
            } else {
                LottieView(filename: "bible")
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}
