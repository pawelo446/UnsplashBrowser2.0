import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {static let favorites = "favorites"}
    
    static func updateWith(favorite: Picture, actionType: PersistanceActionType, completed: @escaping (UBError?) -> Void) {
        retrieveFavorites { result in
            
            switch result {
                
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.id == favorite.id }
                }
                
                completed(save(favourites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Picture], UBError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Picture].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    static func retrieveIDs() -> [String] {
        var cos: [String] = []
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                cos = favorites.map {$0.id}
            case .failure(let error):
                print(error.rawValue)
            }
        }
        print(cos)
        return cos
    }
    
    
    static func save(favourites: [Picture]) -> UBError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favourites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}

