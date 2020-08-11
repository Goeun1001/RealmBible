//
//  currentVerseView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct currentVerseView: View {
    
    @ObservedObject private var verseVM = currentVerseViewModel()
    
    @State private var show_modal: Bool = false
    
    var body: some View {
        NavigationView {
            List(verseVM.verses, id:\.id) { verse in
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
            .onAppear() {
                self.verseVM.apply(.onAppear)
                print("mainView")
            }
            .navigationBarTitle(Text("\(verseVM.bibleName.name) \(self.verseVM.verses.first?.cnum ?? "0")장"))
            .navigationBarItems(trailing:
                HStack(spacing: 20) {
                    NavigationLink(destination: BibleListView()) {
                        imageView(imageName: "square.grid.2x2")
                    }
                    imageView(imageName: "arrowtriangle.left.fill")
                    imageView(imageName: "arrowtriangle.right.fill")
                })
        }
        
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

//struct currentVerseView_Previews: PreviewProvider {
//    static var previews: some View {
//        currentVerseView(verses: .init(), bibleName: "창세ㄱ")
//    }
//}
