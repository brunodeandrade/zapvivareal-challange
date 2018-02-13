//
//  RequestService.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 12/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case error(Error)
}

class RequestService {

    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getTopGames(completion: @escaping(Result<[Game]>) -> Void ) {
    
        guard let url = URL(string: "https://api.twitch.tv/kraken/games/top?limit=20") else {return}
        var request = URLRequest(url: url)
        request.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        request.setValue("vled30n24p8otfurwpftu3ov144z38", forHTTPHeaderField: "Client-ID")
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.error(error))
                    return
                }
                
                if let data = data,
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDict = jsonObject as? [String: Any] {
                    let gameList = GameApiParser.parseGames(jsonDict)
                    completion(.success(gameList))
                    return
                }
            }
        }.resume()
    
    }
    
    static func getImageFromUrl(urlStr: String) -> UIImage? {
        var image: UIImage?
        if let url = URL(string: urlStr) {
            guard let data = try? Data(contentsOf: url) else {return image}
            image = UIImage(data: data)
        }
        return image
    }
    
}
