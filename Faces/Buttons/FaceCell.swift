//
//  FaceCell.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/26/22.
//

import UIKit

class FaceCell: UITableViewCell {
    
    static let reuseID = "FaceCell"
    
    let faceImageView = FacesImageView(frame: .zero)
    let nameLabel = FacesCellLabel(fontType: .body)
    let astroLabel = FacesCellLabel(fontType: .callout)
    let pronounsLabel = FacesCellLabel(fontType: .callout)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func set(face: Face) {

        faceImageView.setImage(face: face)
        nameLabel.text = face.name
        if face.sunSign == Strings.sunUnknown && face.moonSign == Strings.moonUnknown && face.risingSign == Strings.risingUnknown {
            
            astroLabel.text = Strings.astrologicalPlacementsUnknown
            
        } else {
            
            astroLabel.text = "\(face.sunSign ?? Strings.sunUnknown) " + "\(face.moonSign ?? Strings.moonUnknown) " + "\(face.risingSign ?? Strings.risingUnknown)"
            
        }
        
        pronounsLabel.text = face.pronouns

    }
    
    private func configure() {
        
        addSubview(faceImageView)
        addSubview(nameLabel)
        addSubview(astroLabel)
        addSubview(pronounsLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
        
            faceImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            faceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding + 10),
            faceImageView.widthAnchor.constraint(equalToConstant: 80),
            faceImageView.heightAnchor.constraint(equalTo: faceImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: faceImageView.trailingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            
            astroLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            astroLabel.leadingAnchor.constraint(equalTo: faceImageView.trailingAnchor, constant: padding),
            astroLabel.heightAnchor.constraint(equalToConstant: 21),
            
            pronounsLabel.topAnchor.constraint(equalTo: astroLabel.bottomAnchor, constant: 5),
            pronounsLabel.leadingAnchor.constraint(equalTo: faceImageView.trailingAnchor, constant: padding),
            pronounsLabel.heightAnchor.constraint(equalToConstant: 20)
        
        ])
        
    }
    
}
