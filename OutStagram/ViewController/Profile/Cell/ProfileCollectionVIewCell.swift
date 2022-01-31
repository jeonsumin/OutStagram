//
//  ProfileCollectionVIewCell.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import SnapKit
import UIKit

class ProfileCollectionVIewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setupUI(with image: UIImage){
        addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        imageView.backgroundColor = .tertiaryLabel
        imageView.image = image
    }
}
