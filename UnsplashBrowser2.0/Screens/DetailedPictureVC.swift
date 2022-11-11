//
//  DetailedPictureVC.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 18/09/2022.
//

import UIKit

final class DetailedPictureVC: UBDataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var imageView = UBImageDetailView(frame: .zero)
    var header = UIView()
    var share: ShareItem!
    var save: SaveItem!
    var socialmediaItemsViews: [UBItemVC] = []
    var socialmediaStackView = UIStackView()
    
    var picture: Picture
    
    init(picture: Picture) {
        self.picture = picture
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        getPictureAndSizing()
        configureItemHeader()
        prepareSocialmediaItems()
        configureShareDownloadItems()
        configureSocialmediaStackView()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    
    func getPictureAndSizing() {
        presentLoadingView()
        contentView.addSubview(imageView)
        imageView.isHidden = true
        
        let group = DispatchGroup()
        group.enter()
        Task {
            imageView.image = try await NetworkManager.shared.downloadImage(from: picture.urls.regular)
            group.leave()
            //TODO: No internet unwrapping crash
        }
        
        group.notify(queue: .main) {
            self.configureImage()
            self.imageView.isHidden = false
            self.dismissLoadingView()
        }
    }
    
    
    private func configureImage() {
        let padding: CGFloat = 5
        let imageViewHeight:CGFloat = imageView.image!.size.height / imageView.image!.size.width
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: imageViewHeight),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    
    private func configureItemHeader() {
        header = ItemInfoHeader(picture: picture)
        contentView.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            header.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    
    private func configureShareDownloadItems() {
        share = ShareItem(user: self.picture.user, delegate: self)
        save = SaveItem(user: self.picture.user)
        self.add(childVC: share, to: self.contentView)
        self.add(childVC: save, to: self.contentView)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            share.view.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            share.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            share.view.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -padding),
            
            save.view.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            save.view.leadingAnchor.constraint(equalTo: share.view.trailingAnchor, constant: padding),
            save.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    
    func prepareSocialmediaItems() {
        if picture.user.twitterUsername != nil{ socialmediaItemsViews.append(TwitterItem(user: self.picture.user, delegate: self)) }
        
        if picture.user.instagramUsername != nil{ socialmediaItemsViews.append(InstagramItem(user: self.picture.user, delegate: self)) }
        
        if picture.user.portfolioUrl != nil{ socialmediaItemsViews.append(PortfolioItem(user: self.picture.user, delegate: self)) }
    }
    
    
    private func configureSocialmediaStackView() {
        socialmediaStackView.distribution = .fillEqually
        socialmediaStackView.spacing = 10
        socialmediaStackView.axis = .vertical
        
        for item in socialmediaItemsViews {
            socialmediaStackView.addArrangedSubview(item.view)
        }
        
        contentView.addSubview(socialmediaStackView)
        socialmediaStackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            socialmediaStackView.topAnchor.constraint(equalTo: save.view.bottomAnchor, constant: 8),
            socialmediaStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            socialmediaStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            socialmediaStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


extension DetailedPictureVC: UBSocialmediaItemVCProtocol {
    func didTapSocialmediaButton(ursl: URL) {
        presentSafariVC(with: ursl)
    }
}

extension DetailedPictureVC: UBShareItemVCProtocol {
    func didTapShareButton() {
        let ac = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        present(ac, animated: true)
    }
}
