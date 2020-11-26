//
//  NetworkService.swift
//  PhotoMOB
//

import Foundation

protocol NetworkServiceProtocol{
    func searchFor(_ literal: String, complection: @escaping (Result<PhotosResponse?, Error>) -> Void)
    func getNextPage(complection: @escaping (Result<PhotosResponse?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol{
    private var page = 1
    private var literal = ""
    
    func getNextPage(complection: @escaping (Result<PhotosResponse?, Error>) -> Void) {
        page += 1
        
        guard let url = URL(string: URLBuilder.getSearchUrlForItem(literal, page: page)) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                complection(.failure(error))
                return
            }
            
            do{
                let jsStr = String(decoding: data!, as: UTF8.self)
                let properStrJS = JSONModerator.cleanJSON(jsStr)
                let dataJS: Data = properStrJS.data(using: .utf8)!
                let obj = try JSONDecoder().decode(PhotosResponse.self, from: dataJS)
                complection(.success(obj))
            } catch{
                complection(.failure(error))
            }
        }.resume()
    }
    
    func searchFor(_ literal: String, complection: @escaping (Result<PhotosResponse?, Error>) -> Void) {
        self.literal = literal
        self.page = 1
        
        guard let url = URL(string: URLBuilder.getSearchUrlForItem(literal)) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                complection(.failure(error))
                return
            }
            
            do{
                let jsStr = String(decoding: data!, as: UTF8.self)
                let properStrJS = JSONModerator.cleanJSON(jsStr)
                let dataJS: Data = properStrJS.data(using: .utf8)!
                let obj = try JSONDecoder().decode(PhotosResponse.self, from: dataJS)
                complection(.success(obj))
            } catch{
                complection(.failure(error))
            }
        }.resume()
    }
}

final class URLBuilder{
    static func getSearchUrlForItem(_ literal: String) -> String{
        return
            "\(Constants.base_url)method=\(Method.search.rawValue)&format=\(Constants.format)&api_key=\(Constants.api_key)&text=\(literal)&per_page=\(Constants.items_per_page)&page=1"
    }
    
    static func getSearchUrlForItem(_ literal: String, page: Int) -> String{
        return
            "\(Constants.base_url)method=\(Method.search.rawValue)&format=\(Constants.format)&api_key=\(Constants.api_key)&text=\(literal)&per_page=\(Constants.items_per_page)&page=\(page)"
    }
    
    static func getUrlForImage(secret: String, id: String, server: String) -> String{
        let urlSt = "\(Constants.base_url_image)\(server)/\(id)_\(secret).jpg"
        
        return urlSt
    }
}

final private class JSONModerator{
    static func cleanJSON(_ json: String) -> String {
        let modJS =  json.dropFirst(14) // remove jsonFlickrApi(
        let properJS = String(modJS.dropLast(1)) // remove ) from responce to successfully decode
        return properJS
    }
}


fileprivate enum Method: String{
    case search = "flickr.photos.search"
}

fileprivate struct Constants{
    fileprivate static let api_key = "9117c2bf85184db2251e34a9d126fd7a"
    fileprivate static let base_url = "https://www.flickr.com/services/rest/?"
    fileprivate static let base_url_image = "https://live.staticflickr.com/"
    fileprivate static let items_per_page = 30
    fileprivate static let format = "json"
}
