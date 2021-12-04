//
//  Playlist.swift
//  hackchallenge
//
//  Created by Matthew Sadowski on 11/20/21.
//

import Foundation
import UIKit

class Playlist {
    var isSelected: Bool
    var PlaylistTitle: String
    var songs: [Song]
    var imageName: String
    

    init (Playlist: String, imageName: String, Songs: [Song]) {
        self.songs = Songs
        self.isSelected = true
        self.PlaylistTitle = Playlist
        self.isSelected = false;
        self.imageName = imageName

    }
    func getImage() -> UIImage {
        let imageName = isSelected ? (imageName) : imageName
        guard let image = UIImage(named: imageName) else { return UIImage() }
        return image
    }
    func setSongs(songs: [Song]) {
        self.songs = songs
    }
}
