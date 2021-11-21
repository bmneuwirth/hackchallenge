//
//  PlaylistCollectionViewCell.swift
//  hackchallenge
//
//  Created by Matthew Sadowski on 11/20/21.
//


import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {


    var nameLabel = UILabel()
    private var col = UIColor(ciColor: .red)

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = col
        
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)


        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for playlist: Playlist) {
        nameLabel.text = playlist.Playlist        

    }

    func setupConstraints() {
        let padding: CGFloat = 8
        let labelHeight: CGFloat = 20
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])

    }

}
