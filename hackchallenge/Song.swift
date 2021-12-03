//
//  Song.swift
//  hackchallenge
//
//  Created by Kaden Lei on 11/30/21.
//
import Foundation
import UIKit

class Song {
    var name: String
    var artist: String
    
    init(name: String, artist: String) {
        self.name = name
        self.artist = artist
    }
    
}

struct SpotifyResponse: Codable {
    var items: [TrackResponse]
}

struct TrackResponse: Codable {
    var track: Track
}

struct Track: Codable {
    var album: Album // change String
    var id: String
    var name: String
    // add artist String
}

struct Album: Codable {
    var artists: [Artist]
    var id: String
    var name: String
}

struct Artist: Codable {
    var id: String
    var name: String
}
