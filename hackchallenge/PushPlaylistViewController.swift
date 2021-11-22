//
//  PushViewController.swift
//
//
//  Created by Matthew Sadowski on 10/20/21.
//

import UIKit

class PushPlaylistViewController: UIViewController {

    // TODO 8: set up delegate
    var index: Int
    var nameLabel = UILabel()
    var placeholderText: String?
    // TODO 10: initialize placeholder text
    init(Playlist: Playlist, index: Int){
        self.index = index
        self.placeholderText = Playlist.Playlist + " songs"
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        nameLabel.text = placeholderText
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        setUpConstraints()
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }
    @objc func dismissViewController() {
        // TODO 9: call delegate function

           
        // TODO 5: dismiss view controller
        dismiss(animated: true, completion: nil)
    }
}

