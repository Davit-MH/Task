//
//  VideoVC.swift
//  Task
//
//  Created by Davit Martirosyan on 03.02.21.
//
import UIKit
import AVKit

import youtube_ios_player_helper

class VideoVC: UIViewController , VideoTableVIeCellDelegate {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    let articleModel = ArticleModel()
    
    var videoData : [VideoData]?
    
    var player : YTPlayerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video"
        // Do any additional setup after loading the view.
        
        
    }
    
    func playBackButtonTapped(buttonTag: Int) {
        
        guard let cell = myTableView.cellForRow(at: IndexPath(row: buttonTag, section: 0)) as? VideoTableViewCell else {return}
            

            if player == nil {

                player = YTPlayerView(frame: CGRect(origin: .zero, size: CGSize(width: cell.thumbnailImage.frame.width, height: cell.thumbnailImage.frame.height)))
                

            }
        cell.playButton.isHidden = true
        cell.contentView.addSubview(player!)

        player?.center = cell.thumbnailImage.center

        player?.load(withVideoId:(videoData?[buttonTag].youtubeId)!)
  }
    
}
extension VideoVC : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        videoData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        
        cell.delegate = self
        
        if let image = articleModel.convertStringToImage(urlString: (videoData?[indexPath.row].thumbnailUrl)!){
            
            cell.thumbnailImage.image = image.resizePreservingAspectRatio(targetWidth: cell.thumbnailImage.frame.width)
            
        }
        
        cell.playButton.tag = indexPath.row
        cell.titleLabel.text = videoData?[indexPath.row].title
        
        
        
        return cell
    }
    
}

extension VideoVC : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
    }
}
