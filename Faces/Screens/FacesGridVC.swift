//
//  FacesGridVC.swift
//  Faces
//
//  Created by Brandon Rodriguez on 4/12/22.
//

import UIKit

private enum AstroType: String {

    case sun, moon, rising

}

class FacesGridVC: UIViewController {
    
    private let dataController: DataController
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let sunSignGrid = UIView()
    private let moonSignGrid = UIView()
    private let risingSignGrid = UIView()
    
    private let padding: CGFloat = 20
    private let astroTitleLabel = FacesCellLabel(fontType: .title1)
    private let unknownButton = FacesButton(backgroundColor: .systemPurple, title: Strings.unknown)
    
    private var face: Face
    private var astroViews: [UIView] = []
    
    init(face: Face, dataController: DataController) {
        
        self.face = face
        self.dataController = dataController
                
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        configureUIElements(face: face)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataController.save()
        
    }
    
    private func configureViewController() {
        
        title = Strings.astrology
        view.backgroundColor = .systemBackground
        
    }
    
    private func configureScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
        
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1220)
        
        ])
        
    }
    
    private func layoutUI() {
        
        astroViews = [moonSignGrid, risingSignGrid]
        
        contentView.addSubview(sunSignGrid)
        sunSignGrid.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            sunSignGrid.topAnchor.constraint(equalTo: contentView.topAnchor),
            sunSignGrid.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sunSignGrid.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sunSignGrid.heightAnchor.constraint(equalToConstant: 400)
        
        ])
        
        for astroView in astroViews {

            contentView.addSubview(astroView)
            astroView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([

                astroView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                astroView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                astroView.heightAnchor.constraint(equalToConstant: 400)

            ])

        }

        NSLayoutConstraint.activate([

            moonSignGrid.topAnchor.constraint(equalTo: sunSignGrid.bottomAnchor, constant: 0),

            risingSignGrid.topAnchor.constraint(equalTo: moonSignGrid.bottomAnchor, constant: 0)

        ])

    }
    
    private func configureUIElements(face: Face) {

        DispatchQueue.main.async {
            
            self.add(childVC: AstroGridVC(face: face, signType: Strings.sunSign, placement: .sun, dataController: self.dataController), to: self.sunSignGrid)
            self.add(childVC: AstroGridVC(face: face, signType: Strings.moonSign, placement: .moon, dataController: self.dataController), to: self.moonSignGrid)
            self.add(childVC: AstroGridVC(face: face, signType: Strings.risingSign, placement: .rising, dataController: self.dataController), to: self.risingSignGrid)
            
        }

    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
}
