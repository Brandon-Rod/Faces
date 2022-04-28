//
//  ErrorMessage.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/26/22.
//

import Foundation

enum FacesError: String, Error {
    
    case unableToFetchFaces = "Unable to obtain faces right not. Please try again at a later time."
    case unableToCompleteRequest = "Unable to complete your request. Please check your internet connected."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "Unable to favorite face."
    case alreadyInFavorites = "Face is already in favorites."
    case unableToSave = "Unable to save to database. Please try at a later time."
    case unableToObtainImage = "Unable to obtain image. Please try at a later time."
    
}
