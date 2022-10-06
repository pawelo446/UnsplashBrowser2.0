//
//  NetworkManager.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 22/08/2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    var cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private let apiKey = "bfeknoZmShMsBPmD_6ZNp_0QUtkMcOAX5tP5UiKHDNs"
    private let baseUrl = "https://api.unsplash.com"
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchRequest(for phrase: String, page: Int, color: ColorPicker?) async throws -> PhotoSearchApiResponse {
        
        let colorRequest: String
        if let color = color { colorRequest = "&color=" + color.rawValue } else { colorRequest = "" }
        
        let endpoint = baseUrl + "/search/photos?page="
        + String(page) + "&per_page=30&query=&query="
        + phrase.replacingOccurrences(of: " ", with: "+")
        + colorRequest
        + "&client_id=" + apiKey
        
        guard let url = URL(string: endpoint) else { throw UBError.invalidRequest }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UBError.invalidResponse
        }

        do {
            return try decoder.decode(PhotoSearchApiResponse.self, from: data)
        } catch {
            throw UBError.invalidData
        }
    }
    
    
    func downloadImage (from urlString: String) async throws -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
