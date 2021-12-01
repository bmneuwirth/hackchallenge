//
//  Playlist.swift
//  hackchallenge
//
//  Created by Matthew Sadowski on 11/20/21.
//


import Foundation
import UIKit

class Playlist {
    var isSelected2: Bool
    var PlaylistTitle: String
    var songs: [Song]
    

    init (Playlist: String, Songs: [Song]) {
        self.songs = Songs
        self.PlaylistTitle = Playlist
        self.isSelected2 = false;
    }
    }

