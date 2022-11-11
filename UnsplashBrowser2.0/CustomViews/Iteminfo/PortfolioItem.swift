//
//  PortfolioItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 06/10/2022.
//

import UIKit

class PortfolioItem: UBItemVC {
    
    weak var delegate: UBSocialmediaItemVCProtocol!
    
    init(user: User, delegate: UBSocialmediaItemVCProtocol) {
        self.delegate = delegate
        super.init(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setType() {
        titleLabel.text = "Portfolio:"
        button.set(color: .systemTeal, title: "", systameImageName: "safari")
    }
    
    override func actionButtonTapped() {
        guard let url = URL(string: user.portfolioUrl!) else {
            presentUBAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        delegate.didTapSocialmediaButton(ursl: url)
    }
    
}
