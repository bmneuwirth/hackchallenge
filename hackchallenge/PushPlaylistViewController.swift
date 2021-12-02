//
//  PushViewController.swift
//
//
//  Created by Matthew Sadowski on 10/20/21.
//
import UIKit

class PushPlaylistViewController: UIViewController {

    var tableView = UITableView()

    let reuseIdentifier = "songCellReuse"
    let cellHeight: CGFloat = 50

    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Playlist"
        view.backgroundColor = .white


        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)

        setupConstraints()
    }
    
    func configure(songs: [Song]) {
        self.songs = songs
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
