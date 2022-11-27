//
//  StringExtension.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import Foundation
import UIKit

extension String {
    func calculateNumOfLines(withFont font:UIFont, width:CGFloat) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let textSize = self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
