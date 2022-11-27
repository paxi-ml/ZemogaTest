//
//  PostDetailViewController.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import Foundation
import UIKit

class PostDetailViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    var post:Post? = nil
    var user:User? = nil
    var comments:[Comment] = []
    
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var bodyLabel:UILabel?
    
    @IBOutlet var nameLabel:UILabel?
    @IBOutlet var usernameLabel:UILabel?
    @IBOutlet var emailLabel:UILabel?
    @IBOutlet var phoneLabel:UILabel?
    @IBOutlet var addressLabel:UILabel?
    @IBOutlet var companyLabel:UILabel?
    
    @IBOutlet var commentsTable:UITableView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        self.customizeAppearance()
    }
    
    // MARK: - Table functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
            let comment = self.comments[indexPath.row]
            cell.populateCell(comment)
            return cell
        }
        //This shouldn't happen
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let comment = self.comments[indexPath.row]
        return 48.0 + (CGFloat(comment.body.calculateNumOfLines(withFont: UIFont.systemFont(ofSize: 14), width: self.view.frame.size.width - 40)) * 18.0)
    }
    
    func customizeAppearance() {
        self.title = "Post Detail"
        self.nameLabel?.superview?.layer.borderWidth = 1.0
        self.nameLabel?.superview?.layer.borderColor = UIColor.black.cgColor
    }
    
    func loadData() {
        self.titleLabel?.text = self.post?.title
        self.bodyLabel?.text = self.post?.body
        
        JSONPlaceholderService.sharedService().requestWithPath("/users/\(self.post?.userId ?? 0)") { response in
            switch response.result {
            case let .success(value):
                if let dict = value as? [String:Any] {
                    self.user = User()
                    self.user?.populateWithDict(dict)
                    self.populateUserInfo()
                }
            case let .failure(error):
                return
            }
        }
        JSONPlaceholderService.sharedService().requestWithPath("/posts/\(self.post?.postId ?? 0)/comments") { response in
            switch response.result {
            case let .success(value):
                if let array = value as? [[String:Any]] {
                    for dict in array {
                        let comment = Comment()
                        comment.body = (dict["body"] as? String) ?? ""
                        self.comments.append(comment)
                    }
                    self.commentsTable?.reloadData()
                }
            case let .failure(error):
                return
            }
        }
    }
    
    func populateUserInfo() {
        //This is normally done on the main thread however since the app is pretty straight-forward is being reflected right away anyway, so I avoid main thread calls unless totally necessary.
        self.nameLabel?.text = "Name: \(self.user?.name ?? "")"
        self.usernameLabel?.text = "Username: \(self.user?.username ?? "")"
        self.phoneLabel?.text = "Phone: \(self.user?.phone ?? "")"
        self.emailLabel?.text = "Email: \(self.user?.email ?? "")"
        self.addressLabel?.text = "Address: \(self.user?.address?.street ?? ""),\(self.user?.address?.city ?? "")"
        self.companyLabel?.text = "Company: \(self.user?.companyName ?? "")"
    }
    
    func registerNibs() {
        let bundle = Bundle.main
        let cellNib = UINib(nibName: "CommentCell", bundle: bundle)
        commentsTable?.register(cellNib, forCellReuseIdentifier: CommentCell.identifier)
    }
}
