//
//  ErrorMessages.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 22/08/2022.
//

import Foundation

enum UBError: String, Error {
    case invalidRequest = "This phrase created invalid request. Please try again."
    case unableToComplete = "Unable to complete your request, check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToFavorite = "There was a problem favoritimg this user"
    case alreadyInFavorites = "You already favorited this person"
}
