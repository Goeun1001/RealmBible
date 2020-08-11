//
//  currentVerseView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct VerseView: View {
    
    @ObservedObject private var verseVM = VerseViewModel()
    @State private var show_modal: Bool = false
    
    @State private var offset = CGSize.zero
    @State private var float = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                GeometryReader { _ in
                    List(self.verseVM.verses, id:\.id) { verse in
                        HStack {
                            VStack {
                                Text(verse.vnum)
                                    .font(.custom("NanumSquareL", size: 20))
                                Spacer()
                            }
                            Text(verse.content)
                                .font(.custom("NanumSquareB", size: 18))
                        }
                    }
                }.gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                            print(self.offset.height)
                            if self.offset.height > 0 {
                                self.float = true
                            } else if (self.offset.height < 0) {
                                self.float = false
//                                self.offset = .zero
                            }
                    }
                        
                    .onEnded { _ in
                        print("isEnded")
                        
                    }
                )
                
                if float {
                    FloatingTabbar()
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                }
            }
            .onAppear() {
                self.verseVM.apply(.onAppear)
            }
            .navigationBarTitle(Text("\(verseVM.bibleName.name) \(self.verseVM.verses.first?.cnum ?? "0")장"))
            .navigationBarItems(trailing:
                HStack(spacing: 20) {
                    NavigationLink(destination: BibleListView()) {
                        imageView(imageName: "square.grid.2x2")
                    }
                    imageView(imageName: "arrowtriangle.left.fill")
                        .onTapGesture {
                            if (Int(self.verseVM.verses.first!.cnum)! - 1 != 0) {
                                let minus = Int(self.verseVM.verses.first!.cnum)! - 1
                                UserDefaults.standard.set("\(minus)", forKey: "cnum")
                                UserDefaults.standard.synchronize()
                                self.verseVM.apply(.onAppear)
                            }
                    }
                    imageView(imageName: "arrowtriangle.right.fill")
                        .onTapGesture {
                            if (Int(self.verseVM.verses.first!.cnum)! + 1 != self.verseVM.bibleName.chapterCount + 1) {
                                let plus = Int(self.verseVM.verses.first!.cnum)! + 1
                                UserDefaults.standard.set("\(plus)", forKey: "cnum")
                                UserDefaults.standard.synchronize()
                                self.verseVM.apply(.onAppear)
                            }
                    }
            })
        }
        
    }
    
}

struct currentVerseView_Previews: PreviewProvider {
    static var previews: some View {
        VerseView()
    }
}

struct imageView : View {
    let imageName: String
    var body: some View {
        Image(systemName: "\(imageName)")
            .resizable()
            .frame(width: 20, height: 20)
    }
}
