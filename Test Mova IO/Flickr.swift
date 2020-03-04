//
//  Flickr.swift
//  Test Mova IO
//
//  Created by Artem Shpilka on 3/3/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit

class Flickr{
    static let shared = Flickr()
    
    private init(){}

    func searchPhotos(text: String, completion:@escaping (UIImage?, Error?) -> ()){
        let parameters: [String: String] = [
            "method":"flickr.photos.search",
            "api_key":API_KEY,
            "text": text,
            "format": "json",
            "nojsoncallback":"1"
        ]
        GET_REQUEST(url: API_URL, parameters: parameters) { (data, error) in
            if let data = data{
                if let flickrPhotosSearchObject = try? JSONDecoder().decode(FlickrPhotosSearchResponce.self, from: data){
                    if flickrPhotosSearchObject.photos.photo.count == 0{
                        completion(nil, error)
                    }
                    self.getRandomPhoto(flickrObject: flickrPhotosSearchObject) { (image, error) in
                        completion(image, error)
                    }
                }else{
                    completion(nil, error)
                }
            }else if let error = error{
                completion(nil, error)
            }
        }
    }
    
    private func getRandomPhoto(flickrObject: FlickrPhotosSearchResponce, completion:@escaping (UIImage?, Error?) -> ()){
        guard let randomElement = flickrObject.photos.photo.randomElement() else{
            completion(nil, nil)
            return
        }
        getPhoto(id: randomElement.id) { (image, error) in
            completion(image, error)
        }
    }
    
    private func getPhoto(id: String, completion:@escaping (UIImage?, Error?) -> ()){
        let parameters: [String: String] = [
            "method":"flickr.photos.getSizes",
            "api_key":API_KEY,
            "photo_id": id,
            "format": "json",
            "nojsoncallback":"1"
        ]
        GET_REQUEST(url: API_URL, parameters: parameters) { (data, error) in
            if let data = data{
                if let flickrPhotosGetSizesObject = try? JSONDecoder().decode(FlickrPhotosGetSizesResponse.self, from: data){
                    // download IMAGE
                    if let mediumSizePhotoObject = flickrPhotosGetSizesObject.sizes.size.first(where: { (item) -> Bool in
                        return item.label == "Medium"
                    }){
                        downloadImage(from: mediumSizePhotoObject.source) { (image) in
                            completion(image, nil)
                        }
                    }else{
                        completion(nil,error)
                    }
                }else{
                    completion(nil,error)
                }
            }else if let error = error{
                completion(nil, error)
            }
        }
    }
}

