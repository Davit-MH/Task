//
//  CellForArticleTableView.swift
//  Task
//
//  Created by Davit Martirosyan on 03.02.21.
//

import UIKit

class CellForArticleTableView : UITableViewCell {
   
    @IBOutlet var imageViewHeight : NSLayoutConstraint!
    
    @IBOutlet var cellActivityIndicator : UIActivityIndicatorView!
    
    @IBOutlet weak var coverPhoto : UIImageView!
    
    @IBOutlet weak var categoryLabel : UILabel!
    
    @IBOutlet weak var titleLabel : UILabel!
    
    @IBOutlet weak var dateLabel : UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverPhoto.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  

}
