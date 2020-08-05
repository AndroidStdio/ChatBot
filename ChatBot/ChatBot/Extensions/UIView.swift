//
//  UIView.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

extension UIView {
    
    // This function is to add views all together instead of one at a time
    func addSubviews(views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
