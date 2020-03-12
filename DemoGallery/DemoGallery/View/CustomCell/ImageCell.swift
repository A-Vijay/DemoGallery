//
//  ImageCell.swift
//  DemoGallery
//
//  Created by Vijay A on 10/03/20.
//  Copyright © 2020 Goalsr. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
       
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
       }
    
    func setupView() {
        addSubview(imageView)
        imageView.frame = CGRect(x: 4, y: 4, width: self.frame.width - 8, height: self.frame.height - 8)
    }
    
    
      func setData(data: GalleryImage) {
          let id = data.filePath ?? ""
          let data = CommonCode.shared.getFileFromDocumentDirectory(name: id) ?? Data()
          DispatchQueue.main.async {
              let image = UIImage(data: data)
              self.imageView.image = image
          }
      }
}
