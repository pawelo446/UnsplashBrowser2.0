//
//  SaveItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 06/10/2022.
//

import UIKit

class SaveItem: UBItemVC {
    
    override func setType() {
        titleLabel.text = "Save Image"
        button.set(color: .systemGreen, title: "", systameImageName: "square.and.arrow.down")
    }
    
    override func actionButtonTapped() {
        
    }
}
