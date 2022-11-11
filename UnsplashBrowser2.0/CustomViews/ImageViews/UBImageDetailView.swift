//
//  UBImageDetailView.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 18/09/2022.
//

import UIKit

class UBImageDetailView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
