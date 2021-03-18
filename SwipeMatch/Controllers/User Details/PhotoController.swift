//
//  PhotoController.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-03-18.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    init(imageUrl: String) {
        super.init(nibName: nil, bundle: nil)
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
