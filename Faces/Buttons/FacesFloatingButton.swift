//
//  FacesFloatingButton.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/18/22.
//

import UIKit

class FacesFloatingButton: UIButton {
    
    let selectedImage = SFSymbols.addFace?.withConfiguration(UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title2)))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configure() {
        
        layer.cornerRadius = 30
        backgroundColor = .systemPurple
        setImage(selectedImage, for: .normal)
        tintColor = .white
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        NSLayoutConstraint.activate([
        
            self.heightAnchor.constraint(equalToConstant: 60),
            self.widthAnchor.constraint(equalToConstant: 60)
        
        ])
        
    }

}
