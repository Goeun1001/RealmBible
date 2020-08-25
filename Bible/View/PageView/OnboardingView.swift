//
//  OnboardingView.swift
//  SwiftUIWorkingDemo
//
//  Created by mac-00015 on 18/10/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

let lightblueColor = Color(red: 85.0/255.0, green: 84.0/255.0, blue: 166.0/255.0, opacity: 1.0)

import SwiftUI

struct OnboardingView: View {

    var subViews = [
        UIHostingController(rootView: Subview(imageString: "First")),
        UIHostingController(rootView: Subview(imageString: "Second")),
        UIHostingController(rootView: Subview(imageString: "Third"))
    ]

    var titles = ["First", "Second", "Third"]

    var captions =  ["This is first screen.", "This is second screen.", "This is third screen."]

    @State var currentPageIndex = 0
//    @EnvironmentObject var dataOnboard: DataOnboarding
    @EnvironmentObject var settings: LoadingSettings
    @State private var hasTimeElapsed = false

    var body: some View {
        VStack(alignment: .leading) {

            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subViews)
                .frame(height: (UIScreen.main.bounds.width * 500) / 414)

            Spacer()

            Group {

                Text(titles[currentPageIndex])
                    .font(.title)

                Text(captions[currentPageIndex])
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 50, alignment: .leading)
                    .lineLimit(nil)
            }.padding([.leading, .trailing])

            HStack {

                PageControl(numberOfPages: subViews.count, currentPageIndex: $currentPageIndex)

                Spacer()

                Button(action: {
                    if self.currentPageIndex + 1 == self.subViews.count {
//                        self.settings.isLoaded = true
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(lightblueColor)
                        .clipShape(Circle())
                }
            }.padding()
        }.onAppear(perform: delay)
    }
    
    private func delay() {
        // Delay of 7.5 seconds
//        DispatchQueue.Concurrent.asyncAfter
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
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

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
