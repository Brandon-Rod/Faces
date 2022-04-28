//
//  FavoritesCollectionVC.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/25/22.
//

import UIKit
import CoreData

class FavoritesListVC: UIViewController, NSFetchedResultsControllerDelegate {
    
    private let listsController: NSFetchedResultsController<Face>
    
    let dataController: DataController
    let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    let emptyStateView = FacesEmptyStateView(message: Strings.noFaces)
    
    var faces: [Face] = []
    var filteredFaces: [Face] = []
    
    var isSearchBarEmpty: Bool { return searchController.searchBar.text?.isEmpty ?? true }
    var isFiltering: Bool { return searchController.isActive && !isSearchBarEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureSearchController()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadTableView()
    }
    
    init(dataController: DataController) {
        
        self.dataController = dataController
        
        let request: NSFetchRequest<Face> = Face.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Face.creationDate, ascending: false)]
        request.predicate = NSPredicate(format: Strings.favoriteFormat)

        listsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        
        super.init(nibName: nil, bundle: nil)
        
        listsController.delegate = self
        
        do {
            
            try listsController.performFetch()
            
        } catch {
            
            presentFacesAlertOnMainThread(title: Strings.generalError, message: FacesError.unableToFetchFaces.rawValue, buttonTitle: Strings.ok)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configureViewController() {
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func configureSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Strings.searchBarFavoritesPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        tableView.frame =  view.bounds
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FaceCell.self, forCellReuseIdentifier: FaceCell.reuseID)
        
    }
    
    private func reloadTableView() {
        
        do {
            
            let request: NSFetchRequest<Face> = Face.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Face.creationDate, ascending: false)]
            request.predicate = NSPredicate(format: Strings.favoriteFormat)

            faces = try dataController.container.viewContext.fetch(request)
            
            if faces.isEmpty {
                
                emptyStateView.frame = view.bounds
                view.addSubview(emptyStateView)
                
            } else { emptyStateView.removeFromSuperview() }
            
            DispatchQueue.main.async { self.tableView.reloadData() }
            
        } catch {
            
            presentFacesAlertOnMainThread(title: Strings.generalError, message: FacesError.unableToFetchFaces.rawValue, buttonTitle: Strings.ok)
            
        }
        
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
      filteredFaces = faces.filter { (face: Face) -> Bool in
          
        return face.name!.lowercased().contains(searchText.lowercased())
          
      }
      
        DispatchQueue.main.async { self.tableView.reloadData() }
        
    }

}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        if isFiltering { return filteredFaces.count }
            
        return faces.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FaceCell.reuseID) as! FaceCell
        
        let face: Face
        
        if isFiltering {
            
            face = filteredFaces[indexPath.row]
            
          } else {
              
            face = faces[indexPath.row]
              
          }
        
        cell.set(face: face)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let face: Face
        
        if isFiltering {
            
            face = filteredFaces[indexPath.row]
            
          } else {
              
            face = faces[indexPath.row]
              
          }
        
        let destVC = FacesDetailVC(face: face, dataController: dataController)
        
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: Strings.delete) { [weak self] (action, view, completionHandler) in
            
            self?.deletePerson(indexPath: indexPath)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .systemRed
                
        let face: Face
        
        if isFiltering {
            
            face = filteredFaces[indexPath.row]
            
          } else {
              
            face = faces[indexPath.row]
              
          }
        
        let favoriteAction = UIContextualAction(style: .normal, title: face.isFavorited ? Strings.unfavorite : Strings.favorite) { [weak self] (action, view, completionHandler) in
            
            self?.favoritePerson(indexPath: indexPath)
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = .systemPurple
        
        return UISwipeActionsConfiguration(actions: [deleteAction, favoriteAction])
        
    }
    
    private func deletePerson(indexPath: IndexPath) {
        
        let face: Face
        
        if isFiltering {
            
            face = filteredFaces[indexPath.row]
            
          } else {
              
            face = faces[indexPath.row]
              
          }
        
        let alert = UIAlertController(title: Strings.caution, message: face.name!.isEmpty ? Strings.deleteFace : Strings.deleteFaceWithName + "\(face.name ?? Strings.unknown)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.cancel, style: .cancel))
        alert.addAction(UIAlertAction(title: Strings.delete, style: .destructive, handler: { [weak self] alert in
            
            guard let self = self else { return }
            
            self.dataController.delete(face)
            self.faces.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            self.dataController.save()
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
    private func favoritePerson(indexPath: IndexPath) {
        
        let face: Face
        
        if isFiltering {
            
            face = filteredFaces[indexPath.row]
            
          } else {
              
            face = faces[indexPath.row]
              
          }
        
        if face.isFavorited == false {
            
            face.isFavorited = true
            dataController.save()
            
            self.presentFacesAlertOnMainThread(title: Strings.success, message: face.name!.isEmpty ? Strings.addedToFavorites : "\(face.name ?? Strings.unknown)" + Strings.hasBeenAddedToFavorites, buttonTitle: Strings.ok)
                        
        } else {
            
            face.isFavorited = false
            dataController.save()

            self.presentFacesAlertOnMainThread(title: Strings.welp, message: face.name!.isEmpty ? Strings.removedFromFavorites : "\(face.name ?? Strings.unknown)" + Strings.hasBeenRemovedFromFavorites, buttonTitle: Strings.ok)
                        
        }
        
    }
        
}

extension FavoritesListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
    
}
