//
//  ProfileViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import UIKit
import FirebaseAuth
import SDWebImage

class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    var isYn = true
    let userDefault = UserDefaults.standard
    
    lazy var profileImageView : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 40
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .semibold)
        return lb
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
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
    
    private lazy var editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("프로필 수정", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.tertiaryLabel.cgColor
        btn.addTarget(self, action: #selector(didTappedEditProfileButton), for: .touchUpInside)
        
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationItems()
        setupUI()
    }
}

//MARK: - UICollectionViewDataSource
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
//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width :CGFloat = (collectionView.frame.width / 3) - 1
        return CGSize(width: width, height: width)
    }
}

//MARK: - Private Function
private extension ProfileViewController {
    //MARK: - 네비게이션 아이템 세팅
    func setupNavigationItems(){
        guard let username = userDefault.value(forKey: "userName") as? String else { return }
        
        if isYn {
            navigationItem.title = "\(username)"
            let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(didTappedRightBarButtonItem))
            navigationItem.rightBarButtonItem = rightBarButton
        } else {
            navigationItem.title = "등록"
            
            
            
            let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(didTappedRightBarButtonItem))
            navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    
    //MARK: - UI 세팅
    func setupUI(){
        guard let username = userDefault.value(forKey: "userName") as? String,
              var email = userDefault.value(forKey: "email") as? String,
              let info = userDefault.value(forKey: "description") as? String
        else { return }
        
        
        email = email.replacingOccurrences(of: "@", with: "_")
        email = email.replacingOccurrences(of: ".", with: "_")
        let path = "image/\(email)_profile_image.png"
        print("iamge Path::: \(path)")
        StorageManager.shared.downloadURL(for: path) {[weak self] res in
            guard let self = self else { return }
            switch res {
            case .success(let url):
//                self.profileImageView.sd_setImage(with: url,op)
                self.profileImageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached)
            case .failure(let error):
                print("Image 가져오기 실패! \(error)")
            }
        }
        nameLabel.text = username
        descriptionLabel.text = "\(info)"
        
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
            editProfileButton,
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
        if isYn{
            buttonStackView.isHidden = true
            editProfileButton.isHidden = false
        }else{
            buttonStackView.isHidden = false
            editProfileButton.isHidden = true
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        editProfileButton.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        collectionView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16)
        }
        
        
        
    }
    //MARK: - Button Event
    
    @objc func didTappedEditProfileButton(){
        
        guard let username = userDefault.value(forKey: "userName") as? String ,
              let email = userDefault.value(forKey: "email") as? String ,
              let name = userDefault.value(forKey: "name") as? String
        else { return }
        
        let info = userDefault.value(forKey: "description") as? String
        let editProfileVC = EditProfileViewController()
        let navigationVC = UINavigationController(rootViewController: editProfileVC)
        let user = User(email: email, name: name, username: username,description: info)
        print("user??? ::: \(user)")
        editProfileVC.user = user
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true)
    }
    
    @objc func didTappedRightBarButtonItem(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        [
            UIAlertAction(title: "설정", style: .default) {_ in
                NSLog("설정")
                
            },
            UIAlertAction(title: "탈퇴 하기", style: .destructive) {_ in
                NSLog("탈퇴 하기")
                //            guard let self = self else { return }
                //            let loginVC = LoginViewController()
                //            let navigationVC = UINavigationController(rootViewController: loginVC)
                //            navigationVC.modalPresentationStyle = .fullScreen
                //            navigationVC.modalTransitionStyle = .flipHorizontal
                //            self.present(navigationVC, animated: true, completion: nil)
                
            },
            
            UIAlertAction(title: "로그아웃", style: .destructive) {[weak self] _ in
                guard let self = self else { return }
                do {
                    try FirebaseAuth.Auth.auth().signOut()
                    
                    let loginVC = LoginViewController()
                    let navigationVC = UINavigationController(rootViewController: loginVC)
                    navigationVC.modalPresentationStyle = .fullScreen
                    navigationVC.modalTransitionStyle = .flipHorizontal
                    self.present(navigationVC, animated: true, completion: nil)
                    
                }catch {
                    NSLog("ERROR!!! Failed Logout")
                }
                
            },
            
            UIAlertAction(title: "닫기", style: .cancel)
        ].forEach {
            alert.addAction($0)
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}
