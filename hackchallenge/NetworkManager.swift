//
//  NetworkManager.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 11/30/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
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
}
