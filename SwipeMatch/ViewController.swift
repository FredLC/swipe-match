//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-01-24.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subviews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { (color) -> UIView in
            let view = UIView()
            view.backgroundColor = color
            return view
        }
        
        let topStackView = UIStackView(arrangedSubviews: subviews)
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .systemBlue
        let yellowView = UIView()
        yellowView.backgroundColor = .systemYellow
        yellowView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, blueView, yellowView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.frame = .init(x: 0, y: 0, width: 300, height: 200)
        
        stackView.fillSuperview()
    }


}

