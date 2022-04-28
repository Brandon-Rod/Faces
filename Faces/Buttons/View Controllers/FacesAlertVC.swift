//
//  FacesAlertVC.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/16/22.
//

import UIKit

class FacesAlertVC: UIViewController {
    
    let containerView = FacesContainerView()
    let titleLabel = FacesTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = FacesBodyLabel(textAlignment: .center)
    let button = FacesButton(backgroundColor: .systemPurple, title: Strings.ok)
    let padding: CGFloat = 20
    
    var bodyViews: [UIView] = []
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureContainerView()
        configureTitleLabel()
        configureButtonLabel()
        configureMessageLabel()
        
    }
    
    private func configureViewController() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        bodyViews = [containerView, titleLabel, button, messageLabel]
        for bodyView in bodyViews { view.addSubview(bodyView) }
        
    }
    
    func configureContainerView() {
                
        NSLayoutConstraint.activate([
        
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        
        ])
        
    }
    
    func configureTitleLabel() {
                
        titleLabel.text = alertTitle ?? Strings.generalError
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        
        ])
        
    }
    
    func configureButtonLabel() {
                
        button.setTitle(buttonTitle ?? Strings.ok, for: .normal)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44)
        
        ])
        
    }
    
    func configureMessageLabel() {
                
        messageLabel.text = message ?? Strings.unableToComplete
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
        
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12)
        
        ])
        
    }
    
    @objc func dismissVC() {
        
        dismiss(animated: true)
        
    }

}
