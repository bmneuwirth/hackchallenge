//
//  SongTableViewCell.swift
//  hackchallenge
//
//  Created by Kaden Lei on 11/30/21.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var artistLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        artistLabel.font = .systemFont(ofSize: 12)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(artistLabel)

        setupConstraints()
    }

    func configure(song: Song) {
        nameLabel.text = song.name
        artistLabel.text = song.artist
    }

    func setupConstraints() {
        let padding: CGFloat = 8
        let labelHeight: CGFloat = 20

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            artistLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
