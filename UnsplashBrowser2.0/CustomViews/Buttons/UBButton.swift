//
//  UBButton.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 16/08/2022.
//

import UIKit

class UBButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(color: UIColor, title: String, systameImageName: String) {
        self.init(frame: .zero)
        set(color: color, title: title, systameImageName: systameImageName)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(color: UIColor, title: String, systameImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systameImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
        
    }
    
    
    private func configure () {
        translatesAutoresizingMaskIntoConstraints = false
        configuration = .tinted()
        configuration?.cornerStyle = .large
    }
}
