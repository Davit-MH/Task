//
//  GalleryVC.swift
//  Task
//
//  Created by Davit Martirosyan on 03.02.21.
//

import UIKit

class GalleryVC: UIViewController {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let articleModel = ArticleModel()
    
    var gallery : [GalleryData]?

   fileprivate  var customeView = UIView()
    
   fileprivate  var isImageEnlarged = false
    
   fileprivate  var imageView  = UIImageView()
       
   fileprivate let closeButton = UIButton(type: .system)
    
    var heightConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gallery"
        
        myCollectionView.delegate = self
        myCollectionView.dataSource  = self
        createViewForImage()
        
    }
    func createViewForImage() {
        
        customeView.isHidden = true
        imageView.backgroundColor = #colorLiteral(red: 0.1465925737, green: 0.1081499677, blue: 0.1350864765, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        customeView.backgroundColor = #colorLiteral(red: 0.5874536024, green: 0.8149666064, blue: 0.6644994085, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        customeView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        closeButton.frame = CGRect(origin: CGPoint(x: 5.0, y: 5.0), size: CGSize(width: 65.0, height: 32.0))
        closeButton.setTitle("close X", for: .normal)
        closeButton.tintColor = .black
        closeButton.backgroundColor = #colorLiteral(red: 0.5504166574, green: 0.406074757, blue: 0.507214281, alpha: 1)
        closeButton.layer.cornerRadius = 10.0
        closeButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        closeButton.layer.borderWidth = 2.0
       // closeButton.isUserInteractionEnabled = true
    
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        
        customeView.addSubview(imageView)
        customeView.addSubview(closeButton)
        self.view.addSubview(customeView)
        
        
        //imageView layout
        
        imageView.heightAnchor.constraint(equalTo: customeView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: customeView.widthAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: customeView.leadingAnchor, constant: 0.0).isActive = true
        imageView.topAnchor.constraint(equalTo: customeView.topAnchor, constant: 0.0).isActive = true
        
        //customeView layout
        
        heightConstraint  = NSLayoutConstraint(item: customeView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 0.0)
        widthConstraint  = NSLayoutConstraint(item: customeView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 0.0)
        customeView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        customeView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        print( heightConstraint.isActive , widthConstraint.isActive )
        
        
        self.view.addConstraints([heightConstraint, widthConstraint])
        print( heightConstraint.isActive , widthConstraint.isActive )

        
    }
    
    func animateCustomeImageView(){
        customeView.isHidden = false
        self.heightConstraint.constant = self.myCollectionView.frame.height
        self.widthConstraint.constant = self.myCollectionView.frame.width
        UIView.animate(withDuration: 0.2 ) {
            
            self.view.layoutIfNeeded()
            self.customeView.isHidden = false
        } completion: { _ in
            
            UIView.animate(withDuration: 0.2, animations: {
                self.closeButton.isHidden = false
            }, completion: nil)
        }
        
        
    }
    
    @objc func closeButtonTapped(){
        
        self.heightConstraint.constant =  0.0
        self.widthConstraint.constant = 0.0
        UIView.animate(withDuration: 0.1) {
            self.closeButton.isHidden = true
            self.view.layoutIfNeeded()

        } completion: { _ in
            UIView.animate(withDuration: 0.0, animations: {
                self.customeView.isHidden = true
            }, completion: nil)   }
       
       
    }
}

//MARK : DATASOURCE

extension GalleryVC : UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gallery?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        
        
        if  let image  = articleModel.convertStringToImage(urlString: (gallery?[indexPath.item].thumbnailUrl)!) {
            
            cell.imageView.image = image
        }
        return cell
    }
    
}
//MARK: DELEGATE

extension GalleryVC :   UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if  let image  = articleModel.convertStringToImage(urlString: (gallery?[indexPath.item].contentUrl)!) , !isImageEnlarged{
            
            imageView.image = image
        }
        
        if !isImageEnlarged{
            
            animateCustomeImageView()
        }
    }
    
}



