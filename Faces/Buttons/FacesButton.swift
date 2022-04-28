//
//  FacesButton.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/26/22.
//

import UIKit

class FacesButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
    }
    
    private func configure() {
        
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
    }
    
}
