//
//  currentVerseView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct currentVerseView: View {
    
    let verses: [VerseViewModel]
       
       init(verses: [VerseViewModel]) {
           self.verses = verses
       }
    
    var body: some View {
        List(self.verses, id:\.content) { verse in
            HStack {
                Text(verse.content)
            }
        }
    }
}

struct currentVerseView_Previews: PreviewProvider {
    static var previews: some View {
        currentVerseView(verses: .init())
    }
}
