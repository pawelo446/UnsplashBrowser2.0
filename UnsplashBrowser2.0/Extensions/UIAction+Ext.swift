//
//  UIAction+Ext.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 23/08/2022.
//

import UIKit

extension UIAction {
    
    func configureColorButton(type: ColorPicker) {
        switch type {
        case .black_and_white:
            image = UIImage(systemName: "circle")
            title = "Black and white"
        case .black:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.black, renderingMode: .alwaysOriginal)
            title = "Black"
        case .white:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
            title = "White"
        case .yellow:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
            title = "Yellow"
        case .orange:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
            title = "Orange"
        case .red:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            title = "Red"
        case .purple:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
            title = "Purple"
        case .magenta:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.magenta, renderingMode: .alwaysOriginal)
            title = "Magenta"
        case .green:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            title = "Green"
        case .teal:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
            title = "Teal"
        case .blue:
            image = UIImage(systemName: "circle.fill")!.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            title = "Blue"
        }
    }
}
