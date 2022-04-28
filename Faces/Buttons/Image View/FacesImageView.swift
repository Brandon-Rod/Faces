//
//  FacesImageView.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/27/22.
//

import UIKit

class FacesImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure()  {
        
        layer.cornerRadius = 10
        clipsToBounds = true
        image = Images.placeholder
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setImage(face: Face) {
        
        guard let data = face.image else { return }
        image = UIImage(data: data)
                    
    }
    
} 
