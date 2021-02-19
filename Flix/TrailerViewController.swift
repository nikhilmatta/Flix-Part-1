//
//  TrailerViewController.swift
//  Flix
//
//  Created by Nikhil Matta on 19/02/21.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    var movieId: Int = 0
    var movie = [[String:Any]]()
    var movieKey: String = ""

    
    
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movie = dataDictionary["results"] as! [[String:Any]]
            print(self.movie)
            self.movieKey = self.movie[0]["key"] as! String
            let youtubeURL = "https://www.youtube.com/watch?v="
            print(youtubeURL + self.movieKey)
            let myURL = URL(string: youtubeURL + self.movieKey)
            let myRequest = URLRequest(url: myURL!)
            self.webView.load(myRequest)

//            print(self.movieKey)

           }
        }
        task.resume()
        
        
        
//            movie["key"] as! String
        // Do any additional setup after loading the view.
//        let youtubeURL = "https://www.youtube.com/watch?v="
//        print(youtubeURL + movieKey)
//        let myURL = URL(string: youtubeURL + movieKey)
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
        
    }
    
    
    

}
