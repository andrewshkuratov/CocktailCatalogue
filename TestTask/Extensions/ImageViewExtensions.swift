//
//  ImageViewExtensions.swift
//  TestTask
//
//  Created by Andrew on 14.09.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit
import Alamofire

let imageCache = NSCache<NSString, UIImage>()

//MARK: Custom Image Class
class CustomImageView: UIImageView {
    
    var imageURLString: String?
    
    func loadImageUsingUrlString(imageURL: String) {
        imageURLString = imageURL
        
        let url = URL(string: imageURL)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: imageURL as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageURLString == imageURL {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: imageURL as NSString)
            }
        }.resume()
    }
    
}
