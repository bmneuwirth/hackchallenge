//
//  PlaylistCollectionViewCell.swift
//  hackchallenge
//
//  Created by Matthew Sadowski on 11/20/21.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {


    var nameLabel = UILabel()
    private var col = UIColor.white.withAlphaComponent(0.0)
    private var shapeImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        shapeImageView.contentMode = .scaleAspectFill
        shapeImageView.layer.cornerRadius = 0
        shapeImageView.clipsToBounds = true
        shapeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shapeImageView)
        
        contentView.layer.cornerRadius = 100
        contentView.clipsToBounds = true
        contentView.backgroundColor = col
        

        nameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        nameLabel.textColor = UIColor.white
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
        shapeImageView.image = playlist.getImage()

    }

    func setupConstraints() {
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            shapeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shapeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shapeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shapeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

    }

}
