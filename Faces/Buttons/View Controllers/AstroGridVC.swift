//
//  AstroGridVC.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/13/22.
//

import UIKit

enum Placement {
    
    case sun, moon, rising
    
}

class AstroGridVC: UIViewController {
    
    private let dataController: DataController
    private let stackView = UIStackView()
    
    private let astroKeys = ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"]
    private let padding: CGFloat = 20

    private let astroTitleLabel = FacesCellLabel(fontType: .title1)
    private let unknownButton = FacesButton(backgroundColor: .systemPurple, title: Strings.unknown)
    private let placement: Placement
    
    private let signType: String

    private var face: Face
    
    init(face: Face, signType: String, placement: Placement, dataController: DataController) {
        
        self.face = face
        self.signType = signType
        self.placement = placement
        self.dataController = dataController
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUnknownButton()
        stackedGrid(rows: 4, columns: 3, labelTitle: signType, placement: placement)
        
    }
    
    private func configureUnknownButton() {
        
        unknownButton.addTarget(self, action: #selector(unknownButtonTapped), for: .touchUpInside)
        
    }

    @objc private func unknownButtonTapped() {
        
        switch placement {
            
        case .sun:
            face.sunSign = Strings.sunUnknown
            self.presentFacesAlertOnMainThread(title: Strings.sunSignChanged, message: Strings.sunSignUnknown, buttonTitle: Strings.ok)
            
        case .moon:
            face.moonSign = Strings.moonUnknown
            self.presentFacesAlertOnMainThread(title: Strings.moonSignChanged, message: Strings.moonSignUnknown, buttonTitle: Strings.ok)
            
        case .rising:
            face.risingSign = Strings.risingUnknown
            self.presentFacesAlertOnMainThread(title: Strings.risingSignChanged, message: Strings.risingSignUnknown, buttonTitle: Strings.ok)
            
        }

        refreshButtons()
        
        dataController.save()
        
    }
    
    private func stackedGrid(rows: Int, columns: Int, labelTitle: String, placement: Placement) {
        
        view.addSubview(astroTitleLabel)
        astroTitleLabel.text = labelTitle
        astroTitleLabel.textAlignment = .left
                
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for row in 0 ..< rows {
            
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = padding
            
            for col in 0 ..< columns {
                
                let button = FacesAstroButton(title: "\(astroKeys[(row * columns) + col])")
                refresh(button: button)
                button.addTarget(self, action: #selector(astroKeyTapped(button:)), for: .touchUpInside)
                horizontalStackView.addArrangedSubview(button)
                
            }
            
            stackView.addArrangedSubview(horizontalStackView)
                
            }
                
        view.addSubview(stackView)
        
        view.addSubview(unknownButton)

        NSLayoutConstraint.activate([
            
            astroTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            astroTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            astroTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        
            stackView.topAnchor.constraint(equalTo: astroTitleLabel.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            unknownButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            unknownButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            unknownButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        
        ])
        
    }
    
    @objc private func astroKeyTapped(button: FacesAstroButton) {
        
        switch placement {
            
        case .sun:
            face.sunSign = "\(button.currentTitle ?? Strings.sunUnknown) " + Strings.sun
            self.presentFacesAlertOnMainThread(title: Strings.sunSignUnknown, message: face.sunSign ?? Strings.unknown, buttonTitle: Strings.ok)
            refresh(button: button)
            break
            
        case .moon:
            face.moonSign = "\(button.currentTitle ?? Strings.moonUnknown) " + Strings.moon
            self.presentFacesAlertOnMainThread(title: Strings.moonSignChanged, message: face.moonSign ?? Strings.unknown, buttonTitle: Strings.ok)
            refresh(button: button)
            break
            
        case .rising:
            face.risingSign = "\(button.currentTitle ?? Strings.risingUnknown) " + Strings.rising
            self.presentFacesAlertOnMainThread(title: Strings.risingSignChanged, message: face.risingSign ?? Strings.unknown, buttonTitle: Strings.ok)
            refresh(button: button)
            break
            
        }
        
        refreshButtons()
                        
        dataController.save()
        
    }
    
    private func refreshButtons() {
        
        for hStackView in stackView.arrangedSubviews {
            
            for button in hStackView.subviews {
                
                let newButton = button as! FacesAstroButton
                newButton.isSelected = false
                refresh(button: newButton)
                
            }
            
        }
        
    }
    
    private func refresh(button: FacesAstroButton) {
        
        switch placement {
            
        case .sun:
            if face.sunSign == "\(button.currentTitle ?? Strings.sunUnknown) " + Strings.sun {
                
                button.isSelected = true
                
            } else { button.isSelected = false }
            
        case .moon:
            if face.moonSign == "\(button.currentTitle ?? Strings.moonUnknown) " + Strings.moon {
                
                button.isSelected = true
                
            } else { button.isSelected = false }
            
        case .rising:
            if face.risingSign == "\(button.currentTitle ?? Strings.risingUnknown) " + Strings.rising {
                
                button.isSelected = true
                
            } else { button.isSelected = false }
            
        }
        
    }

}
