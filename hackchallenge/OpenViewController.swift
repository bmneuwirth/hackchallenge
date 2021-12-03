//
//  OpenViewController.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 12/3/21.
//

import UIKit

class OpenViewController: UIViewController, SPTSessionManagerDelegate {
    
    private var spotifyLogin = UIButton()
    
    let clientID = "139d462ca4644420882305fbaf7dd8e6"
    let redirect = URL(string: "pulse-app-login://callback")!
    
    lazy var configuration = SPTConfiguration(
      clientID: clientID,
      redirectURL: redirect
    )

    lazy var sessionManager: SPTSessionManager = {
      if let tokenSwapURL = URL(string: "https://pulse-hackchallenge.herokuapp.com/api/token"),
         let tokenRefreshURL = URL(string: "https://pulse-hackchallenge.herokuapp.com/api/refresh_token") {
        self.configuration.tokenSwapURL = tokenSwapURL
        self.configuration.tokenRefreshURL = tokenRefreshURL
        self.configuration.playURI = ""
      }
      let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
      return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hack Challenge"
        view.backgroundColor = .black
                
        spotifyLogin.setTitle("Log in with Spotify", for: .normal)
        spotifyLogin.translatesAutoresizingMaskIntoConstraints = false
        spotifyLogin.setTitleColor(.systemBlue, for: .normal)
        spotifyLogin.addTarget(self, action: #selector(connectSpotify), for: .touchUpInside)
        
        view.addSubview(spotifyLogin)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            spotifyLogin.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            spotifyLogin.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    @objc func connectSpotify() {
        
        let scope: SPTScope = [.userReadRecentlyPlayed, .playlistModifyPrivate]
        self.sessionManager.initiateSession(with: scope, options: .default)
        
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print(session.accessToken) // The magic token that you use for requests
        ViewController.userToken = session.accessToken
        // Put stuff that happens after you connect to Spotify here
        // Get recently played songs and send to server
        NetworkManager.getRecentlyPlayed(token: session.accessToken) { tracks in
            let myPlaylist = Playlist(Playlist: "My Playlist", Songs:[])
            for track in tracks {
                myPlaylist.songs.append(Song(name: track.track.name, artist: track.track.album.artists[0].name))
            }
            ViewController.playlists.append(myPlaylist)
            // self.collectionView.reloadData()
            
                
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
        // Go to new view controller with playlist info
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager.application(app, open: url, options: options)
        return true
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        ViewController.userToken = session.accessToken
        // Put stuff that happens after you connect to Spotify here
        // Get recently played songs and send to server
        NetworkManager.getRecentlyPlayed(token: session.accessToken) { tracks in
            let myPlaylist = Playlist(Playlist: "My Playlist", Songs:[])
            for track in tracks {
                myPlaylist.songs.append(Song(name: track.track.name, artist: track.track.album.artists[0].name))
            }
            ViewController.playlists.append(myPlaylist)
            // self.collectionView.reloadData()
        }
        dismiss(animated: true)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        presentAlertController(title: "Error", message: "Sorry, something went wrong!", buttonTitle: "OK")
    }
    
    private func presentAlertController(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
