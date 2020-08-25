//
//  gyodokListView.swift
//  Bible
//
//  Created by jge on 2020/08/11.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct GyodokListView: View {
    @ObservedObject private var gyodokListVM = GyodokListViewModel()
    @State var search: String = ""
    @State var isSearching = false
    
    var gyodokSearching : [RealmGyodok] {
        RealmManager.shared.getGyodokFromSearch(search: search)
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $search, onEditingChanged: { changed in
                    if changed == false {
                        if self.search == "" {
                            self.isSearching = false
                        } else {
                            self.isSearching = true
                        }
                    }
                }).textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            List(isSearching ? gyodokSearching : gyodokListVM.gyodokList, id: \.id) { gyodok in
                NavigationLink(destination: GyodokDetailView(jang: gyodok.jang, title: gyodok.title)) {
                    Text(gyodok.title)
                }
            }
        }.navigationBarTitle(Text("교독문"), displayMode: .inline)
    }
}

struct gyodokListView_Previews: PreviewProvider {
    static var previews: some View {
        GyodokListView()
    }
}
