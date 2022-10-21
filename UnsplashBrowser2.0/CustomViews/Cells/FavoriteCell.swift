//
//  FavoriteCell.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 21/10/2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID = "FollowerCell"
    
    let image = UBPictureCellView(frame: .zero, contentMode: .scaleAspectFill, cornerRadius: 15)
    let usernameLabel = UBTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        confiure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(picture: Picture) {
        usernameLabel.text = picture.user.username
        image.downloadImage(from: picture.urls.regular)
    }
    
    
    private func confiure() {
        addSubviews(image, usernameLabel)
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            image.heightAnchor.constraint(equalToConstant: 90),
            image.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant:  padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
