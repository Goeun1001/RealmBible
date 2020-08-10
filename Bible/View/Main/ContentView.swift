//
//  ContentView.swift
//  Bible
//
//  Created by jge on 2020/08/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var bibleListVM = BibleListViewModel()
    @ObservedObject private var currentVerseVM = currentVerseViewModel()
    
    var body: some View {
        NavigationView {
        
            currentVerseView(verses: self.currentVerseVM.verses)
//        BibleListView(bibles: self.bibleListVM.bibles)
         
            .navigationBarTitle("Bible List")
        }
          
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
