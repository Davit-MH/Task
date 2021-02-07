//
//  ArticleModel.swift
//  Task
//
//  Created by Davit Martirosyan on 03.02.21.
//

import Foundation
import UIKit


struct ArticleModel {
    
    
    func convertStringToImage(urlString :String)-> UIImage?{
        
        if let url = URL(string: urlString){
            
            do{
                let data = try Data(contentsOf: url)
                
                let image = UIImage(data: data)
                
                return image
            }
            catch{
                return nil
            }
        }
        
        return nil
    }
    
    func getAttributedString(string : String)-> NSAttributedString {
        var   attributedString = NSAttributedString()
        
        if  let  data = string.data(using: .utf16){
            
            do {
                let attribute = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)

                attribute.addAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 16.0)!], range: NSRange(location: 0, length:attribute.length))
                attributedString =  attribute

            }
            catch{
                print(error.localizedDescription)
            }

        }
        
        return attributedString
    }
    
    
    func dateFromTimeStamp(timeInterval : Int)-> String {
        
        let formater  = DateFormatter()
       let date =  Date(timeIntervalSince1970: Double(timeInterval))
        formater.dateFormat = "MM/dd/yyyy, HH:mm"
        return    formater.string(from: date)

    }
    
}

   
