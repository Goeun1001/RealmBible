//
//  asdf.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SwipeBar : View {
    @State var index = 1
    @State var offset : CGFloat = UIScreen.main.bounds.width
    var width = UIScreen.main.bounds.width
    
    var body: some View{
        VStack(spacing: 0){
            AppBar(index: self.$index, offset: self.$offset)
                .padding(.top, 10)
            GeometryReader{g in
                HStack(spacing: 0){
                    First()
                        .frame(width: g.frame(in : .global).width)
                    
                    Scnd()
                        .frame(width: g.frame(in : .global).width)
                    
                    Third()
                        .frame(width: g.frame(in : .global).width)
                }
                .offset(x: self.offset)
                .highPriorityGesture(DragGesture()
                .onEnded({ value in
                    if value.translation.width > 50{
//                        print("right")
                        self.changeView(left: false)
                    }
                    if -value.translation.width > 50{
//                        print("left")
                        self.changeView(left: true)
                    }
                }))
            }
        }
        .navigationBarTitle("통독표")
        .animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
    
    func changeView(left : Bool){
        if left{
            if self.index != 3{
                self.index += 1
            }
        }
            
        else{
            if self.index != 0{
                self.index -= 1
            }
        }
        
        if self.index == 1{
            self.offset = self.width
        }
        
        else if self.index == 2{
            self.offset = 0
        }
            
        else{
            self.offset = -self.width
        }
    }
}

struct AppBar : View {
    @Binding var index : Int
    @Binding var offset : CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack(alignment: .center, content: {
            Text("통독표")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.bottom)
            
            HStack{
                Button(action: {
                    self.index = 1
                    self.offset = self.width
                }) {
                    
                    VStack(spacing: 8){
                        Text("Daily")
                            .foregroundColor(self.index == 1 ? .gray : Color.gray.opacity(0.7))
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.gray : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button(action: {
                    self.index = 2
                    self.offset = 0
                }) {
                    VStack(spacing: 8){
                        Text("구약")
                            .foregroundColor(self.index == 2 ? .gray : Color.gray.opacity(0.7))
                        
                        Capsule()
                            .fill(self.index == 2 ? Color.gray : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button(action: {
                    self.index = 3
                    self.offset = -self.width
                }) {
                    VStack(spacing: 8){
                        Text("신약")
                            .foregroundColor(self.index == 3 ? .gray : Color.gray.opacity(0.7))
                        
                        Capsule()
                            .fill(self.index == 3 ? Color.gray : Color.clear)
                            .frame(height: 4)
                    }
                }
            }
        })
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
            .padding(.horizontal)
            .padding(.bottom, 10)
    }
}

struct First : View {
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                Text("First View")
            }
        }
        .background(Color.white)
    }
}

struct Scnd : View {
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                Text("Second View")
            }
        }
        .background(Color.white)
    }
}

struct Third : View {
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                Text("Third View")
            }
        }
        .background(Color.white)
    }
}
