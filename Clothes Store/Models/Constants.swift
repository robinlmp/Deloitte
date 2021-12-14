//
//  Constants.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation
import UIKit

enum URLCall : String {
    case catalogue = "https://api.npoint.io/0f78766a6d68832d309d"
}

extension UIColor{

    class var primaryColour: UIColor{
        return #colorLiteral(red: 1, green: 0.3348520994, blue: 0.4051724672, alpha: 1)
    }
    
    
// added the two colours below for button styling
    class var pressedColour: UIColor{
        return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    class var pressedColourForWhite: UIColor{
        return #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
    }
}
