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

    // TODO 10: initialize placeholder text
    init(Playlist: Playlist, index: Int){
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white



        setUpConstraints()
    }

    func setUpConstraints() {

    }
    @objc func dismissViewController() {
        // TODO 9: call delegate function

           
        // TODO 5: dismiss view controller
        dismiss(animated: true, completion: nil)
    }
}

