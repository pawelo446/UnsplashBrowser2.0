//
//  ItemInfo.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 19/09/2022.
//

import UIKit

protocol UBSocialmediaItemVCProtocol: AnyObject {
    func didTapSocialmediaButton(ursl: URL)
}

protocol UBShareItemVCProtocol: AnyObject {
    func didTapShareButton()
}


class UBItemVC: UIViewController {
    
    let titleLabel = UBTitleLabel(textAlignment: .left, fontSize: 14)
    let button = UBButton(frame: .zero)
    var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        configureView()
        configureLabels()
        setType()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    
    func configureLabels() {
        view.addSubview(titleLabel)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    
    func configureButtons() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func actionButtonTapped() {}
    func setType() {}
}
