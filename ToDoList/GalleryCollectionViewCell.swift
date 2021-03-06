//
//  GalleryCollectionViewCell.swift
//  ToDoList
//
//  Created by Sanatzhan Aimukambetov on 20.11.2020.
//

import UIKit
import SnapKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        self.contentView.isUserInteractionEnabled = true
        
        mainImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            else
            {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
