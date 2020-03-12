//
//  GalleryViewController.swift
//  DemoGallery
//
//  Created by Vijay A on 10/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController,UINavigationControllerDelegate {

    //MARK: Properties

    lazy var _collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      cv.delegate = self
      cv.dataSource = self
      cv.register(ImageCell.self, forCellWithReuseIdentifier: "\(ImageCell.self)")
      cv.frame = self.view.bounds
      return cv
    }()
    var pickerController = UIImagePickerController()
    let cellID = "ImageCell"
    
    var galleryViewModel = GalleryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
  
    //MARK: Intial Setup

    private func initialSetup() {
        self.view.addSubview(_collectionView)
        self._collectionView.alwaysBounceVertical = true
        self.view.backgroundColor = UIColor.white
        self._collectionView.backgroundColor = UIColor.white
        pickerController.delegate = self
        self.galleryViewModel.setData()
        self.galleryViewModel.galleryViewModelDelegate = self
        self.navigationItem.title = "Gallery"
        
        // Add Images to local
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = addButton
    }

    //MARK: Add Action

    @objc func addAction() {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
    
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [unowned self] _ in
          //  guard let pickerController = self.pickerController else { return }
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            self.pickerController.sourceType = .camera
            self.present(self.pickerController, animated: true)
        }

        let photoLibraryAction = UIAlertAction(title: "Photos", style: .default) { [unowned self] _ in
            //guard let pickerController = self.pickerController else { return }
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                return
            }
            self.pickerController.sourceType = .photoLibrary
            self.present(self.pickerController, animated: true)

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        optionMenu.addAction(cameraAction)
        optionMenu.addAction(photoLibraryAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)

    }
    
}

extension GalleryViewController: GalleryViewModelDelegate {
    
    func deleteItem(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self._collectionView.deleteItems(at:[indexPath])
        }
    }
    
    func insertNewItem(index: Int) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: index, section: 0)
            self._collectionView.insertItems(at: [indexPath])
        }
    }
    
}

extension GalleryViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        picker.dismiss(animated: true) {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
            let imageDict = ["data": imageData]
            self.galleryViewModel.insertNewImage(image: imageDict)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: CollectionViewDataSource Methods

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.galleryViewModel.galleryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCell
        let galleryImage = self.galleryViewModel.galleryImages[indexPath.item]
        cell.setData(data: galleryImage)
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

//MARK: CollectionViewDelegate Methods
extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewVC = PreviewViewController()
        let nav = UINavigationController(rootViewController: previewVC)
        previewVC.previewDelegate = self
        previewVC.indexPath = indexPath
        self.present(nav, animated: true, completion: nil)
    }
    
}

//MARK: CollectionViewDelegateFlowLayout Methods
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width / 3) , height: (self.view.frame.width / 3) )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: Preview Delegate Method
extension GalleryViewController: PreviewDelegate {
    
    func deleteItemFromGallery(indexPath: IndexPath) {
        self.galleryViewModel.deleteImageAction(indexPath: indexPath)
    }
    
}

