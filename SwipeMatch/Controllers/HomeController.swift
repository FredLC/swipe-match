//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-01-24.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeBottomControlsStackView()
    
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            Advertiser(title: "Slide Out Menu", brandName: "Lets Build That App", posterPhotoName: "slide_out_menu_poster"),
            User(name: "Kelly", age: 23, profession: "DJ", imageName: "lady5c"),
            User(name: "Jane", age: 28, profession: "Teacher", imageName: "lady4c")
            ] as [ProducesCardViewModel]
        
        let viewModels = producers.map({ return $0.toCardViewModel() })
        return viewModels
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }

    // MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
}

