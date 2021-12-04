//
//  NetworkManager.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 11/30/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "https://pulsepulse.herokuapp.com"
    
    static func getRecentlyPlayed(token: String, completion: @escaping ([TrackResponse]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        let parameters: [String: String] = [
            "limit": "50"
        ]
        AF.request("https://api.spotify.com/v1/me/player/recently-played", method: .get, parameters: parameters, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let data = try? jsonDecoder.decode(SpotifyResponse.self, from: data) {
                    completion(data.items)
                }
            case .failure(_):
                break
            }
        }
    }
    
    static func pushRecentlyPlayedTrack(track: APITrack, completion: @escaping ([Song]) -> Void) {
        let parameters: [String: String] = [
            "trackname": track.trackname,
            "artist": track.artist,
            "album": track.album
        ]
        AF.request("\(NetworkManager.host)/api/top_tracks/add/", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let songResponse = try? jsonDecoder.decode([Song].self, from: data) {
                    completion(songResponse)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    static func getTopTracks(completion: @escaping ([Song]) -> Void) {
        AF.request("\(NetworkManager.host)/api/tracks/", method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let songResponse = try? jsonDecoder.decode(APIResponse.self, from: data) {
                    var topSongs = [Song]()
                    for track in songResponse.Tracks {
                        topSongs.append(Song(name: track.trackname, artist: track.artist))
                    }

                    completion(topSongs)
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}
