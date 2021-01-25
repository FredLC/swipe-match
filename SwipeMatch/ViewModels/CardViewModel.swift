//
//  CardViewModel.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-01-25.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}
