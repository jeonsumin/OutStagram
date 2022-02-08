//
//  FeedViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import SnapKit
import UIKit

class FeedViewController: UIViewController {
    
    let imagePickerController = UIImagePickerController()
    
    let tableView = UITableView(frame: .zero)
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupTableView()
        setupImagePickerView()
        
    }
    
}


extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none //선택 해제
        cell.setupUI()
        return cell
        
    }
    
}
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let loginVC = LoginViewController()
//        let navigationVC = UINavigationController(rootViewController: loginVC)
//        navigationVC.modalPresentationStyle = .fullScreen
//        self.present(navigationVC, animated: true)
        
        let loginVC = ProfileViewController()
        loginVC.isYn = false
        self.navigationController?.pushViewController(loginVC, animated: true )
     
    }
}

extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage:UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectImage = editedImage
        }else if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImage = originImage
        }
        
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let uploadViewController = UploadViewController(uploadImage: selectImage ?? UIImage())
            let navigationViewController = UINavigationController(rootViewController: uploadViewController)
            navigationViewController.modalPresentationStyle = .fullScreen
            
            self.present(navigationViewController, animated: true , completion: nil)
        }
    }
}

//MARK: - Private Function
private extension FeedViewController {
    
    func setupNavigationBar(){
        navigationItem.title = "OutStagram"
        
        let uploadButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTappedUploadButton))
        
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setupImagePickerView(){
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
    }
    
    @objc func didTappedUploadButton(){
        present(imagePickerController, animated: true, completion: nil)
    }
}
