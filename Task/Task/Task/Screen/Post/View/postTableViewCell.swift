//
//  postTableViewCell.swift
//  Task
//
//  Created by Suraj Bhujbal on 26/04/24.
//

import UIKit

class postTableViewCell: UITableViewCell {
    @IBOutlet weak var postview: UIView!
    @IBOutlet weak var id:UILabel!
    @IBOutlet weak var title:UILabel!
    
    var post:postModel?{
        didSet{
            Configuration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        postview.clipsToBounds = false
        postview.layer.cornerRadius = 15
        postview.backgroundColor = .systemGray6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func Configuration(){
        guard let post else{return}
        id.text = String(describing: post.id)
        title.text = post.title
    }
}
