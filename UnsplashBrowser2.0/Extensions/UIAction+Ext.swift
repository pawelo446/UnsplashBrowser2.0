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
            image = SFSymbols.circle
            title = "Black and white"
        case .black:
            image = SFSymbols.circleFilled!.withTintColor(.black, renderingMode: .alwaysOriginal)
            title = "Black"
        case .white:
            image = SFSymbols.circleFilled!.withTintColor(.white, renderingMode: .alwaysOriginal)
            title = "White"
        case .yellow:
            image = SFSymbols.circleFilled!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
            title = "Yellow"
        case .orange:
            image = SFSymbols.circleFilled!.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
            title = "Orange"
        case .red:
            image = SFSymbols.circleFilled!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            title = "Red"
        case .purple:
            image = SFSymbols.circleFilled!.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
            title = "Purple"
        case .magenta:
            image = SFSymbols.circleFilled!.withTintColor(.magenta, renderingMode: .alwaysOriginal)
            title = "Magenta"
        case .green:
            image = SFSymbols.circleFilled!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            title = "Green"
        case .teal:
            image = SFSymbols.circleFilled!.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
            title = "Teal"
        case .blue:
            image = SFSymbols.circleFilled!.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            title = "Blue"
        }
    }
}
