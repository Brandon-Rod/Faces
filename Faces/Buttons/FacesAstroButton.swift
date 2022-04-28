//
//  FacesAstroButton.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/12/22.
//

import UIKit

class FacesAstroButton: UIButton {
    
    override var isSelected: Bool {
        
       didSet { update() }
        
    }

    private func update() {
        
        if isSelected {
            
            self.backgroundColor = .systemPurple
            
        } else {
            
            self.backgroundColor = .secondarySystemBackground
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        
    }
    
    private func configure() {
        
        layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
    }

}
