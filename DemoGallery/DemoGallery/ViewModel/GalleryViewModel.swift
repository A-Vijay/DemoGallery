//
//  GalleryViewModel.swift
//  DemoGallery
//
//  Created by Vijay A on 11/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

protocol GalleryViewModelDelegate: class {
    func insertNewItem(index: Int)
    func deleteItem(indexPath: IndexPath)
}

class GalleryViewModel {
    
    var galleryImages: [GalleryImage] = []
    weak var galleryViewModelDelegate: GalleryViewModelDelegate?

      
      func setData() {
          self.galleryImages = CoreDataManager.shared.fetchAllGalleryImages()
      }
    
      func insertNewImage(image: [String: Any]) {
          CoreDataManager.shared.insertImageIntoGallery(imageDictionary: image)
          self.galleryImages = CoreDataManager.shared.fetchAllGalleryImages()
          galleryViewModelDelegate?.insertNewItem(index: self.galleryImages.count - 1)
      }
    
    
      func deleteImageAction(indexPath: IndexPath) {
        let filePath = self.galleryImages[indexPath.item].filePath ?? ""
        CoreDataManager.shared.deleteImageFromGallery(filePath: filePath)
        self.galleryImages = CoreDataManager.shared.fetchAllGalleryImages()
        galleryViewModelDelegate?.deleteItem(indexPath: indexPath)
      }
}
