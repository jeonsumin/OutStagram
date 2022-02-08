//
//  FeedTableViewCell.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import SnapKit
import UIKit

class FeedTableViewCell : UITableViewCell {
    
    //MARK: - Properties
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
       let label = UILabel()
        
        label.text = "홍길동"
        label.textColor = .label
        label.font = .systemFont(ofSize: 12,
                                 weight: .bold)
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
       let label = UILabel()
        
        label.text = "소개~ 소개~"
        label.textColor = .label
        label.font = .systemFont(ofSize: 10,
                                 weight: .semibold)
        
        return label
    }()
    
    
    private lazy var postImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    private let likeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(systemName: "heart")
        
        return button
    }()
    
    private let commentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(systemName: "message")
        
        return button
    }()
    
    private let directMessageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(systemName: "paperplane")
        
        return button
    }()
    
    private let bookmarkButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(systemName: "bookmark")
        
        return button
    }()
    
    private lazy var currentLikedCountLabel : UILabel = {
        let label = UILabel()
        
        label.text = "홍길동 외 32명이 좋아합니다."
        label.textColor = .label
        label.font = .systemFont(ofSize: 13,
                                 weight: .semibold)
        
        return label
    }()
    private lazy var contentLabel : UILabel = {
        let label = UILabel()
        
        label.text = "많이 옷을 때에, 같으며, 못할 품고 방황하여도, 듣는다. 것은 어디 얼마나 열매를 지혜는 얼마나 칼이다. 사랑의 이상의 살 아니다. 따뜻한 것이다.보라, 그들은 이것을 심장의 찾아다녀도, 끓는 위하여서. 피가 찬미를 곳으로 사막이다."
        label.textColor = .label
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 13,
                                 weight: .medium)
        
        return label
    }()
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        
        label.text = "1일 전"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13,
                                 weight: .medium)
        return label
    }()
    
    //MARK: - setupUI
    func setupUI(){
        [
            userImage,
            userNameLabel,
            infoLabel,
            postImageView,
            likeButton,
            commentButton,
            directMessageButton,
            bookmarkButton,
            currentLikedCountLabel,
            contentLabel,
            dateLabel
        ].forEach{
            addSubview($0)
        }
        
        let buttonWidth: CGFloat = 24.0
        let buttonInset: CGFloat = 16.0
        
        userImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(buttonInset)
            $0.top.equalToSuperview().offset(8)
            $0.width.height.equalTo(buttonInset)
        }
        userNameLabel.snp.makeConstraints{
            $0.leading.equalTo(userImage.snp.trailing).offset(8)
            $0.top.equalTo(userImage.snp.top)
        }
        
        infoLabel.snp.makeConstraints{
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(8)
            $0.top.equalTo(userImage.snp.top)
        }
        
        
        postImageView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(userImage.snp.bottom).offset(10)
            $0.height.equalTo(postImageView.snp.width)
        }
        
        likeButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(postImageView.snp.bottom).offset(buttonInset)
            $0.width.height.equalTo(buttonWidth)
        }
        
        commentButton.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.trailing).offset(12)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.height.equalTo(buttonWidth)
        }
        
        directMessageButton.snp.makeConstraints{
            $0.leading.equalTo(commentButton.snp.trailing).offset(12)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.height.equalTo(buttonWidth)
        }
        
        bookmarkButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.height.equalTo(buttonWidth)
        }
        
        currentLikedCountLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(likeButton.snp.bottom).offset(14)
        }
        
        contentLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(currentLikedCountLabel.snp.bottom).offset(8)
        }
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(16)
        }
        
    }
}
