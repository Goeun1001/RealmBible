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
        UIHostingController(rootView: Subview(imageString: "Third")),
        UIHostingController(rootView: Subview(imageString: "Fourth")),
        UIHostingController(rootView: Subview(imageString: "Loading"))
    ]
    
    var titles = ["북마크", "구절 선택", "통독표", "데일리", "로딩중..."]
    
    var captions =  ["구절을 두 번 누르면 북마크할 수 있습니다.", "상단 버튼으로 구절 이동을 할 수 있습니다.", "통독표가 생겼습니다! 왼쪽으로 스와이프 시 전체 읽음, 오른쪽으로 스와이프 시 리셋됩니다.", "통독표의 Daily 탭으로 매일 관리하고 싶은 목록을 만들 수 있습니다.", "앱 최초 실행 시에만 로딩됩니다. 튜토리얼을 오랫동안 읽는다면 바로 실행될지도 모르죠!"]
    
    let setting = SettingUp()
    
    @State var currentPageIndex = 0
    @EnvironmentObject var settings: LoadingSettings
    @Environment(\.colorScheme) var colorScheme
    @State private var isLoaded = false
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .leading) {
                
                PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subViews)
                    .frame(height: UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 3))
                
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
                            self.isLoaded = true
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
            
            if self.isLoaded {
                isLoadingView(isShowing: .constant(true)) {
                    Text("")
                }
            }
        }
        
    }
    
    private func delay() {
        // Delay of 7.5 seconds
        //        DispatchQueue.Concurrent.asyncAfter
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
//            self.hasTimeElapsed = true
            self.setting.setUp()
            
            if self.isLoaded {
                DispatchQueue.main.async {
                    self.settings.isLoaded = true
                }
            }
            
        }
        
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
