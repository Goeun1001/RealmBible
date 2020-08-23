//
//  SongListView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SongListView: View {
    
    @ObservedObject private var songListVM = SongListViewModel()
    @State var search: String = ""
    @State var isSearching = false
    
    var songSearching : [RealmSong] {
        RealmManager.shared.getSongFromSearch(search: search)
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
            List(isSearching ? songSearching : songListVM.songList, id: \.id) { song in
                NavigationLink(destination: SongDetailView(number: song.number, name: song.title)) {
                    Text("\(song.number)장 \(song.title)")
                }
            }
        }.navigationBarTitle(Text("찬송가"), displayMode: .inline)
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
    }
}
