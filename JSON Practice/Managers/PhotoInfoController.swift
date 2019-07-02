//
//  PhotoInfoController.swift
//  JSON Practice
//
//  Created by Denis Bystruev on 02/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class PhotoInfoController {
    let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    var parameters = [
        "api_key": "DEMO_KEY",
        "date": "2019-07-01"
    ]

    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        guard let url = baseURL.withQueries(parameters) else {
            print(#line, #function, "Error creating URL from \(baseURL.absoluteString) with \(parameters)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(#line, #function, "Error getting data from \(url.absoluteString)")
                if let error = error {
                    print(error.localizedDescription)
                }
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let photoInfo = try decoder.decode(PhotoInfo.self, from: data)
                completion(photoInfo)
            } catch {
                print(#line, #function, "Error when parsing \(data)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
