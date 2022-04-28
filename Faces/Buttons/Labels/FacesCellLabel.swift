//
//  FacesCellLabel.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/26/22.
//

import UIKit

class FacesCellLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(fontType: UIFont.TextStyle) {
        self.init(frame: .zero)
        
        self.font = UIFont.preferredFont(forTextStyle: fontType)
        
    }
    
    private func configure() {
        
        textColor = .label
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
