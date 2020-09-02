//
//  BookmarkedView.swift
//  Bible
//
//  Created by jge on 2020/08/24.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct BookmarkedView: View {
    
    @ObservedObject private var verseVM = VerseViewModel()
    
    var body: some View {
        List {
            ForEach(self.verseVM.markedverses, id: \.self) { verse in
                HStack {
                    VStack(spacing: 7) {
                        Text(verse.content)
                            .font(.custom("NanumSquareB", size: 20))
                        HStack {
                            if UserDefaults.standard.value(forKey: "vcode") as! String == "NIV" {
                                Text(englishBibles[verse.bcode - 1])
                                    .fixedSize(horizontal: true, vertical: false)
                            } else {
                                Text(koreaBibles[verse.bcode - 1])
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            Text("\(verse.cnum)장")
                                .fixedSize(horizontal: true, vertical: false)
                            Text("\(verse.vnum)절")
                                .fixedSize(horizontal: true, vertical: false)
                                .font(.custom("NanumSquareL", size: 15))
                        }
                    }
                    Spacer()
                    LikeLottie(filename: "like")
                        .frame(width: 25, height: 25)
                }.onTapGesture(count: 2) {
                    self.verseVM.LikeChange(id: verse.id)
                }
            }
        }.onAppear {
            self.verseVM.getBookmarked()
        }
        .navigationBarTitle("북마크함")
    }
}

struct BookmarkedView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedView()
    }
}
