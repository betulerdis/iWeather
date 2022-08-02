//
//  WebServiceManager.swift
//  iWeather
//
//  Created by Betul Erdis on 2022-07-16.
//

import Foundation
import UIKit


class WebServiceManager {
    
    static let sharedInstance = WebServiceManager()
    
    func callWeatherAPI(forCity city: String, completionHandler: @escaping (_ success : Bool, _ message : String, _ responseStructure : MainDesc?) -> ()){
        
        if let callingUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constants.apikey)&units=Imperial"){
            
            let callingSession = URLSession.shared
            
            let task = callingSession.dataTask(with: callingUrl) { (data, response, error) in
                guard error == nil else {
                    completionHandler(false, "Error", nil)
                    
                    return
                }
                if let responseCode = response as? HTTPURLResponse, responseCode.statusCode == 200 {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                        completionHandler(true, "Success", MainDesc((json as! [String : Any])["main"] as! [String : Any]))
                        return
                        
                    }
                } else {
                    completionHandler(false, "Failed", nil)
                }
                
            }
            task.resume()
            
            
        }else{
            completionHandler(false, "Failed", nil)
        }
        
    }
}

