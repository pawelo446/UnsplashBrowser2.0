//
//  TwitterItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 06/10/2022.
//

import UIKit

class TwitterItem: UBItemInfoVC {
    
    override func setType() {
        titleLabel.text = "twitter: \(user.twitterUsername!)"
        button.set(color: .systemBlue, title: "", systameImageName: "checkmark")
    }
    
    override func actionButtonTapped() {
        let endpoint = URL(string: "https://twitter.com/" + user.twitterUsername!)
                            
        presentSafariVC(with: endpoint!)
    }
}
