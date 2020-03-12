//
//  PreviewViewController.swift
//  DemoGallery
//
//  Created by Vijay A on 11/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit


protocol PreviewDelegate: class {
    func deleteItemFromGallery(indexPath: IndexPath)
}

class PreviewViewController: UIViewController {

    //MARK: Properties
    
    lazy var imageView: UIImageView = {
         let iv = UIImageView()
         iv.contentMode = .scaleAspectFit
        iv.frame = self.view.bounds
         return iv
     }()
    
    var indexPath :IndexPath?
    weak var previewDelegate: PreviewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }

    //MARK: Intial Setup

    private func initialSetup() {
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        let title = indexPath!.item + 1
        self.navigationItem.title = "IMG-\(title)"
     
        let deleteButton = UIBarButtonItem.init(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
        self.navigationItem.rightBarButtonItem = deleteButton
     
        let cancelButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.leftBarButtonItem = cancelButton
     
        previewImage()
    }
    
    
    //MARK: Preview Image

    func previewImage(){
        let galleryViewModel = GalleryViewModel()
        galleryViewModel.setData()
        let previewImage = galleryViewModel.galleryImages[indexPath!.item]
        guard let galleryImage = previewImage.filePath else{ return }
        let data = CommonCode.shared.getFileFromDocumentDirectory(name: galleryImage) ?? Data()
        DispatchQueue.main.async {
            let image = UIImage(data: data)
            self.imageView.image = image
        }
    }
    
    @objc func deleteAction() {
        if previewDelegate != nil {
            previewDelegate?.deleteItemFromGallery(indexPath: self.indexPath!)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func cancelAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
