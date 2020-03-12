//
//  GalleryImage+CoreDataProperties.swift
//  DemoGallery
//
//  Created by Vijay A on 11/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData


extension GalleryImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GalleryImage> {
        return NSFetchRequest<GalleryImage>(entityName: "GalleryImage")
    }

    @NSManaged public var filePath: String?

}
