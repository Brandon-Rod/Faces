//
//  Constants.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/25/22.
//

import UIKit

enum SFSymbols {
    
    static let people = UIImage(systemName: "person.3.sequence.fill")
    static let star = UIImage(systemName: "star.fill")
    static let addFace = UIImage(systemName: "person.crop.circle.badge.plus")
    static let face = UIImage(systemName: "person.fill")
    
}

enum Images {
    
    static let placeholder = UIImage(named: "Placeholder")
    static let confetti = UIImage(named: "Confetti")
    static let balloon = UIImage(named: "Balloon")
    
}

enum Strings {
    
    /* FacesVC */
    static let noFaces = "You have no Faces.\nAdd a Face."
    static let sunUnknown = "Sun Unknown"
    static let moonUnknown = "Moon Unknown"
    static let risingUnknown = "Rising Unknown"
    static let astrologicalPlacementsUnknown = "Astrological placements unknown"
    static let success = "Success!"
    static let favorite = "Favorite"
    static let unfavorite = "Unfavorite"
    static let searchBarPlaceholder = "Search for face"
    static let searchBarFavoritesPlaceholder = "Search for favorites"
    static let hasBeenAddedToFavorites = " has been added to favorites"
    static let hasBeenRemovedFromFavorites = " has been removed from favorites"
    
    /* Alerts */
    static let generalError = "Something went wrong"
    static let ok = "OK"
    static let unableToComplete = "Unable to complete request"
    static let delete = "Delete"
    static let caution = "Caution"
    static let cancel = "Cancel"
    static let deleteFace = "Are you sure you want to delete face?"
    static let deleteFaceWithName = "Are you sure you want to delete "
    static let addedToFavorites = "Face has been added to favorites"
    static let welp = "Welp"
    static let removedFromFavorites = "Face has been removed from favorites"
    
    /* FacesDetailVC */
    static let addImage = "Add Image"
    static let birthDay = "Birthday"
    static let astrology = "Astrology"
    static let name = "Name"
    static let pronouns = "Pronouns"
    static let undefined = "Undefined"
    static let heHim = "He/Him"
    static let sheHer = "She/Her"
    static let theyThem = "They/Them"
    static let enterName = "Enter name"
    static let bio = "Bio"
    static let enterBio = "Enter bio"
    
    /* FacesGridVC */
    static let unknown = "Unknown"
    static let sun = "Sun"
    static let sunSign = "Sun Sign"
    static let sunSignChanged = "Sun Sign Changed"
    static let sunSignUnknown = "Sun sign unknown"
    static let moon = "Moon"
    static let moonSign = "Moon Sign"
    static let moonSignChanged = "Moon Sign Changed"
    static let moonSignUnknown = "Moon sign unknown"
    static let rising = "Rising"
    static let risingSign = "Rising Sign"
    static let risingSignChanged = "Rising Sign Changed"
    static let risingSignUnknown = "Rising sign unknown"
    
    /* FavoritesListVC */
    static let noFavorites = "You have no favorites.\nAdd a Face."
    static let favoriteFormat = "isFavorited == true"
    
}
