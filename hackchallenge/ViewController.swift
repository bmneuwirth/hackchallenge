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
    static var playlists = [Playlist]()
    private let cellPadding: CGFloat = 10
    private let sectionPadding: CGFloat = 5
    private let playlistCellReuseIdentifier = "playlistCellReuseIdentifier"
    private let backgroundColor = UIColor.black
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
                self.recentlyPlayedPlaylist = Playlist(Playlist: "My Recently Played", imageName: "playlist1", Songs:[])
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
                ViewController.playlists.append(topPlaylist)
                ViewController.playlists.append(self.recentlyPlayedPlaylist!)
                self.collectionView.reloadData()
            }
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Playlists"
        self.navigationItem.titleView?.backgroundColor = backgroundColor
        self.navigationItem.largeTitleDisplayMode = .never
        let navbar = self.navigationController!.navigationBar
        navbar.scrollEdgeAppearance = navbar.standardAppearance
        view.backgroundColor = backgroundColor
        
        if ViewController.userToken == nil {
            let vc = OpenViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
//        playlistlabel.text = "Playlists"
//        playlistlabel.font = .systemFont(ofSize: 20, weight: .bold)
//        // playlistlabel.font = UIFont(name: "DamascusBold", size: 20)
//        playlistlabel.textAlignment = .center
//        playlistlabel.textColor = .white
//        playlistlabel.translatesAutoresizingMaskIntoConstraints = false
        
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = cellPadding
        layout.sectionInset = UIEdgeInsets(top: sectionPadding, left: 0, bottom: sectionPadding, right: 0)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: playlistCellReuseIdentifier)

        collectionView.dataSource = self

        collectionView.delegate = self

        view.addSubview(collectionView)

        setupConstraints()
    }
    
    func setupConstraints() {
        let collectionViewPadding: CGFloat = 30
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
//        NSLayoutConstraint.activate([
//            playlistlabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
//            playlistlabel.bottomAnchor.constraint(equalTo: playlistlabel.topAnchor, constant: 40),
//            playlistlabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            playlistlabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
//        ])
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
        vc.configure(newTitle: playlist.PlaylistTitle, songs: playlist.songs)
        navigationController?.pushViewController(vc, animated: true)
    }
}


