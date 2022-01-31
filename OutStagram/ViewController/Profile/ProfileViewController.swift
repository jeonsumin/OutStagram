//
//  ProfileViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileImageView : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 40
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "전수민"
        lb.font = .systemFont(ofSize: 14, weight: .semibold)
        return lb
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "안녕하세요."
        lb.font = .systemFont(ofSize: 14, weight: .medium)
        lb.numberOfLines = 0
        return lb
    }()
    
    private lazy var followButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("팔로우", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 3
        
        return btn
    }()
    
    private lazy var messageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("메세지", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        return btn
    }()
    
    private let photoDataView = ProfileDataView(title: "게시글", count: 123)
    private let followerDataView = ProfileDataView(title: "팔로워", count: 1223)
    private let FollowingDataView = ProfileDataView(title: "팔로잉", count: 12)
    
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProfileCollectionVIewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupUI()
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionVIewCell
        cell?.setupUI(with: UIImage())
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width :CGFloat = (collectionView.frame.width / 3) - 1
        return CGSize(width: width, height: width)
    }
}


private extension ProfileViewController {
    func setupNavigationItems(){
        navigationItem.title = "전수민"
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTappedRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func didTappedRightBarButtonItem(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        [
        UIAlertAction(title: "회원 정보 변경", style: .default) { _ in
            print("회원 정보 변경")
        },
        UIAlertAction(title: "탈퇴 하기", style: .destructive) { _ in
            print("탈퇴 하기")
        },
        
        UIAlertAction(title: "닫기", style: .cancel)
        ].forEach {
            alert.addAction($0)
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    func setupUI(){
        let buttonStackView = UIStackView(arrangedSubviews: [followButton,messageButton])
        buttonStackView.spacing = 4
        buttonStackView.distribution = .fillEqually
        
        let dataStackView = UIStackView(arrangedSubviews: [photoDataView,followerDataView,FollowingDataView])
        dataStackView.spacing = 4
        dataStackView.distribution = .fillEqually
        
        [
            profileImageView,
            nameLabel,
            descriptionLabel,
            buttonStackView,
            dataStackView,
            collectionView
        ].forEach{ view.addSubview($0) }
        let inset: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.height.equalTo(80)
        }
        
        
        dataStackView.snp.makeConstraints{
            $0.leading.equalTo(profileImageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.centerY.equalTo(profileImageView.snp.centerY)
        }
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        collectionView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16)
            
        }
    }
}
