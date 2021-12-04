//
//  PushViewController.swift
//
//
//  Created by Matthew Sadowski on 10/20/21.
//
import UIKit

class PushPlaylistViewController: UIViewController {

    var tableView = UITableView()
    private var shapeImageView = UIImageView()
    var imageName: String = ""


    let reuseIdentifier = "songCellReuse"
    let cellHeight: CGFloat = 50

    var songs: [Song] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Playlist"
        view.backgroundColor = .black
        self.view.backgroundColor = UIColor.black
        shapeImageView.contentMode = .scaleAspectFit
        shapeImageView.layer.cornerRadius = 0
        shapeImageView.clipsToBounds = true
        shapeImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shapeImageView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)

        setupConstraints()
    }
    
    func configure(songs: [Song], playlist: Playlist) {
        self.songs = songs
        shapeImageView.image = playlist.getImage()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            shapeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shapeImageView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            shapeImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            shapeImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
extension PushPlaylistViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SongTableViewCell {
            let song = songs[indexPath.row]
            cell.configure(song: song)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
