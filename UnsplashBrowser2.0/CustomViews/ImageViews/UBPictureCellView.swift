//
//  UBPictureListImageView.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 22/08/2022.
//

import UIKit

class UBPictureCellView: UIImageView {
    
    let placeholder = UIImage(named: "UB-Logo")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(frame: CGRect, contentMode: ContentMode, cornerRadius: CGFloat) {
        self.init(frame: frame)
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        clipsToBounds = true
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
}
