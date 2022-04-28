//
//  FacesTextView.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/29/22.
//

import UIKit

class FacesTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero, textContainer: .none)

        self.text = placeholder

    }
    
    private func configure() {
                
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 5
        autocorrectionType = .yes
        returnKeyType = .done
        
    }

}
