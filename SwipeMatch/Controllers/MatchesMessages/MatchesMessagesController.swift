//
//  MatchesMessagesController.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-03-23.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import LBTATools
import Firebase

struct Match {
    let name, profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}

class MatchCell: LBTAListCell<Match> {
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "kelly1"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "Kelly", font: .systemFont(ofSize: 14), textColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), textAlignment: .center, numberOfLines: 0)
    
    override var item: Match! {
        didSet {
            usernameLabel.text = item.name
            profileImageView.sd_setImage(with: URL(string: item.profileImageUrl))
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        profileImageView.clipsToBounds = true
        profileImageView.constrainWidth(80)
        profileImageView.constrainHeight(80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        stack(stack(profileImageView, alignment: .center), usernameLabel)
    }
}

class MatchesMessagesController: LBTAListController<MatchCell, Match>, UICollectionViewDelegateFlowLayout {
    
    let customNavBar = MatchesNavBar()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: 140)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        fetchMatches()
        
        items = []
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
        collectionView.contentInset.top = 150
    }
    
    fileprivate func fetchMatches() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("matches_messages").document(currentUserId).collection("matches").getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch matches :", err)
                return
            }
            
            var matches = [Match]()
            snapshot?.documents.forEach({ (document) in
                matches.append(.init(dictionary: document.data()))
            })
            
            self.items = matches
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}
