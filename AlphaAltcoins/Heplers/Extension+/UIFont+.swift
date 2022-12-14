//
//  UIFont+.swift
//  AlphaAltcoins
//
//  Created by Илья on 14.12.2022.
//

import Foundation
import UIKit

extension UIFont {
    
    static func helvelticaRegular(with size: CGFloat) -> UIFont {
        UIFont(name: "Helvetica", size: size) ?? UIFont()
    }
}
