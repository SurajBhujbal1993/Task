//
//  Created by Aman on 27/07/23.
//

import UIKit

class postView: UIViewController {
    // View code here
    @IBOutlet weak var tbl:UITableView!
    var postModel = postViewModel()

    let cellId = "postTableViewCell"
    var currentPage: Int? {
        didSet {
            if let oldValue = oldValue, let currentPage = currentPage {
                if currentPage > oldValue {
                    callApi()
                }
            }
        }
    }
    
    // MARK: View lifecycle

    override func viewDidLoad(){
      super.viewDidLoad()
        currentPage = 1
        configuration()
    }
}
extension postView{
    func configuration(){
        tbl.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        callApi()
        observEvents()
    }
    
    func callApi(){
            postModel.fetchProduct(pages: currentPage ?? 0)
    }
    
    func observEvents(){
        postModel.eventHandler = {[weak self] event in
            guard let self else {return}
            switch event{
            case .loading:
                ActivityIndicatorClass().showActivityIndicator()
            case .stopLoading:
                ActivityIndicatorClass().hideActivityIndicator()
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.tbl.reloadData()
                }
            case .error(let err):
                debugPrint(err!)
            }
        }
    }
}


extension postView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModel.post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? postTableViewCell else {return UITableViewCell()}
        let post = postModel.post[indexPath.row]
        cell.post = post
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == postModel.post.count - 1{
                currentPage! += 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

