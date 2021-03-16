//
//  SwipingPhotosController.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-03-15.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var cardViewModel: CardViewModel! {
        didSet {
            controllers = cardViewModel.imageNames.map({ (imageUrl) -> UIViewController in
                let photoController = PhotoController(imageUrl: imageUrl)
                return photoController
            })
            
            setViewControllers([controllers.first!], direction: .forward, animated: false)
            
            setupBarViews()
        }
    }
    
    fileprivate let barsStackView = UIStackView(arrangedSubviews: [])
    fileprivate let deselectedColor = UIColor(white: 0, alpha: 0.1)
    
    fileprivate func setupBarViews() {
        cardViewModel.imageNames.forEach { (_) in
            let barView = UIView()
            barView.backgroundColor = deselectedColor
            barView.layer.cornerRadius = 2
            barsStackView.addArrangedSubview(barView)
        }
        
        barsStackView.arrangedSubviews.first?.backgroundColor = .white
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
        view.addSubview(barsStackView)
        barsStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentPhotoController = viewControllers?.first
        if let index = controllers.firstIndex(where: { $0 == currentPhotoController }) {
            barsStackView.arrangedSubviews.forEach({ $0.backgroundColor = deselectedColor })
            barsStackView.arrangedSubviews[index].backgroundColor = .white
        }
    }
    
    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self

        view.backgroundColor = .white
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
    
    init(imageUrl: String) {
        super.init(nibName: nil, bundle: nil)
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
