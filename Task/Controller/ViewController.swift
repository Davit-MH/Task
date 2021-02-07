//
//  ViewController.swift
//  Task
//
//  Created by Davit Martirosyan on 02.02.21.
//

import UIKit
import Kingfisher

protocol SelectionDelegate : class {
    func cellSelected(_ metadata: MetaData?)
}

class ViewController : UIViewController {
    
    
    weak var delegate: SelectionDelegate?
    
    @IBOutlet weak var myTableView: UITableView!
    
    var metadata : [MetaData] = []
    var article : ArticleManager?
    var articleModel : ArticleModel?
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        article = ArticleManager()
        article?.delegate = self
        article?.makeRequest(urlString: "https://www.helix.am/temp/json.php")
        articleModel = ArticleModel()
        title = "Article"
        // Do any additional setup after loading the view.
        
    }
    
}
//MARK: UITableViewDataSource

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        metadata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CellForArticleTableView", for: indexPath) as! CellForArticleTableView
        cell.contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        if UserDefaults.standard.bool(forKey: metadata[indexPath.row].coverPhotoUrl) {
            
            cell.contentView.backgroundColor = .systemGray
        }
        
        // image asynchronous loading and caching using KINGFISHER 3rd party library
        if cell.coverPhoto.image == nil{
            
            cell.cellActivityIndicator.startAnimating()
            cell.imageViewHeight.constant = 130.0
        }
        let url = URL(string: metadata[indexPath.row].coverPhotoUrl)!
        
        KingfisherManager.shared.retrieveImage(with: url, options: [.cacheMemoryOnly], progressBlock: nil) { result in
            
            cell.cellActivityIndicator.stopAnimating()
            let cellHeight = cell.imageViewHeight.constant
            switch result {
            case .success(let value):
                
                cell.coverPhoto.image = value.image.resizePreservingAspectRatio(targetWidth: cell.coverPhoto.frame.width)
                cell.imageViewHeight.constant = (cell.coverPhoto.image?.size.height)!
            case .failure: cell.coverPhoto.image = nil
                cell.imageViewHeight.constant = 0.0
            }
            
            if cellHeight != cell.imageViewHeight.constant {
                
                cell.setNeedsLayout()
                
                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
        }
        
        cell.categoryLabel.text = metadata[indexPath.row].category
        cell.titleLabel.text =  metadata[indexPath.row].title
        cell.dateLabel.text =  articleModel?.dateFromTimeStamp(timeInterval: metadata[indexPath.row].date)
        
        return cell 
    }
    
}

//MARK: UITableViewDelegate

extension ViewController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let read =  UserDefaults.standard.bool(forKey: metadata[indexPath.row].coverPhotoUrl)
        
        if !read{
            
            UserDefaults.standard.set(true, forKey: metadata[indexPath.row].coverPhotoUrl)
            
            let cell  = tableView.cellForRow(at: indexPath) as? CellForArticleTableView
            
            cell?.contentView.backgroundColor = .systemGray
            
        }
        
        if let detailViewController = delegate as? DetailsVC {
            
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
        delegate?.cellSelected(metadata[indexPath.row])
    }
}

extension ViewController : ArticleManagerDelegate{
    
    func sendParsedDataToDelegate(parsedData: [MetaData]) {
        
        metadata = parsedData
        
        DispatchQueue.main.async {
            
            self.activityIndicator.stopAnimating()
            self.myTableView.reloadData()
        }
    }
    
}
