//
//  PortfolioItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 06/10/2022.
//

import UIKit

class PortfolioItem: UBItemInfoVC {
    
    
    func setType(value: String) {
        titleLabel.text = "Portfolio:"
        button.set(color: .systemTeal, title: "", systameImageName: "safari")
    }
    
    override func actionButtonTapped() {
        let endpoint = URL(string: user.portfolioUrl!)
        presentSafariVC(with: endpoint!)
    }

}
