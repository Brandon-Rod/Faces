//
//  FacesContainerView.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/16/22.
//

import UIKit

class FacesContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configure() {
        
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemPurple.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
