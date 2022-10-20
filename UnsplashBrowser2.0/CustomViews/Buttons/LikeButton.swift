//
//  LikeButton.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 18/10/2022.
//

import UIKit

class LikeButton: UIButton {
    
    var liked: Bool!
    
    init(liked: Bool) {
        super.init(frame: .zero)
        configure()
        self.liked = liked
        configureType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .capsule
        configuration?.baseBackgroundColor = .secondarySystemBackground
        
        
        configuration?.imagePadding = 3
        configuration?.imagePlacement = .all
    }
    
    
    private func configureType() {
        if liked {
            configuration?.baseForegroundColor = .red
            configuration?.image = UIImage(systemName: "heart.fill")
        } else {
            configuration?.baseForegroundColor = .white
            configuration?.image = UIImage(systemName: "heart")
        }
    }
    
    func tappedAnimation() {
        
        if liked {
            UIView.animate(withDuration: 0.5) {
                self.configuration?.baseForegroundColor = .white
                self.configuration?.image = UIImage(systemName: "heart")
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.configuration?.baseForegroundColor = .red
                self.configuration?.image = UIImage(systemName: "heart.fill")
            }
        }
        liked.toggle()
    }
}
