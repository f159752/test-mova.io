//
//  PhotoViewController.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var historyItem: HistoryItem!
    let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()

        
        
        self.imageView.image = self.historyItem.getImage()
        self.navigationItem.title = self.historyItem.text
    }
    

    func setupUI(){
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.view.addSubview(self.imageView)
        NSLayoutConstraint.activate(
            [self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
             self.imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
             self.imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
             self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]
        )
    }

}
