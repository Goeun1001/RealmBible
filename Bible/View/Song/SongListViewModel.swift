//
//  SongListViewModel.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class SongListViewModel: ObservableObject {
    
    @Published var songList = [RealmSong]()
    
    init() {
        getSong()
    }
    
    func getSong() {
        self.songList = RealmManager.shared.getSongALL()
    }
}
