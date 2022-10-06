//
//  SearchVC.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 16/08/2022.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let searchButton = UBButton()
    let phraseTextField = UBTextField()
    
    var isPhraseEntered: Bool { return !phraseTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureSearchButton()
        configurePhraseTextField()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushPictureList() {
        guard isPhraseEntered else {
            self.presentUBAlertOnMainThread(title: "Empty Request", message: "Please enter a phrase. We need to know what you are look for :)", buttonTitle: "Ok")
            return
        }
        navigationController?.pushViewController(PicturesListVC(phrase: phraseTextField.text!), animated: true)
        
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "UB-Logo")!.withTintColor(.secondaryLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configurePhraseTextField() {
        view.addSubview(phraseTextField)
        phraseTextField.delegate = self
        
        NSLayoutConstraint.activate([
            phraseTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            phraseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            phraseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            phraseTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.set(color: .systemPink, title: "Search", systameImageName: "magnifyingglass")
        searchButton.addTarget(self, action: #selector(pushPictureList), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushPictureList()
        return true
    }
}
