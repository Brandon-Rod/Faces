//
//  FacesEmptyStateView.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/5/22.
//

import UIKit

class FacesEmptyStateView: UIView {
    
    let messageLabel = FacesCellLabel(fontType: .title1)
    let imageView = FacesImageView(frame: .zero)
    let padding: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        
        messageLabel.text = message
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configure() {
        
        configureMessageLabel()
        configureImageView()
        
    }
    
    private func configureMessageLabel() {
        
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -220),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        
        ])
        
    }
    
    private func configureImageView() {
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        ])
        
    }

}
