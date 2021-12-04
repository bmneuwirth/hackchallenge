//
//  OpenViewController.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 12/3/21.
//

import UIKit

class OpenViewController: UIViewController, SPTSessionManagerDelegate {
    
    private var spotifyLogin = UIButton()
    let pulselogo = UIImageView()
    let textView = UILabel()
    let textView2 = UILabel()

    
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
                
        //spotifyLogin.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont(name: "Futura-Medium" , size: 20)
        configuration.attributedTitle = AttributedString("Log In With Spotify", attributes: container)
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = UIColor.purple
        configuration.image = UIImage(systemName: "person.circle")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 25)
        configuration.titlePadding = 10
        configuration.imagePadding = 10
        configuration.imagePlacement = .leading
        configuration.imagePadding = 5
        spotifyLogin.configuration = configuration

        spotifyLogin.contentHorizontalAlignment = .right
        spotifyLogin.contentMode = .center
        spotifyLogin.center = self.view.center
        spotifyLogin.center.x = self.view.frame.midX
        spotifyLogin.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        spotifyLogin.translatesAutoresizingMaskIntoConstraints = false
        spotifyLogin.backgroundColor = UIColor.purple
        spotifyLogin.layer.cornerRadius = 15
        spotifyLogin.addTarget(self, action: #selector(connectSpotify), for: .touchUpInside)
        spotifyLogin.addTarget(self, action: #selector(connectSpotify), for: .touchUpInside)
        
        view.addSubview(spotifyLogin)
        
        pulselogo.image = UIImage(systemName: "waveform.circle")
        pulselogo.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 150)
        pulselogo.contentMode = .scaleAspectFill
        pulselogo.clipsToBounds = true
        pulselogo.translatesAutoresizingMaskIntoConstraints = false
        pulselogo.tintColor = UIColor.purple
        view.addSubview(pulselogo)
        
        textView.text = "Pulse"
        textView.font = UIFont(name: "Futura-Bold", size: 50)
        textView.textAlignment = .center
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        textView2.text = "Cornell's Music Heartbeat"
        textView2.font = UIFont(name: "Futura-Bold", size: 20)
        textView2.textAlignment = .center
        textView2.textColor = .white
        textView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView2)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            spotifyLogin.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            spotifyLogin.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            pulselogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pulselogo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100)
        ])
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textView.bottomAnchor.constraint(equalTo: pulselogo.topAnchor, constant: -27)
        ])
        NSLayoutConstraint.activate([
            textView2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textView2.topAnchor.constraint(equalTo: pulselogo.bottomAnchor, constant: 32)
        ])
    }
    
    @objc func connectSpotify() {
        
        let scope: SPTScope = [.userReadRecentlyPlayed, .playlistModifyPrivate]
        self.sessionManager.initiateSession(with: scope, options: .default)
        
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("session initiated")
        print(session.accessToken) // The magic token that you use for requests
        ViewController.userToken = session.accessToken
        // Put stuff that happens after you connect to Spotify here
        // Get recently played songs and send to server
        
        DispatchQueue.main.sync {
            self.dismiss(animated: true)
        }
        // Go to new view controller with playlist info
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager.application(app, open: url, options: options)
        return true
    }
    
//    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
//        print("session renewed")
//        ViewController.userToken = session.accessToken
//        // Put stuff that happens after you connect to Spotify here
//        // Get recently played songs and send to server
//        NetworkManager.getRecentlyPlayed(token: session.accessToken) { tracks in
//            let myPlaylist = Playlist(Playlist: "My Playlist", imageName: "playlist1", Songs:[])
//            for track in tracks {
//                myPlaylist.songs.append(Song(name: track.track.name, artist: track.track.album.artists[0].name))
//            }
//            ViewController.playlists.append(myPlaylist)
//            // self.collectionView.reloadData()
//        }
//        dismiss(animated: true)
//    }
    
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

}
