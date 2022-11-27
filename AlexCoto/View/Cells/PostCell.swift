//
//  PostCell.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import Foundation
import UIKit

protocol PostCellDelegate {
    func didFavorite(_ cell:UITableViewCell)
    func didRemoveFavorite(_ cell:UITableViewCell)
}

class PostCell:UITableViewCell {
    static var identifier:String = "post_cell"
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var commentLabel:UILabel?
    
    //Defined separately to avoid initializing images or having vars for images.
    @IBOutlet var favoriteButton:UIButton?
    @IBOutlet var unfavoriteButton:UIButton?
    
    var delegate:PostCellDelegate? = nil
    
    @IBAction func favoriteTapped() {
        self.favoriteButton?.isHidden = true
        self.unfavoriteButton?.isHidden = false
        self.delegate?.didFavorite(self)
    }
    
    @IBAction func unfavoriteTapped() {
        self.favoriteButton?.isHidden = false
        self.unfavoriteButton?.isHidden = true
        self.delegate?.didRemoveFavorite(self)
    }
    
    func populateCell(_ post:Post) {
        self.titleLabel?.text = post.title
        self.commentLabel?.text = post.body
        self.unfavoriteButton?.isHidden = !post.favorite
        self.favoriteButton?.isHidden = post.favorite
    }
}
