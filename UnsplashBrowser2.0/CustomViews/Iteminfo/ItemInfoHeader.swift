//
//  ItemInfoHeader.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 19/09/2022.
//

import UIKit

class ItemInfoHeader: UIView {
    
    let avatarImageView = UBPictureCellView(frame: .zero, contentMode: .scaleToFill, cornerRadius: 40)
    let usernameLabel = UBTitleLabel(textAlignment: .left, fontSize: 20)
    let nameLabel = UBSecondaryTitleLabel(fontSize: 18)
    let photoDescription = UBBodyLabel(textAlignment: .left)
    let likeImageView = UIImageView()
    let likeCount = UBSecondaryTitleLabel(fontSize: 18)
    
    var picture: Picture!
    
    
    init (picture: Picture){
        super.init(frame: .zero)
        self.picture = picture
        configureUIElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUIElements() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        addSubviews(usernameLabel, nameLabel, photoDescription, avatarImageView, likeImageView, likeCount)
        
        if let avatarUrl = picture.user.profileImage?.medium {
            avatarImageView.downloadImage(from: avatarUrl)
        } else {
            avatarImageView.image = Images.ubLogo
        }
        usernameLabel.text = "Username: " + picture.user.username
        nameLabel.text = (picture.user.name ?? "")
        
        photoDescription.text = picture.description ?? "No description"
        photoDescription.numberOfLines = 3
        photoDescription.lineBreakMode = .byWordWrapping
        
        likeImageView.image = SFSymbols.heart
        likeImageView.tintColor = .secondaryLabel
        likeCount.text = String(picture.likes)
        
        layoutUI()
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 10
        let textImagePadding: CGFloat = 12
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            photoDescription.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: textImagePadding),
            photoDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            photoDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            photoDescription.heightAnchor.constraint(equalToConstant: 90),
            
            likeImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            likeImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            likeImageView.widthAnchor.constraint(equalToConstant: 20),
            likeImageView.heightAnchor.constraint(equalToConstant: 20),
            
            likeCount.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor),
            likeCount.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 5),
            likeCount.trailingAnchor.constraint(equalTo: trailingAnchor),
            likeCount.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
