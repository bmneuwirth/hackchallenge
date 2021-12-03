//
//  ViewController.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 11/16/21.
//

import UIKit

class ViewController: UIViewController, SPTSessionManagerDelegate {

    private var collectionView: UICollectionView!
    @IBOutlet var playlistlabel: UILabel! = UILabel()
    @IBOutlet var playlistlabel2: UILabel! = UILabel()
    @IBOutlet var playlistlabel3: UILabel! = UILabel()
    private var playlists = [Playlist(Playlist: "Recently Played", imageName: "playlist1", Songs: [Song(name: "Baby", artist: "Justin Bieber"), Song(name: "Song 2", artist: "Artist 2"), Song(name: "Song 3", artist: "Artist 3"), Song(name: "Song 4", artist: "Artist 4"), Song(name: "Song 5", artist: "Artist 5")]), Playlist(Playlist: "Your Faves", imageName: "slowrush-1", Songs: [Song(name: "Baby", artist: "Justin Bieber"), Song(name: "Song 2", artist: "Artist 2"), Song(name: "Song 3", artist: "Artist 3"), Song(name: "Song 4", artist: "Artist 4"), Song(name: "Song 5", artist: "Artist 5")])]
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"playlist1")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let cellPadding: CGFloat = 10
    private let sectionPadding: CGFloat = 5
    private let playlistCellReuseIdentifier = "playlistCellReuseIdentifier"
    let spotifylogo:UIImage? = UIImage(named: "Image")
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
        view.backgroundColor = .black
        //spotifyLogin.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        spotifyLogin.setTitle("Log in with Spotify", for: .normal)
        spotifyLogin.titleLabel?.textColor = UIColor.white
        spotifyLogin.titleLabel?.font = UIFont(name: "Rockwell-Bold" , size: 35)
        spotifyLogin.titleLabel?.adjustsFontSizeToFitWidth = true
        spotifyLogin.titleLabel?.numberOfLines = 1
        spotifyLogin.contentHorizontalAlignment = .center
        spotifyLogin.contentMode = .center
        spotifyLogin.center = self.view.center
        spotifyLogin.center.x = self.view.frame.midX
        //spotifyLogin.setImage(spotifylogo, for: UIControl.State.normal)
        spotifyLogin.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 0.0, right: 15.0)
        spotifyLogin.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        spotifyLogin.translatesAutoresizingMaskIntoConstraints = false
        spotifyLogin.backgroundColor = UIColor.green
        spotifyLogin.layer.cornerRadius = 15
        spotifyLogin.addTarget(self, action: #selector(connectSpotify), for: .touchUpInside)
        
        view.addSubview(spotifyLogin)
        
        UIView.animate(withDuration: 2.0) {
            self.playlistlabel.transform = self.playlistlabel.transform.translatedBy(x: 150, y: 0)
            //self.playlistlabel.transform = CGAffineTransform(translationX: 100, y: 100)
            self.playlistlabel.transform = CGAffineTransform(scaleX: 1.2, y: 2)
            //self.playlistlabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }
        
        playlistlabel.text = "Hello Cornell Student!"
        playlistlabel.font = .systemFont(ofSize: 20)
        playlistlabel.textColor = .white
        playlistlabel.translatesAutoresizingMaskIntoConstraints = false
                
        UIView.animate(withDuration: 2.0) {
            self.playlistlabel2.transform = self.playlistlabel.transform.translatedBy(x: 150, y: 0)
            //self.playlistlabel.transform = CGAffineTransform(translationX: 100, y: 100)
            self.playlistlabel2.transform = CGAffineTransform(scaleX: 1.2, y: 2)
            //self.playlistlabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }
        
        playlistlabel2.text = " Here Is What Everyone's"
        playlistlabel2.font = .systemFont(ofSize: 20)
        playlistlabel2.textColor = .black
        playlistlabel2.translatesAutoresizingMaskIntoConstraints = false
                
        UIView.animate(withDuration: 2.0) {
            self.playlistlabel3.transform = self.playlistlabel.transform.translatedBy(x: 150, y: 0)
            //self.playlistlabel.transform = CGAffineTransform(translationX: 100, y: 100)
            self.playlistlabel3.transform = CGAffineTransform(scaleX: 1.2, y: 2)
            //self.playlistlabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }
        
        playlistlabel3.text = "Listening To At Cornell"
        playlistlabel3.font = .systemFont(ofSize: 20)
        playlistlabel3.textColor = .black
        playlistlabel3.translatesAutoresizingMaskIntoConstraints = false
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 100
        layout.minimumInteritemSpacing = cellPadding
        layout.sectionInset = UIEdgeInsets(top: sectionPadding, left: 0, bottom: sectionPadding, right: 0)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: playlistCellReuseIdentifier)

        collectionView.dataSource = self

        collectionView.delegate = self

        view.addSubview(collectionView)

        view.addSubview(playlistlabel)
        view.addSubview(playlistlabel2)
        view.addSubview(playlistlabel3)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            spotifyLogin.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            spotifyLogin.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        let collectionViewPadding: CGFloat = 30
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: playlistlabel3.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
        NSLayoutConstraint.activate([
            playlistlabel.topAnchor.constraint(equalTo: spotifyLogin.bottomAnchor, constant: 5),
            playlistlabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playlistlabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75)
        ])
        NSLayoutConstraint.activate([
            playlistlabel2.topAnchor.constraint(equalTo: playlistlabel.bottomAnchor, constant: 10),
            playlistlabel2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playlistlabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 65)
        ])
        NSLayoutConstraint.activate([
            playlistlabel3.topAnchor.constraint(equalTo: playlistlabel2.bottomAnchor, constant: 15),
            playlistlabel3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playlistlabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75)
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
        NetworkManager.getRecentlyPlayed(token: session.accessToken) { tracks in
            for track in tracks {
                print(track.track.name)
            }
                
        }
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

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playlistCellReuseIdentifier, for: indexPath) as! PlaylistCollectionViewCell
            let play = playlists[indexPath.item]
            cell.configure(for: play)
            return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numItemsPerRow: CGFloat = 1.0
            let size = (collectionView.frame.width - cellPadding) / numItemsPerRow
            return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playlists[indexPath.item].isSelected.toggle()
        let playlist = playlists[indexPath.item]
        let vc = PushPlaylistViewController()
        vc.configure(songs: playlist.songs)
        navigationController?.pushViewController(vc, animated: true)
    }
}


