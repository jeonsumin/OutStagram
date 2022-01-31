//
//  UploadViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/02/01.
//

import UIKit
import SnapKit

class UploadViewController: UIViewController {
    
    //MARK: -Properties
    
    private var uploadImage = UIImage()
    
    private let imageView = UIImageView()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15)
        textView.text = "문구 입력..."
        textView.textColor = .secondaryLabel
        
        
        textView.delegate = self 
        return textView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationItems()
        setupUI()
        imageView.image = uploadImage
    }
    
    init(uploadImage: UIImage) {
        self.uploadImage = uploadImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UploadViewController :UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
            
        
    }
}


private extension UploadViewController{
    func setupNavigationItems(){
        navigationItem.title = "새 게시글"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTappedLeftButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "공유",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTappedrightButton))
    }
    
    func setupUI(){
        [imageView,textView].forEach{ view.addSubview($0) }
        
        let imageViewInset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(imageViewInset)
            $0.width.equalTo(100)
            $0.height.equalTo(imageView.snp.width)
        }
        
        textView.snp.makeConstraints{
            $0.leading.equalTo(imageView.snp.trailing).offset(imageViewInset)
            $0.trailing.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(imageView.snp.top)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
    
    @objc func didTappedLeftButton(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTappedrightButton(){
        // TODO: 저장하기
        dismiss(animated: true, completion: nil)
    }
}
