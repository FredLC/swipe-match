//
//  SwipingPhotosController.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-03-15.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource {
    
    let controllers = [
        PhotoController(image: #imageLiteral(resourceName: "boost_circle")),
        PhotoController(image: #imageLiteral(resourceName: "super_like_circle")),
        PhotoController(image: #imageLiteral(resourceName: "refresh_circle")),
        PhotoController(image: #imageLiteral(resourceName: "dismiss_circle")),
        PhotoController(image: #imageLiteral(resourceName: "like_circle"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        view.backgroundColor = .white
        
        setViewControllers([controllers.first!], direction: .forward, animated: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
}

class PhotoController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
