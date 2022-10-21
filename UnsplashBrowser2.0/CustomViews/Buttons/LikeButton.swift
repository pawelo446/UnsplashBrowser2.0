//
//  LikeButton.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 18/10/2022.
//

import UIKit

class LikeButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .capsule
        configuration?.baseBackgroundColor = .secondarySystemBackground
        configuration?.baseForegroundColor = .white
        configuration?.image = UIImage(systemName: "heart")
        
        configuration?.imagePadding = 3
        configuration?.imagePlacement = .all
    }

    
    func tappedAnimation(isliked: Bool) {
        
        if isliked {
            UIView.animate(withDuration: 0.5) {
                self.configuration?.baseForegroundColor = .red
                self.configuration?.image = UIImage(systemName: "heart.fill")
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.configuration?.baseForegroundColor = .white
                self.configuration?.image = UIImage(systemName: "heart")
            }
        }
    }
}
