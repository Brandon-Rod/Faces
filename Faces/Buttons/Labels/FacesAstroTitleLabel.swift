//
//  FacesAstroTitleLabel.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/16/22.
//

import UIKit

class FacesAstroTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        
        self.text = text
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configure() {
        
        textColor = .label
        adjustsFontSizeToFitWidth = true
        font = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
