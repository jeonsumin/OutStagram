//
//  ProfileDataView.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import SnapKit
import UIKit

class ProfileDataView: UIView {
    private let title : String
    private let count : Int
    
    private lazy var titleLabel:UILabel = {
       let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .medium)
        lb.text = title
        
        return lb
    }()
    
    private lazy var countLabel:UILabel = {
       let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.text = "\(count)"
        
        return lb
    }()
    init(title: String ,count :Int ){
        self.title = title
        self.count = count
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileDataView {
    func setupUI(){
        let stackView = UIStackView(arrangedSubviews: [countLabel, titleLabel])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
