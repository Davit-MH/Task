//
//  DetailsVC.swift
//  Task
//
//  Created by Davit Martirosyan on 03.02.21.
//

import UIKit

class DetailsVC : UIViewController {
    
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var galleryButton: UIButton!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    let articleModel = ArticleModel()
    
    var metadata : MetaData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        scrollView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updatePage()

        textView.isHidden = false
        if  metadata?.body == "" {
            
            textView.isHidden = true
        }
    }

    func videoAndGalleryButtonStatus(){
        
        if  metadata?.gallery != nil {
            
            galleryButton.isHidden = false
            
        }
        else {
            galleryButton.isHidden = true
        }
        if metadata?.video == nil {
            
            videoButton.isHidden = true
        }
        else{
            
            videoButton.isHidden = false
        }
    }
    @IBAction func galerryButtonTapped(_ sender: UIButton) {
        
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryVC") as? GalleryVC {
            
            navigationController?.pushViewController(vc, animated: true)
            vc.gallery = metadata?.gallery
            
        }
    }
    
    func viewsInitialSetups() {
        
        textView.layer.cornerRadius = 10.0
        galleryButton.layer.cornerRadius = 10.0
        videoButton.layer.cornerRadius = 10.0
        
    }
    
   @objc func videoButtonTapped() {
        
    if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoVC") as? VideoVC {
        
        navigationController?.pushViewController(vc, animated: true)
        vc.videoData = metadata?.video
    }
   }
    
    func updatePage(){
        guard let metadata = metadata , let categoryLabel = categoryLabel else { return}
        scrollView.isHidden = false
        categoryLabel.text = metadata.category
        titleLabel.text = metadata.title
        dateLabel.text = articleModel.dateFromTimeStamp(timeInterval: metadata.date)
        
        textView.attributedText =  articleModel.getAttributedString(string: metadata.body)

        
        if var image = articleModel.convertStringToImage(urlString: metadata.coverPhotoUrl){
            
            image = image.resizePreservingAspectRatio(targetWidth: imageView.frame.width)
            
            imageView.image = image
           
        }
        viewsInitialSetups()
        videoAndGalleryButtonStatus()
        
        videoButton.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
       
        
    }
}

extension DetailsVC: SelectionDelegate {
    
    func cellSelected(_ metadata: MetaData?) {
        
        self.metadata = metadata
        
       updatePage()
    }
}

