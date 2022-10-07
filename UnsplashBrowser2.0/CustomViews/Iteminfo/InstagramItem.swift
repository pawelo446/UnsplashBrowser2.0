//
//  InstagramItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 05/10/2022.
//

import UIKit

class InstagramItem: UBItemVC {
    
    weak var delegate: UBSocialmediaItemVCProtocol!
    
    init(user: User, delegate: UBSocialmediaItemVCProtocol) {
        self.delegate = delegate
        super.init(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setType() {
        titleLabel.text = "Instagram: \(user.instagramUsername!)"
        button.set(color: .systemRed, title: "", systameImageName: "camera")
    }
    
    override func actionButtonTapped() {
        guard let url = URL(string: "https://www.instagram.com/\(user.instagramUsername!)") else {
            presentUBAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        delegate.didTapSocialmediaButton(ursl: url)
    }
}
