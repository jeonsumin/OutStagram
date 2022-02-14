//
//  EditProfileViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/02/08.
//

import UIKit
import SnapKit
import SDWebImage
import JGProgressHUD


class EditProfileViewController: UIViewController {
    
    //MARK: - Properties
    var user = User(email: "", name: "", username: "", description: nil)
    let progress = JGProgressHUD(style: .dark)
    
    let imagePickerController = UIImagePickerController()
    let userDefault = UserDefaults.standard
    
    /// 프로필사진
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemGray
        
        return image
    }()
    
    
    /// 프로필이미지 수정 버튼
    private lazy var editProfileImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 사진 바꾸기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(editProfileImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "이름"
        
        return label
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "사용자 이름"
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "소개"
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.addBottomBorder()
        textField.placeholder = "이름"
        
        return textField
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.addBottomBorder()
        textField.placeholder = "사용자 이름"
        
        return textField
    }()
    
    private lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.addBottomBorder()
        textField.placeholder = "소개"
        
        return textField
    }()
    
    private let labelStackView = UIStackView()
    private let TextFieldStackView = UIStackView()
    private let editFieldStackView = UIStackView()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        imagePickerController.delegate = self
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func presentCamera(){
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func presentPhotoLibrary(){
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        }else if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originImage
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true ,completion: nil)
    }
}

//MARK: - Private Function
private extension EditProfileViewController {
    func setupNavigationBar(){
        navigationItem.title = "프로필 수정"
        let leftBarButtonItem = UIBarButtonItem(title: "취소",
                                                style: .plain,
                                                target: self,
                                                action: #selector(cancelEditProfileButtonTapped))
        let rightBarButtonItem = UIBarButtonItem(title: "완료",
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(editProfileButtonTapped))
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupUI(){
        view.backgroundColor = .systemBackground
        [profileImageView,
         editProfileImageButton,
         separatorView,
         labelStackView,
         TextFieldStackView,
         editFieldStackView,
        ].forEach{
            view.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        editProfileImageButton.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints{
            $0.top.equalTo(editProfileImageButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            
        }
        
        [labelStackView,TextFieldStackView].forEach{
            $0.spacing = 20
            $0.alignment = .leading
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            
        }
        [nameLabel,userNameLabel,infoLabel].forEach{
            labelStackView.addArrangedSubview($0)
            $0.snp.makeConstraints{
                $0.height.equalTo(23)
            }
        }
        
        [nameTextField,userNameTextField,infoTextField].forEach{
            TextFieldStackView.addArrangedSubview($0)
        }
        
        labelStackView.snp.makeConstraints{
            $0.top.equalTo(separatorView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
        }

        TextFieldStackView.snp.makeConstraints{
            $0.top.equalTo(separatorView.snp.bottom).offset(20)
            $0.leading.equalTo(labelStackView.snp.trailing).offset(20)
        }
        nameTextField.text = user.name
        userNameTextField.text = user.username
        infoTextField.text = user.description
        
        let path = "image/\(user.safeEmail)_profile_image.png"
        StorageManager.shared.downloadURL(for: path) {[weak self] res in
            switch res {
            case .success(let url):
                self?.profileImageView.sd_setImage(with: url)
            case .failure(let error):
                print("Image 가져오기 실패! \(error)")
            }
        }
    }
    
    //MARK: - Button Event
    @objc func cancelEditProfileButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func editProfileButtonTapped(){
        guard let name = nameTextField.text,
              let username = userNameTextField.text,
              let info = infoTextField.text,
              let image = profileImageView.image,
              let data = image.pngData()
        else { return }
        progress.show(in: view)
        let fileName = user.profileImage
        user.name = name
        user.username = username
        user.description = info
        print("data::: \(data) ")
        DatabaseManager.shared.insertUser(with: user) { result in
            if result {
                StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName) {[weak self] res in
                    guard let self = self else { return }
                    switch res {
                    case .success(let downloadUrl):
                        self.progress.dismiss(animated: true)
                        
                        UserDefaults.standard.set(downloadUrl, forKey: "profilePicture")
                        let vc = ProfileViewController()
                        let url = URL(string: downloadUrl)
                        vc.profileImageView.sd_setImage(with: url   )
                        self.navigationController?.dismiss(animated: true, completion: nil)
                        
                    case .failure(let error) :
                        print("StorageManager ERROR!!! \(error)")
                    }
                }
            }
            
        }
        UserDefaults.standard.set(info, forKey: "description")
        
        
    }
    
    @objc func editProfileImageButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        [UIAlertAction(title: "사진 삭제", style: .default) { _ in
            print("deletePicturesButton")
        },
        UIAlertAction(title: "사진 찍기", style: .default) { _ in
            self.presentCamera()
        },
        UIAlertAction(title: "라이브러리에서 선택", style: .default) { _ in
            self.presentPhotoLibrary()
        },
        UIAlertAction(title: "취소", style: .cancel)
        ].forEach{
            alert.addAction($0)
        }
        self.present(alert, animated: true)
    }
}
