//
//  PhotosLoader.swift
//  Gridy
//
//  Created by James Tapping on 09/12/2020.
//

import Foundation
import UIKit

struct PhotosLoader {
    
    var photos:[UIImage] = []
    
    mutating func loadPhotos() -> [UIImage] {

        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("PlayPhotos") // Bundle URL
        do {
          let contents = try fileManager.contentsOfDirectory(at: assetURL,
         includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey],
         options: .skipsHiddenFiles)
          for item in contents { // item is the URL of everything in MyBundle imgs or otherwise.

              let image = UIImage(contentsOfFile: item.path) // Initializing an image
              photos.append(image!) // Adding the image to the icons array
          }
        }
        catch let error as NSError {
          print(error)
        }
        
        return photos
    
    }
    
}


