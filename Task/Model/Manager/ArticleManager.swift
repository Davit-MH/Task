//
//  ArticleManager.swift
//  Task
//
//  Created by Davit Martirosyan on 02.02.21.
//

import Foundation
import Alamofire

protocol ArticleManagerDelegate{
    
    func sendParsedDataToDelegate(parsedData : [MetaData])
    
}
struct ArticleManager {
    
    var delegate : ArticleManagerDelegate?
    
    let articleUrl = "https://www.helix.am/temp/json.php"
    
    
    func makeRequest(urlString : String) {
        
        AF.request(urlString).responseJSON { response in
            
            if let error = response.error{
                print(error)
                return
            }
            if let data = response.data{
                
                guard let parsedData = parseJSON(jsondata: data) else {return}
                self.delegate?.sendParsedDataToDelegate(parsedData: parsedData.metadata)
            }
        }
        
        // Swift realization of the request and response
        
        //        if let url = URL(string: urlString){
        //
        //            let session = URLSession(configuration: .default)
        //
        //            let task = session.dataTask(with: url) { (data, response, error) in
        //
        //                if let error = error{
        //
        //                    print(error.localizedDescription)
        //                }
        //                guard let data = data else{ return }
        //
        //                if let parsedData =  parseJSON(jsondata: data){
        //
        //
        //                    delegate?.sendParsedDataToDelegate(parsedData: parsedData.metadata)
        //                }
        //            }
        //            task.resume()
        //        }
    }
    
    
    func parseJSON(jsondata data : Data) -> ArticleData?{
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData =  try decoder.decode(ArticleData.self, from: data)
            
            return decodedData
        }
        catch{
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    
    
}
