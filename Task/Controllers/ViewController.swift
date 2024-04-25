//
//  ViewController.swift
//  Task
//
//  Created by Ratheesh Chilukamari on 25/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var loadingIndicator: UIActivityIndicatorView!
    
    var posts: [Post] = []
    var currentPage = 1
    var isLastPage = false
    let pageSize = 10 // Number of items to fetch per page
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        setupLoadingIndicator()
        fetchPosts()
    }
    func configureView() {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func fetchPosts() {
        guard !isLoadingData && !isLastPage else { return }
        isLoadingData = true
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(pageSize)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
                self.isLoadingData = false
                return
            }
            do {
                let newPosts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    if newPosts.isEmpty {
                        self.isLastPage = true
                    } else {
                        self.posts.append(contentsOf: newPosts)
                        self.tableView.reloadData()
                    }
                    self.isLoadingData = false
                    
                }
            } catch {
                print("Error decoding data: \(error)")
                self.isLoadingData = false
            }
        }.resume()
    }
    
    var isLoadingData = false {
        didSet {
            if isLoadingData {
                loadingIndicator.startAnimating()
            } else {
                loadingIndicator.stopAnimating()
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as! TaskTableViewCell
        cell.selectionStyle = .none
        let post = posts[indexPath.row]
        cell.lblTitle.text = "\(post.id): \(post.title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        showDetailViewController(for: post)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = posts.count - 1
        if indexPath.row == lastIndex && !isLastPage {
            currentPage += 1
            fetchPosts()
        }
    }
    
    func showDetailViewController(for post: Post) {
        // Implement navigation to a detailed view controller passing the selected post data
        let viewController = DetailsViewController.getInstance()
        viewController.details = post
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
