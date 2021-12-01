//
//  ViewController.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 11/16/21.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    private var playlists = [Playlist(Playlist: "Recently Played", Songs: [Song(name: "Baby", artist: "Justin Bieber"), Song(name: "Song 2", artist: "Artist 2"), Song(name: "Song 3", artist: "Artist 3"), Song(name: "Song 4", artist: "Artist 4"), Song(name: "Song 5", artist: "Artist 5")])]
    
    private let cellPadding: CGFloat = 10
    private let sectionPadding: CGFloat = 5
    private let playlistCellReuseIdentifier = "playlistCellReuseIdentifier"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Playlists"
        view.backgroundColor = .black
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellPadding
        layout.minimumInteritemSpacing = cellPadding
        layout.sectionInset = UIEdgeInsets(top: sectionPadding, left: 0, bottom: sectionPadding, right: 0)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
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
            let numItemsPerRow: CGFloat = 2.0
            let size = (collectionView.frame.width - cellPadding) / numItemsPerRow
            return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playlists[indexPath.item].isSelected2.toggle()
        let playlist = playlists[indexPath.item]
        let vc = PushPlaylistViewController()
        vc.configure(songs: playlist.songs)
        navigationController?.pushViewController(vc, animated: true)
        }
    }




