//
//  StringExtension.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import Foundation
import UIKit

extension String {
    // This would be the only candidate for testing, however I've encounter boundingRect to be unreliable so I won't waste time on it, I've already done it and there are always exceptions.
    func calculateNumOfLines(withFont font:UIFont, width:CGFloat) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let textSize = self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
