//
//  CommonCode.swift
//  DemoGallery
//
//  Created by Vijay A on 11/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

class CommonCode: NSObject {
    
    static let shared = CommonCode()
    private override init() {}
    
    func removeFileFromDocumentDirectory(name: String) {

        let fileManager = FileManager.default
        guard let documentDirectory = CoreDataStack.shared.applicationDocumentsDirectory() else { return }
        let fileURL = documentDirectory.appendingPathComponent(name)
        do {
            try fileManager.removeItem(at: fileURL)
        } catch let err {
            print(err.localizedDescription)
        }
        
    }

    func storeFileToDocumentDirectory(data: Data, name: String) {
        guard let documentDirectory = CoreDataStack.shared.applicationDocumentsDirectory() else { return }
        let fileURL = documentDirectory.appendingPathComponent(name)
        do {
            try data.write(to: fileURL)
        } catch let err{
            print(err.localizedDescription)
        }
    }

    func getFileFromDocumentDirectory(name: String) -> Data? {
        guard let documentDirectory = CoreDataStack.shared.applicationDocumentsDirectory() else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(name)
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
    
    
}
