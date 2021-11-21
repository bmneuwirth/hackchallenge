//
//  ViewController.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 11/16/21.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    private let cellPadding: CGFloat = 10
    private let playlistCellReuseIdentifier = "playlistCellReuseIdentifier"
    
    private var Playlists: [Playlist] = [
        Playlist(Playlist: "Playlist1"),
        Playlist(Playlist: "Playlist2"),
        Playlist(Playlist: "Playlist3"),
        Playlist(Playlist: "Playlist4"),
        Playlist(Playlist: "Playlist5"),
        Playlist(Playlist: "Playlist6"),
        Playlist(Playlist: "Playlist7"),
        Playlist(Playlist: "Playlist8"),
        Playlist(Playlist: "Playlist9"),
        Playlist(Playlist: "Playlist10")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Hack Challenge"
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellPadding
        layout.minimumInteritemSpacing = cellPadding
        layout.sectionInset = UIEdgeInsets(top: 0, left: -400, bottom: 0, right: 0)
        
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
        let collectionViewPadding: CGFloat = 12
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding-700),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
    }
}

    extension ViewController: UICollectionViewDataSource {

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            //if(collectionView == self.collectionView){
            return 1
           // }
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // if(collectionView == self.collectionView){
                return Playlists.count
           // }
        }
        

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            //if(collectionView == self.collectionView){
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: playlistCellReuseIdentifier, for: indexPath) as! PlaylistCollectionViewCell
                let playlist = Playlists[indexPath.item]
                cell2.configure(for: playlist)
                return cell2
           // }
        }
    }
    extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            //if(collectionView == self.collectionView){
                let itemsPerRow:CGFloat = 4
                        let hardCodedPadding:CGFloat = 5
                        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
                        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
                        return CGSize(width: itemWidth, height: itemHeight)
           // }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
          // if(collectionView == self.collectionView){
                return CGSize(width: collectionView.frame.width, height: 50)
          //  }
            

        }


         func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            Playlists[indexPath.item].isSelected2.toggle()
                    let playlist = Playlists[indexPath.item]
                let vc = PushPlaylistViewController(Playlist: playlist, index: indexPath.row)
                navigationController?.pushViewController(vc, animated: true)
                
                    
            
        }
    }




