//
//  ViewController.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import UIKit
import CoreData
import Alamofire

class PostsViewController: UITableViewController, PostCellDelegate {
    let CELL_MARGIN = 20.0
    var posts:[Post] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.loadData()
        self.title = "Zemoga Test"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadOfflineData()
    }

    // MARK: - Table functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell {
            let post = self.posts[indexPath.row]
            cell.delegate = self
            cell.titleLabel?.text = post.title
            cell.commentLabel?.text = post.body
            cell.unfavoriteButton?.isHidden = !post.favorite
            cell.favoriteButton?.isHidden = post.favorite
            return cell
        }
        //This shouldn't happen
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = self.posts[indexPath.row]
        return 46.0 + (CGFloat(post.title.calculateNumOfLines(withFont: UIFont.boldSystemFont(ofSize: 18.0), width: self.view.frame.size.width - (CELL_MARGIN * 2.0) - 40.0)) * 22.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = PostDetailViewController.init(nibName: "PostDetailViewController", bundle: Bundle.main)
        detailVC.post = self.posts[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    //MARK: - Delegate for cells
    func didFavorite(_ cell: UITableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            let post = self.posts[indexPath.row]
            post.favorite = true
            self.updateFavoriteSorting()
        }
    }
    
    func didRemoveFavorite(_ cell: UITableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            let post = self.posts[indexPath.row]
            post.favorite = false
            self.updateFavoriteSorting()
        }
    }
    
    //MARK: - Actions
    @IBAction func deleteNotFavorites() {
        self.posts.removeAll { post in
            return !post.favorite
        }
        self.tableView.reloadData()
    }
    
    @IBAction func reload() {
        self.loadData()
    }
    
    //MARK: - Utils
    func updateFavoriteSorting() {
        self.posts = self.posts.sorted { post1, post2 in
            return post1.favorite
        }
        self.tableView.reloadData()
    }
    
    func registerNibs() {
        let bundle = Bundle.main
        let cellNib = UINib(nibName: "PostCell", bundle: bundle)
        tableView?.register(cellNib, forCellReuseIdentifier: PostCell.identifier)
    }
    
    func loadOfflineData() {
        let postFetch: NSFetchRequest<PostMO> = PostMO.fetchRequest()
        do {
            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.managedContext {
                self.posts.removeAll()
                let results = try managedContext.fetch(postFetch)
                for result in results {
                    let post = Post()
                    post.title = result.title ?? ""
                    //In here we parse all the rest of the attributes
                    self.posts.append(post)
                }
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func loadData() {
        if (NetworkReachabilityManager()?.isReachable ?? false) {
            self.title = "Zemoga Test"
            loadRemoteData()
        } else {
            self.title = "Zemoga Test (Offline)"
            loadOfflineData()
        }
    }
        
    func loadRemoteData() {
        JSONPlaceholderService.sharedService().requestWithPath("/posts") { response in
            switch response.result {
            case let .success(value):
                self.posts.removeAll()
                (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.deleteAllData()
                if let array = value as? [[String:Any]] {
                    for dict in array {
                        let post = Post()
                        post.title = (dict["title"] as? String) ?? ""
                        post.body = (dict["body"] as? String) ?? ""
                        post.userId = (dict["userId"] as? Int) ?? -1
                        post.postId = (dict["id"] as? Int) ?? -1
                        self.posts.append(post)
                        
                        if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.managedContext {
                            let postMO = PostMO(context: managedContext)
                            postMO.setValue(post.title, forKey: #keyPath(PostMO.title))
                            //In here we can save all other values
                            (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.saveContext()
                        }
                    }
                    self.tableView.reloadData()
                }
            case let .failure(error):
                return
            }
        }
    }
}

