//
//  ViewController.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 11/16/21.
//

import UIKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView!
    @IBOutlet var playlistlabel: UILabel! = UILabel()
    @IBOutlet var playlistlabel2: UILabel! = UILabel()
    @IBOutlet var playlistlabel3: UILabel! = UILabel()
    static var playlists = [Playlist(Playlist: "Recently Played", imageName: "playlist1", Songs: [Song(name: "Baby", artist: "Justin Bieber"), Song(name: "Song 2", artist: "Artist 2"), Song(name: "Song 3", artist: "Artist 3"), Song(name: "Song 4", artist: "Artist 4"), Song(name: "Song 5", artist: "Artist 5")]), Playlist(Playlist: "Shitty Songs", imageName: "slowrush-1", Songs: [Song(name: "Baby", artist: "Justin Bieber"), Song(name: "Song 2", artist: "Artist 2"), Song(name: "Song 3", artist: "Artist 3"), Song(name: "Song 4", artist: "Artist 4"), Song(name: "Song 5", artist: "Artist 5")])]
    private let cellPadding: CGFloat = 10
    private let sectionPadding: CGFloat = 5
    private let playlistCellReuseIdentifier = "playlistCellReuseIdentifier"
    private let backgroundColor = UIColor(red: 0.13, green: 0.10, blue: 0.11, alpha: 1.00)
    private var recentlyPlayedPlaylist: Playlist?
    
    let imageView : UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named:"playlist1")
            iv.contentMode = .scaleAspectFill
            return iv
        }()
    
    static var userToken: String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ViewController.userToken != nil && recentlyPlayedPlaylist == nil {
            let topPlaylist = Playlist(Playlist: "Top Songs at Cornell", imageName: "playlist1", Songs: [Song]())
            NetworkManager.getRecentlyPlayed(token: ViewController.userToken!) { tracks in
                self.recentlyPlayedPlaylist = Playlist(Playlist: "My Playlist", imageName: "playlist1", Songs:[])
                for track in tracks {
                     let newAPISong = APITrack(trackname: track.track.name, artist: track.track.album.artists[0].name, album: track.track.album.name)
                    let newSong = Song(name: track.track.name, artist: track.track.album.artists[0].name)
                    self.recentlyPlayedPlaylist!.songs.append(newSong)
                     NetworkManager.pushRecentlyPlayedTrack(track: newAPISong) { response in
                    }
                }
                
                NetworkManager.getTopTracks() { topTracks in
                    topPlaylist.setSongs(songs: topTracks)
                }
                
                ViewController.playlists.append(self.recentlyPlayedPlaylist!)
                ViewController.playlists.append(topPlaylist)
                self.collectionView.reloadData()
            }
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Hack Challenge"
        view.backgroundColor = backgroundColor
        
        if ViewController.userToken == nil {
            let vc = OpenViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        UIView.animate(withDuration: 2.0) {
            self.playlistlabel.transform = self.playlistlabel.transform.translatedBy(x: 150, y: 0)
            //self.playlistlabel.transform = CGAffineTransform(translationX: 100, y: 100)
            self.playlistlabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            //self.playlistlabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }
        
        playlistlabel.text = "Hello, Cornell Student!"
        playlistlabel.font = .systemFont(ofSize: 20)
        playlistlabel.font = UIFont(name: "DamascusBold", size: 20)
        playlistlabel.textAlignment = .center
        playlistlabel.textColor = .white
        playlistlabel.translatesAutoresizingMaskIntoConstraints = false
                
        UIView.animate(withDuration: 2.0) {
            self.playlistlabel2.transform = self.playlistlabel.transform.translatedBy(x: 150, y: 0)
            //self.playlistlabel.transform = CGAffineTransform(translationX: 100, y: 100)
            self.playlistlabel2.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            //self.playlistlabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }
        
        playlistlabel2.text = " Here's What Everyone's"
        playlistlabel2.font = .systemFont(ofSize: 20)
        playlistlabel2.font = UIFont(name: "Damascus", size: 20)
        playlistlabel2.textColor = .white
        playlistlabel2.textAlignment = .center
        playlistlabel2.translatesAutoresizingMaskIntoConstraints = false
                
        UIView.animate(withDuration: 2.0) {
            self.playlistlabel3.transform = self.playlistlabel.transform.translatedBy(x: 150, y: 0)
            //self.playlistlabel.transform = CGAffineTransform(translationX: 100, y: 100)
            self.playlistlabel3.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            //self.playlistlabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }
        
        playlistlabel3.text = "Listening To At Cornell"
        playlistlabel3.font = .systemFont(ofSize: 20)
        playlistlabel3.font = UIFont(name: "Damascus", size: 20)
        playlistlabel3.textColor = .white
        playlistlabel3.textAlignment = .center
        playlistlabel3.translatesAutoresizingMaskIntoConstraints = false
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
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
        let collectionViewPadding: CGFloat = 30
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: playlistlabel3.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
        NSLayoutConstraint.activate([
            playlistlabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            playlistlabel.bottomAnchor.constraint(equalTo: playlistlabel.topAnchor, constant: 40),
            playlistlabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playlistlabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            playlistlabel2.topAnchor.constraint(equalTo: playlistlabel.bottomAnchor, constant: 20),
            playlistlabel2.bottomAnchor.constraint(equalTo: playlistlabel2.topAnchor, constant: 30),
            playlistlabel2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playlistlabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            playlistlabel3.topAnchor.constraint(equalTo: playlistlabel2.bottomAnchor, constant: 15),
            playlistlabel3.bottomAnchor.constraint(equalTo: playlistlabel3.topAnchor, constant: 30),
            playlistlabel3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playlistlabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.playlists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playlistCellReuseIdentifier, for: indexPath) as! PlaylistCollectionViewCell
        let play = ViewController.playlists[indexPath.item]
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

        ViewController.playlists[indexPath.item].isSelected.toggle()
        let playlist = ViewController.playlists[indexPath.item]
        let vc = PushPlaylistViewController()
        vc.configure(songs: playlist.songs, playlist: ViewController.playlists[indexPath.item])
        navigationController?.pushViewController(vc, animated: true)
    }
}


