//
//  NetworkUtils.swift
//  WeatherStation
//
//  Created by Mark Filter on 2/17/18.
//  Copyright © 2018 Mark Filter. All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute,
//  sublicense, and/or sell coppies of the software and to permit persons to whome the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import SystemConfiguration
import UIKit

class NetworkUtils {
    
    internal static let TAG : String = "NetworkUtils.TAG"
    static let opt_check_connection_url : URL? = URL.init(string: "https://www.google.com/")
    public static let resourceDomain : String = "90acf95e.ngrok.io"
    
    /**
     Checks network connectivity by making a request to the domain's server. Handles alerting the user to connection issues.
     - Parameters:
     - viewController: The calling ViewController.
     - Author: Mark Filter
     */
    
    internal static func checkConnection(viewController: UIViewController, completion: ((_ alertController: UIAlertController, _ hasInternetConnection: Bool) -> (Void))?) {
        
        var errorMessage = ""
        
        // MARK: - ErrorCode 501
        guard let url = opt_check_connection_url else {
            Log.d(TAG: "Reachability.checkConnection(:_)", message: "Error creating URL to check for connection status")
            errorMessage = "Error creating URL to check for connection status. Error Code 501."
            let alertController = UIAlertController.init()
            alertController.title = "No Internet Connection"
            alertController.message = errorMessage
            alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            completion?(alertController, false)
            return
        }
        
        
        // MARK: - ErrorCode 502
        let getData = URLSession.shared.dataTask(with: url) {
            (opt_data, opt_response, opt_error) in
            if let error = opt_error {
                Log.d(TAG: self.TAG, message: error.localizedDescription)
                errorMessage = error.localizedDescription + " Error Code 502."
                let alertController = UIAlertController.init()
                alertController.title = "No Internet Connection"
                alertController.message = errorMessage
                alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                completion?(alertController, false)
            }
            
            // MARK: - ErrorCode 503
            guard let httpResponse = opt_response as? HTTPURLResponse
                else {
                    print("Error getting a response from the server")
                    errorMessage = "Error getting a response from the server. Error Code 503."
                    let alertController = UIAlertController.init()
                    alertController.title = "No Internet Connection"
                    alertController.message = errorMessage
                    alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    completion?(alertController, false)
                    return
            }
            
            switch httpResponse.statusCode {
            case 200:
                let alertController = UIAlertController.init()
                alertController.title = "Connected"
                alertController.message = errorMessage
                alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                completion?(alertController, true)
                break
            case 500:
                let alertController = UIAlertController.init()
                alertController.title = "Degraded Internet Connection"
                alertController.message = "You are connected to the internet, but the server is not responding."
                alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                completion?(alertController, false)
                break
            default:
                let alertController = UIAlertController.init()
                alertController.title = "No Internet Connection"
                alertController.message = "Please check your internet connection and try again."
                alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                completion?(alertController, false)
                break
            }
            
        }
        getData.resume()
        
    }
    
    
    /**
     Fetches Image data from the requested URL and returns the UIImage via the delegate method.
     - Parameters:
     - requestUrl: The URL of the request.
     - delegate: The context registered for receiving callbacks.
     - Author: Mark Filter
     */
    internal static func fetchImageFrom(url: URL, completion: @escaping ((_ image: UIImage?) -> (Void))) {
        var secureURL : URL = url
        if url.scheme == "http" {
            Log.i(TAG: TAG, message: "url.scheme = \(url.scheme ?? "no scheme")" )
            Log.i(TAG: TAG, message: "url.host = \(url.host ?? "no host")" )
            Log.i(TAG: TAG, message: "url.relativePath = \(url.relativePath)" )
            let secureURLString : String = "https://" + url.host! + "/" + url.relativePath
            secureURL = URL.init(string: secureURLString)!
        }
        
        let getData = URLSession.shared.dataTask(with: secureURL, completionHandler: { (opt_data, opt_response, opt_error) in
            
            if let error = opt_error {
                Log.d(TAG: self.TAG, message: error.localizedDescription)
                return
            }
            guard let httpResponse = opt_response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let validData = opt_data
                else {
                    Log.d(TAG: self.TAG, message: "Data was invalid")
                    return
                    
            }
            
            
            if let image = UIImage.init(data: validData) {
                completion(image)
            }
            else {
                completion(nil)
            }
            
            
        })
        getData.resume()
    }
    
}


