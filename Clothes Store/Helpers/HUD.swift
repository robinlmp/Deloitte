//
//  HUD.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


class AnimateMe {

    class func animateLabel(_ label: UIView){
        
        // There's a bug here that if you trigger the animation again before completion.
        // Seems that viewOriginalPosition is set incorrectly. Needs looking at.
        // Tried a few things.
        
        let viewOriginalPosition = CGRect(x: label.frame.minX, y: label.frame.minY, width: label.frame.width, height: label.frame.height)

        UIView.animate(withDuration: 0.75, delay: 0.0, options: [.curveEaseOut], animations: {

            label.frame = CGRect(x: label.frame.minX, y: label.frame.minY - 65, width: label.frame.width, height: label.frame.height)
            label.alpha = 0.0

        }, completion: { (finished: Bool) in
            label.frame = viewOriginalPosition
            label.alpha = 1.0

        })
    }
}
