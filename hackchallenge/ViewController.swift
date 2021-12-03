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
    static var playlists = [Playlist(Playlist: "Recently Played", Songs: [Song(name: "Baby", artist: "Justin Bieber"), Song(name: "Song 2", artist: "Artist 2"), Song(name: "Song 3", artist: "Artist 3"), Song(name: "Song 4", artist: "Artist 4"), Song(name: "Song 5", artist: "Artist 5")]), Playlist(Playlist: "Your Faves", Songs: [Song(name: "Baby", artist: "Justin Bieber"), Song(name: "Song 2", artist: "Artist 2"), Song(name: "Song 3", artist: "Artist 3"), Song(name: "Song 4", artist: "Artist 4"), Song(name: "Song 5", artist: "Artist 5")])]
    private let cellPadding: CGFloat = 10
    private let sectionPadding: CGFloat = 5
    private let playlistCellReuseIdentifier = "playlistCellReuseIdentifier"
    
    static var userToken: String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Hack Challenge"
        view.backgroundColor = .black
        
        if ViewController.userToken == nil {
            let vc = OpenViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
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
        ViewController.playlists[indexPath.item].isSelected2.toggle()
        let playlist = ViewController.playlists[indexPath.item]
        let vc = PushPlaylistViewController()
        vc.configure(songs: playlist.songs)
        navigationController?.pushViewController(vc, animated: true)
    }
}


