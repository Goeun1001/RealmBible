//
//  BibleList.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct BibleListView: View {
    
    let bibles: [BibleViewModel]
    
    init(bibles: [BibleViewModel]) {
        self.bibles = bibles
    }
    
    var body: some View {
        List(self.bibles, id:\.name) { bible in
            HStack {
                Text(bible.name)
            }
        }
    }
}

struct BibleListView_Previews: PreviewProvider {
    static var previews: some View {
        BibleListView(bibles: .init())
    }
}
