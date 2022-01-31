//
//  FeedViewController.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import SnapKit
import UIKit

class FeedViewController: UIViewController {
    let tableView = UITableView(frame: .zero)
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupTableView()
    }

}

//MARK: - Private Function
private extension FeedViewController {
    
    func setupNavigationBar(){
        navigationItem.title = "OutStagram"
        
        let uploadButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                           style: .plain,
                                           target: self,
                                           action: nil)

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
    
}
