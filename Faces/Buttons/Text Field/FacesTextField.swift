//
//  FacesTextField.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/28/22.
//

import UIKit

class FacesTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        self.placeholder = placeholder
        
    }
    
    private func configure() {
                
        textColor = .label
        tintColor = .label
        textAlignment = .natural
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        borderStyle = .roundedRect
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        autocorrectionType = .no
        returnKeyType = .done
                
    }
    
}
