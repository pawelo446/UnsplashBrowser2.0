//
//  PictureCell.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 22/08/2022.
//

import UIKit

class PictureCell: UICollectionViewCell {
    static let reuseID = "PictureCell"
    
    let cellPicture = UBPictureCellView(frame: .zero, contentMode: .scaleAspectFill, cornerRadius: 10)
    let usernameLabel = UBTitleLabel(textAlignment: .left, fontSize: 15)
    
    private lazy var likeButton = LikeButton(liked: false)
    
    @objc func handleTap() {
        likeButton.tappedAnimation()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        confiugure()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        likeButton.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(picture: Picture, username: String) {
        cellPicture.downloadImage(from: picture.urls.small)
        usernameLabel.text = username
    }
    
    private func confiugure() {
        addSubview(cellPicture)
        addSubview(usernameLabel)
        addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 4
        NSLayoutConstraint.activate([
            cellPicture.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cellPicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellPicture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cellPicture.heightAnchor.constraint(equalTo: cellPicture.widthAnchor),
            
            usernameLabel.bottomAnchor.constraint(equalTo: cellPicture.topAnchor, constant: -2),
            usernameLabel.leadingAnchor.constraint(equalTo: cellPicture.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: cellPicture.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            likeButton.bottomAnchor.constraint(equalTo: cellPicture.bottomAnchor, constant: -15),
            likeButton.trailingAnchor.constraint(equalTo: cellPicture.trailingAnchor, constant: -15),
            likeButton.heightAnchor.constraint(equalToConstant: 35),
            likeButton.widthAnchor.constraint(equalToConstant: 35)
            
        ])
        
    }
    
}
