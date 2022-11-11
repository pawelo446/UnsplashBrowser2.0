//
//  ShareItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 06/10/2022.
//

import UIKit

class ShareItem: UBItemVC {
    
    weak var delegate: UBShareItemVCProtocol!
    
    init(user: User, delegate: UBShareItemVCProtocol) {
        self.delegate = delegate
        super.init(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setType() {
        titleLabel.text = "Share Image"
        button.set(color: .systemMint, title: "", systameImageName: "square.and.arrow.up")
    }
    
    override func actionButtonTapped() {
        delegate.didTapShareButton()
    }
}
