//
//  LoginViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/02/07.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    //MARK: - Properties
    
    private let stackView = UIStackView()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "loginBack")
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Outstagram")
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
//        tf.placeholder = "사용자 이름"
        textField.attributedPlaceholder = NSAttributedString(string: "사용자 이름", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .init(white: 1, alpha: 0.3)
        textField.textColor = .label
        textField.addLeftPadding()
        
        return textField
    }()
    private lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .init(white: 1, alpha: 0.3)
        textField.isSecureTextEntry = true
        textField.addLeftPadding()
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .none
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        
        let opacity:CGFloat = 0.5
        
        button.layer.borderColor = UIColor(red: 255,
                                           green: 255,
                                           blue: 255,
                                           alpha: 0.1).cgColor
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("계정이 없으신가요?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .black)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 255,
                                           green: 255,
                                           blue: 255,
                                           alpha: 0.1).cgColor
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    
    
    //MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension LoginViewController {
    
    func setupUI(){
        [backgroundImage,
         stackView,
         registerButton,
         logoImage].forEach{
            view.addSubview($0)
        }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        [idTextField,
         pwTextField,
         loginButton
        ].forEach{
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints{
                $0.height.equalTo(50)
            }
        }
        
        backgroundImage.snp.makeConstraints{
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints{
            $0.top.equalToSuperview().inset(150)
            $0.leading.trailing.equalToSuperview().inset(70)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
        }
        stackView.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        registerButton.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
    }
    @objc func loginButtonTapped(){
        print("loginButton Tapped ")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func registerButtonTapped(){
        print("registerButtonTapped ")
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
