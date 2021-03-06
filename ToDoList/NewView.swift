//
//  NewView.swift
//  ToDoList
//
//  Created by Sanatzhan Aimukambetov on 20.11.2020.
//

import UIKit
import SnapKit

class NewView: UIView {
    // MARK: Closures
    var onClose: (() -> ())?
    var onAdd: ((_ item: Item) -> ())?
    
    let bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = .gray
        return bottomLine
    }()
    
    var imageOfIcon: UIImage?
    var indexOfIcon: Int = -1
    var cells = IconModel.fetchIcons()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.placeholder = "Что хотите сделать?"
        textField.textColor = .black
        textField.borderStyle = .none
        return textField
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        addButton.backgroundColor = ConstantsOfValues.colorOfButton
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOpacity = 0.1
        addButton.layer.shadowRadius = 1
        addButton.layer.masksToBounds = false
        addButton.layer.cornerRadius = 15
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        return addButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
        galleryCollectionView.set(cells: IconModel.fetchIcons())
        galleryCollectionView.imageAtIndexPath = { [weak self] item in
            guard let self = self else { return }
            self.indexOfIcon = item.row % 5
            self.imageOfIcon = self.cells[self.indexOfIcon].image
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    @objc private func add() {
        
        if imageOfIcon == nil {
            imageOfIcon = #imageLiteral(resourceName: "addButton2")
            let imageData = imageOfIcon?.pngData()
            let item = Item(nameItem: textField.text!, imageItem: imageData)
            onAdd!(item)
        } else {
            let imageData = imageOfIcon?.pngData()
            let item = Item(nameItem: textField.text!, imageItem: imageData)
            onAdd!(item)
        }
    }
    
    private func setupViews() {
        addSubview(textField)
        addSubview(bottomLine)
        addSubview(galleryCollectionView)
        addSubview(addButton)
        
    }
    
    private func setupConstraints() {
        
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(35)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.equalTo(textField)
        }
        
        galleryCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomLine.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }
        galleryCollectionView.layer.cornerRadius = 15
        galleryCollectionView.layer.borderWidth = 0
        
        addButton.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.top.equalTo(galleryCollectionView.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(45)
        }
    }

}

extension NewView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        addButton.isEnabled = textField.text?.isEmpty == false ? true : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension NewView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
