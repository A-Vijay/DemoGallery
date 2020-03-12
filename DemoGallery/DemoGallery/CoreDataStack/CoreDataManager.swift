//
//  CoreDataManager.swift
//  DemoGallery
//
//  Created by Vijay A on 10/03/20.
//  Copyright © 2020 Goalsr. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    //MARK: Singleton
    static let shared = CoreDataManager()
    private override init() {}
    
    private let galleryEntity = "GalleryImage"
    
    func fetchAllGalleryImages() -> [GalleryImage] {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: galleryEntity)
         
         do
         {
             let test = try context.fetch(fetchRequest)
             if test.count > 0 {
                 if let galleryImages = test as? [GalleryImage]{
                     return galleryImages
                 }
             }
         }
         catch
         {
            print(error.localizedDescription)
         }
        return []
        
    }
    
    func insertImageIntoGallery(imageDictionary: [String: Any]) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        guard let galleryImage = NSEntityDescription.insertNewObject(forEntityName: galleryEntity, into: context) as? GalleryImage else { return }
        let timeStamp = "\(Date().timeIntervalSince1970 * 1000)"
        let id = timeStamp
        let data = imageDictionary["data"] as? Data ?? Data()
        galleryImage.filePath = id
        CommonCode.shared.storeFileToDocumentDirectory(data: data, name: id)
        CoreDataStack.shared.saveContext()
        
    }
    
    func deleteImageFromGallery(filePath: String) {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let images = CoreDataManager.shared.fetchAllGalleryImages()
        for image in images {
            if filePath == (image.filePath ?? "") {
                context.delete(image)
            }
        }
        CoreDataStack.shared.saveContext()
        
    }
    
}
