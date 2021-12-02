//
//  PlaylistCollectionViewCell.swift
//  hackchallenge
//
//  Created by Matthew Sadowski on 11/20/21.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {


    var nameLabel = UILabel()
    private var col = UIColor(ciColor: .cyan)

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = col

        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)


        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for playlist: Playlist) {
        nameLabel.text = playlist.PlaylistTitle

    }

    func setupConstraints() {
        let padding: CGFloat = 8
        let labelHeight: CGFloat = 20
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

    }

}
