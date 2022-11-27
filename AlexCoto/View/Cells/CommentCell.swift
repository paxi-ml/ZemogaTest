//
//  CommentCell.swift
//  AlexCoto
//
//  Created by Alexander Coto on 26/11/22.
//

import Foundation
import UIKit

class CommentCell:UITableViewCell {
    static var identifier:String = "comment_cell"
    @IBOutlet var commentLabel:UILabel?
    @IBOutlet var emailLabel:UILabel?
}
