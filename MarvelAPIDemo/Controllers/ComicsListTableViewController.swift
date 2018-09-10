//
//  MoviesListTableViewController.swift
//  MarvelAPIDemo
//
//  Created by Abdoulaye Diallo on 9/10/18.
//  Copyright © 2018 224Apps. All rights reserved.
//

import UIKit
import Moya

class ComicsListViewController: UIViewController {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var mstableView: UITableView!
    enum State {
        case loading, error, ready([Comic])
    }
    
    let provider =  MoyaProvider<Marvel>()
    
    private var state: State = .loading {
        didSet {
            switch state {
            case .ready:
                messageView.isHidden = true
                mstableView.isHidden = false
                mstableView.reloadData()
            case .loading:
                mstableView.isHidden = true
                messageView.isHidden = false
                messageLabel.text = "Getting comics ..."
                messageImageView.image = #imageLiteral(resourceName: "Loading")
            case .error:
                mstableView.isHidden = true
                messageView.isHidden = false
                messageLabel.text = """
                Something went wrong!
                Try again later.
                """
                messageImageView.image = #imageLiteral(resourceName: "Error")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.mstableView.register(ComicsCell.self, forCellReuseIdentifier: "ComicCell")
        //the Default State is loading...
        state = .loading
        
        provider.request(Marvel.comics) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do{
                    self.state = .ready(try response.map(MarvelResponse<Comic>.self).data.results)
                }catch{
                    self.state = .error
                }
            case .failure(_):
                self.state = .error
            }
        }
    }
}



extension ComicsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.reuseIdentifier, for: indexPath) as? ComicsCell ?? ComicsCell()

        

        guard case .ready(let items) = state else { return cell }
        
        cell.configureWith(items[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .ready(let items) = state else { return 0 }
        
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}



