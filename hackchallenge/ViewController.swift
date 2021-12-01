//
//  ViewController.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 11/16/21.
//

import UIKit

class ViewController: UIViewController, SPTSessionManagerDelegate {

    private var spotifyLogin = UIButton()
    private var userToken: String?
    
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
        // Do any additional setup after loading the view.
        title = "Hack Challenge"
        view.backgroundColor = .white
                
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      self.sessionManager.application(app, open: url, options: options)
      return true
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print(session.accessToken) // The magic token that you use for requests
        userToken = session.accessToken
        // Put stuff that happens after you connect to Spotify here
        // Get recently played songs and send to server
        // Go to new view controller with playlist info
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        presentAlertController(title: "Error", message: "Sorry, something went wrong!", buttonTitle: "OK")
    }

    @objc func connectSpotify() {
        
        let scope: SPTScope = [.userReadRecentlyPlayed, .playlistModifyPrivate]
        self.sessionManager.initiateSession(with: scope, options: .default)
        
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

