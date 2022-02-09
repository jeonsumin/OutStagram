//
//  RegisterViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/02/07.
//

import UIKit
import SnapKit
import Firebase

class RegisterViewController: UIViewController {

    private let FBAuth = Auth.auth()
    
    private let stackView = UIStackView()
    //MARK: - Properties
    private lazy var logoImage :UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "registerLogo")
        return image
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "휴대폰번호 또는 이메일주소", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .label
        textField.addLeftPadding()
        return textField
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "성명", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .label
        textField.addLeftPadding()
        return textField
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "사용자 이름", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .label
        textField.addLeftPadding()
        return textField
    }()
    
    private lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .label
        textField.isSecureTextEntry = true
        textField.addLeftPadding()
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var termLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        label.text = "가입하면 Outstagram의 약관 및 개인정보처리방침에 동의하게 됩니다."
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "계정이 있으신가요? 로그인"
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginLabelTapped))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupUI()
    }
}

private extension RegisterViewController {
    //MARK: - setupNavigationController
    func setupNavigationItems(){
        navigationItem.title = "등록"
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.backItem?.title = ""
        
    }
    //MARK: - setupUI
    func setupUI(){
        view.backgroundColor = .systemBackground
        
        [logoImage,
         stackView,
         loginLabel
        ].forEach{view.addSubview($0)}
        
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 10
        
        [
         idTextField,
         nameTextField,
         userNameTextField,
         pwTextField,
         registerButton,
         termLabel
        ].forEach{
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints{
                $0.height.equalTo(40)
            }
        }
        
        logoImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        stackView.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        loginLabel.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
    }
    
    func EmailAndPasswordValidate(message: String = "이메일 또는 비밀번호를 확인해주세요" ){
        let alert = UIAlertController(title: "알림", message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    //MARK: - Button Event
    @objc func loginLabelTapped(){
        print("loginLabelTapped")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func registerButtonTapped(){
        idTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        userNameTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
        guard let email = idTextField.text,
              let name = nameTextField.text,
              let userName = userNameTextField.text,
              let password = pwTextField.text,
              !email.isEmpty,
              !name.isEmpty,
              !password.isEmpty,
              password.count > 6
        else {
            EmailAndPasswordValidate()
            return
        }
        
        DatabaseManager.shared.selectUser(with: email) {[weak self] snapshot in
            guard let self = self else { return }
            guard !snapshot else {
                self.EmailAndPasswordValidate(message: "이미 사용중인 이메일 입니다.")
                return
            }
            
            self.FBAuth.createUser(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    print("createUser ERROR!!! ")
                    return
                }
                
                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue(password, forKey: "password")
                
                let user = User(email: email, name: name, username: userName, password: password)
                DatabaseManager.shared.insertUser(with: user) { success in
                    print(success)
                }
                self.navigationController?.dismiss(animated: true)
            }
        }
        
        
    }
}
