//
//  ShareItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 06/10/2022.
//

import UIKit

class ShareItem: UBItemInfoVC {

    override func setType() {
        titleLabel.text = "Share Image"
        button.set(color: .systemMint, title: "", systameImageName: "square.and.arrow.up")
    }
    
    override func actionButtonTapped() {
        let endpoint = URL(string: "https://instagram.com/" + user.instagramUsername!)
        presentSafariVC(with: endpoint!)
    }
}
