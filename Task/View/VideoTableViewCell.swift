//
//  VideoTableViewCell.swift
//  Task
//
//  Created by Davit Martirosyan on 06.02.21.
//

import UIKit

protocol VideoTableVIeCellDelegate : class {
    
    func  playBackButtonTapped(buttonTag : Int)
}

class VideoTableViewCell : UITableViewCell {
    
    weak var  delegate : VideoTableVIeCellDelegate?
    
    @IBOutlet weak var playButton : UIButton!
    
    
    @IBOutlet weak var thumbnailImage : UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.layer.cornerRadius = 10.0
        playButton.layer.cornerRadius = 8.0
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func playButtonTapped(_ sender: UIButton)
    {
        
        delegate?.playBackButtonTapped(buttonTag: sender.tag)
        
    }
    
}
