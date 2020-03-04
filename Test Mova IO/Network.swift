//
//  Network.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit


func GET_REQUEST(url: String,parameters: [String:String], completion:@escaping (Data?, Error?) -> ()){
    var components = URLComponents(string: url)!
    components.queryItems = parameters.map { (key, value) in
        URLQueryItem(name: key, value: value)
    }
    let request = URLRequest(url: components.url!)
    print("REQUEST URL \(request)")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data,
            let response = response as? HTTPURLResponse,
            (200 ..< 300) ~= response.statusCode,
            error == nil else {
                completion(nil, error)
                return
        }
        completion(data, nil)
    }
    task.resume()
}


func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}
func downloadImage(from urlString: String?, completion:@escaping (_ : UIImage?) -> ()) {
    if let urlString = urlString{
        if let url = URL(string: urlString){
            print("Download Started")
            getData(from: url) { data, response, error in
                if let error = error{
                    print(error.localizedDescription)
                    completion(nil)
                }
                else{
                    if let data = data{
                        print("Download Finished")
                        DispatchQueue.main.async() {
                            completion(UIImage(data: data))
                        }
                    }
                }
            }
        }else{
            completion(nil)
        }
    }else{
        completion(nil)
    }
}

