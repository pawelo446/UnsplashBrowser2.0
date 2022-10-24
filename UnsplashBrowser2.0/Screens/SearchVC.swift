//
//  SearchVC.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 16/08/2022.
//

import UIKit
import Combine

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let searchButton = UBButton()
    let phraseTextField = UBTextField()
    let container = UBContainerView()
    let firstBackgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    let secondBackgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    
    var subscribers = Set<AnyCancellable>()
    var backgroundImageArray: [UIImage] = [UIImage(named: "testbg")!, UIImage(named: "testbg2")!, UIImage(named: "testbg3")!]
    var firstBackgroundIsVisible = false
    var isPhraseEntered: Bool { return !phraseTextField.text!.isEmpty }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLogoImageView()
        configurecontainer()
        configureSearchButton()
        configurePhraseTextField()
        createDismissKeyboardTapGesture()
        configureBackground()
        
        var test: [Picture] = []
        NetworkManager.shared.fetchRandomPhotos().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let err):
                print(err)
            case .finished:
                print("GIT")
            }
        }, receiveValue: {
            test.append(contentsOf: $0)
            print($0)
        })
        .store(in: &subscribers)
        
        self.changeBackgroundPhoto(toImage: self.backgroundImageArray[0])
        var i = 1
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {_ in
            if i >= 3 { i = 0 }
            self.changeBackgroundPhoto(toImage: self.backgroundImageArray[i])
            i += 1
        }
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
    
    
    func configurecontainer() {
        view.addSubview(container)
        container.layer.cornerRadius = 50
        container.layer.opacity = 0.9
        
        NSLayoutConstraint.activate([
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            container.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureBackground() {
        firstBackgroundImageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(firstBackgroundImageView, at: 0)
        secondBackgroundImageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(secondBackgroundImageView, at: 0)
    }
    
    
    func changeBackgroundPhoto(toImage: UIImage) {
        if firstBackgroundIsVisible {
            UIView.animate(withDuration: 2) {
                self.firstBackgroundImageView.alpha = 0
            } completion: { _ in
                self.firstBackgroundImageView.image = toImage
            }
        } else {
            UIView.animate(withDuration: 2) {
                self.firstBackgroundImageView.alpha = 1
            } completion: { _ in
                self.secondBackgroundImageView.image = toImage
            }
        }
        firstBackgroundIsVisible.toggle()
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushPictureList()
        return true
    }
}
