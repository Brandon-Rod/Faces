//
//  FacesDetailVC.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/26/22.
//

import UIKit

class FacesDetailVC: UIViewController {
    
    private let dataController: DataController
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
        
    private let faceImageView = FacesImageView(frame: .zero)
    private let imagePickerButton = FacesButton(backgroundColor: .systemPurple, title: Strings.addImage)
    private let nameLabel = FacesDetailTitleLabel(text: Strings.name)
    private let pronounsLabel = FacesDetailTitleLabel(text: Strings.pronouns)
    private let pronounsSegmentedControl = UISegmentedControl(items: [Strings.undefined, Strings.heHim, Strings.sheHer, Strings.theyThem])
    private let nameTextField = FacesTextField(placeholder: Strings.enterName)
    private let bioLabel = FacesDetailTitleLabel(text: Strings.bio)
    private let bioTextView = FacesTextView(placeholder: Strings.enterBio)
    private let dateStackView = UIStackView()
    private let birthdayLabel = FacesDetailTitleLabel(text: Strings.birthDay)
    private let datePicker = UIDatePicker()
    private let astroStackView = UIStackView()
    private let sunSignLabel = FacesAstroTitleLabel(text: "")
    private let moonSignLabel = FacesAstroTitleLabel(text: "")
    private let risingSignLabel = FacesAstroTitleLabel(text: "")
    private let astroSegue = FacesButton(backgroundColor: .systemPurple, title: Strings.astrology)
    private let favoriteButton = FacesButton(backgroundColor: .systemPurple, title: "")
    private let deleteButton = FacesButton(backgroundColor: .systemRed, title: Strings.delete)
    
    private var face: Face
    private var dateViews: [UIView] = []
    private var astroViews: [UIView] = []
    private var itemViews: [UIView] = []
    private var isShowingCelebration = false
    
    init(face: Face, dataController: DataController) {
        
        self.face = face
        self.dataController = dataController
        self.sunSignLabel.text = face.sunSign
        
        if face.isFavorited {
            
            self.favoriteButton.setTitle(Strings.unfavorite, for: .normal)
            
        } else {
            
            self.favoriteButton.setTitle(Strings.favorite, for: .normal)
            
        }
        
        faceImageView.setImage(face: face)
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        configurePickerButton()
        configureDataPicker()
        configureDateStackView()
        configureAstroStackView()
        layoutUI()
        configureFavoriteButton()
        configureAstroButton()
        configureDeleteButton()
        addDelegates()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateCoreData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        faceImageView.setImage(face: face)
        sunSignLabel.text = face.sunSign
        moonSignLabel.text = face.moonSign
        risingSignLabel.text = face.risingSign

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        celebrate(birthDay: face.birthDay!)
        
    }
    
    private func updateCoreData() {
        
        face.name = nameTextField.text
        face.bio = bioTextView.text
        face.pronouns = pronounsSegmentedControl.titleForSegment(at: pronounsSegmentedControl.selectedSegmentIndex)
        face.birthDay = datePicker.date
        
        if let image = faceImageView.image {
            
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            face.image = data
            
        } else {
            
            presentFacesAlertOnMainThread(title: Strings.generalError, message: FacesError.unableToSave.rawValue, buttonTitle: Strings.ok)
            
        }
        
        dataController.save()
        
    }
    
    private func configureViewController() {
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = face.name
                
    }
    
    /// If current month and day are equivalent to birthDay, we show the EmittedLayers
    /// - Parameter birthDay: The birthday assign to Face.birthDay
    private func celebrate(birthDay: Date) {
        
        let today = Date.now
        
        if birthDay.isSameDayAndMonth(as: today) {
            
            if !isShowingCelebration {
                
                createEmittedLayer(image: Images.confetti!)
                createEmittedLayer(image: Images.balloon!)
                
//                This prevents the layers from duplicating in viewWillAppear
                isShowingCelebration = true
                
            }
            
        }
        
    }
    
    private func createEmittedLayer(image: UIImage) {
        
        let layer = CAEmitterLayer()
        layer.emitterPosition = CGPoint(x: view.center.x, y: 980)
        
        let colors: [UIColor] = [.systemPurple, .systemBlue, .systemGreen, .systemOrange, .systemRed, .systemMint]
         
        let cells: [CAEmitterCell] = colors.compactMap {
            
            let cell = CAEmitterCell()
            cell.scale = 0.05
            cell.emissionRange = .pi * 2
            cell.lifetime = 20
            cell.birthRate = 10
            cell.velocity = 50
            cell.color = $0.cgColor
            cell.contents = image.cgImage
            return cell
            
        }
        
        layer.emitterCells = cells
        
        view.layer.addSublayer(layer)
        
    }
    
    private func configureScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
        
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1200)
        
        ])
        
    }
    
    private func configurePickerButton() {
        
        imagePickerButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        
    }
    
    private func configureAstroButton() {
        
        astroSegue.addTarget(self, action: #selector(astroSegueTapped), for: .touchUpInside)
        
    }
    
    @objc private func showImagePicker() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    @objc private func astroSegueTapped() {
        
        let destVC = FacesGridVC(face: face, dataController: dataController)
        
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
    private func configureDataPicker() {
        
        datePicker.datePickerMode = .date
        datePicker.date = face.birthDay ?? Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        
    }
    
    private func configureDateStackView() {

        dateStackView.axis = .horizontal
        dateStackView.distribution = .equalSpacing
        dateStackView.alignment = .fill
        dateStackView.isLayoutMarginsRelativeArrangement = true

        let padding: CGFloat = 20
        dateStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)

        dateViews = [birthdayLabel, datePicker]

        for dateView in dateViews {

            dateStackView.addArrangedSubview(dateView)

        }

    }
    
    private func configureAstroStackView() {
        
        astroStackView.axis = .horizontal
        astroStackView.distribution = .equalSpacing
        astroStackView.alignment = .fill
        astroStackView.isLayoutMarginsRelativeArrangement = true

        let padding: CGFloat = 20
        astroStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)

        astroViews = [sunSignLabel, moonSignLabel, risingSignLabel]

        sunSignLabel.text = face.sunSign ?? Strings.sunUnknown
        moonSignLabel.text = face.moonSign ?? Strings.moonUnknown
        risingSignLabel.text = face.risingSign ?? Strings.risingUnknown

        for astroView in astroViews {

            astroStackView.addArrangedSubview(astroView)

        }
        
    }
        
    private func layoutUI() {
        
        itemViews = [faceImageView, imagePickerButton, nameLabel, nameTextField, pronounsLabel, pronounsSegmentedControl, bioLabel, bioTextView, dateStackView, astroStackView, astroSegue, favoriteButton, deleteButton]
                        
        let padding: CGFloat = 20
        let imageWidthAndHeight: CGFloat = 400
        let labelSpacing: CGFloat = 5
        let labelHeight: CGFloat = 26
        let textFieldHeight: CGFloat = 28
        let textViewHeight: CGFloat = 100
        let buttonHeight: CGFloat = 40
        
        for itemView in itemViews {
            
            contentView.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
                        
            NSLayoutConstraint.activate([
            
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            
            ])
            
        }
        
        initializeFields()
        
        NSLayoutConstraint.activate([
        
            faceImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            faceImageView.heightAnchor.constraint(equalToConstant: imageWidthAndHeight),
            faceImageView.widthAnchor.constraint(equalToConstant: imageWidthAndHeight),
            
            imagePickerButton.topAnchor.constraint(equalTo: faceImageView.bottomAnchor, constant: padding),
            imagePickerButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            nameLabel.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: labelSpacing),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            pronounsLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            pronounsLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            pronounsSegmentedControl.topAnchor.constraint(equalTo: pronounsLabel.bottomAnchor, constant: padding),

            bioLabel.topAnchor.constraint(equalTo: pronounsSegmentedControl.bottomAnchor, constant: padding),
            bioLabel.heightAnchor.constraint(equalToConstant: labelHeight),

            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: labelSpacing),
            bioTextView.heightAnchor.constraint(equalToConstant: textViewHeight),
            
            dateStackView.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: padding),
            
            astroSegue.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: padding),
            astroSegue.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            astroStackView.topAnchor.constraint(equalTo: astroSegue.bottomAnchor, constant: padding),

            favoriteButton.topAnchor.constraint(equalTo: astroStackView.bottomAnchor, constant: padding),
            favoriteButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            deleteButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: padding),
            deleteButton.heightAnchor.constraint(equalToConstant: buttonHeight)
                        
        ])
        
    }
    
    private func addDelegates() {
        
        nameTextField.delegate = self
        bioTextView.delegate = self
        
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        
        face.birthDay = sender.date
        
    }
    
    private func configureFavoriteButton() {
        
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        updateCoreData()
        
    }
    
    @objc private func favoriteTapped() {
        
        if face.isFavorited == false {
            
            face.isFavorited = true
            
            self.presentFacesAlertOnMainThread(title: Strings.success, message: face.name!.isEmpty ? Strings.addedToFavorites : "\(face.name ?? Strings.unknown)" + Strings.hasBeenAddedToFavorites, buttonTitle: Strings.ok)
                        
        } else {
            
            face.isFavorited = false
            
            self.presentFacesAlertOnMainThread(title: Strings.welp, message: face.name!.isEmpty ? Strings.removedFromFavorites : "\(face.name ?? Strings.unknown)" + Strings.hasBeenRemovedFromFavorites, buttonTitle: Strings.ok)
                        
        }
        
    }
    
    private func configureDeleteButton() {
        
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
    }
    
    @objc private func deleteTapped() {
        
        let alert = UIAlertController(title: Strings.caution, message: Strings.deleteFace, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.cancel, style: .cancel))
        alert.addAction(UIAlertAction(title: Strings.delete, style: .destructive, handler: { [weak self] alert in
            
            guard let self = self else { return }
            
            self.dataController.delete(self.face)
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
    private func initializeFields() {
        
        checkSelectedSegmentIndex()
        nameTextField.text = face.name
        bioTextView.text = face.bio
        
    }
    
    private func checkSelectedSegmentIndex() {
        
        pronounsSegmentedControl.addTarget(self, action: #selector(pronounDidChange(_:)), for: .valueChanged)
        
        if face.pronouns == Strings.heHim {
            
            pronounsSegmentedControl.selectedSegmentIndex = 1
            
        } else if face.pronouns == Strings.sheHer {
            
            pronounsSegmentedControl.selectedSegmentIndex = 2
            
        } else if face.pronouns == Strings.theyThem {
            
            pronounsSegmentedControl.selectedSegmentIndex = 3
            
        } else {
            
            pronounsSegmentedControl.selectedSegmentIndex = 0
            
        }
        
    }
    
    @objc private func pronounDidChange(_ segmentedControl: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            face.pronouns = Strings.undefined
            
        case 1:
            face.pronouns = Strings.heHim
            
        case 2:
            face.pronouns = Strings.sheHer
            
        case 3:
            face.pronouns = Strings.theyThem

        default:
            face.pronouns = Strings.undefined
            
        }
        
    }

}

extension FacesDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            
            face.image = data
            faceImageView.setImage(face: face)
            updateCoreData()
            
        } else {
            
            presentFacesAlertOnMainThread(title: Strings.generalError, message: FacesError.unableToObtainImage.rawValue, buttonTitle: Strings.ok)
            
        }
        
        picker.dismiss(animated: true)
                
    }
    
}

extension FacesDetailVC: UITextFieldDelegate  {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        return true
        
    }
    
}

extension FacesDetailVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if let character = text.first, character.isNewline {
            
            bioTextView.resignFirstResponder()
            return false
            
        }
        
        return true
            
    }
    
}
