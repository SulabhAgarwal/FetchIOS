//
//  ViewController.swift
//  Image
//
//  Created by Sulabh Agarwal on 2/14/16.
//  Copyright © 2016 Sulabh Agarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var theImage: UIImageView!
    
    
    @IBOutlet var text: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getImage()
    }
    
    
    func getImage()
    {
        let url = NSURL(string: "https://itunes.apple.com/us/rss/topgrossingipadapplications/limit=25/json")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(NSURLRequest(URL: url!))
            {
            (data,response,error) -> Void in
            if(error == nil)
            {
                let swiftyJSON = JSON(data: data!)
             //   let theImageArray = swiftyJSON["entry"][0]["im:image"].arrayValue
                  let theEmptyArray = swiftyJSON["feed"]["entry"][0]["im:image"].arrayValue
                  let theImageArray = theEmptyArray[0]["label"].string!
                let theTextArray = swiftyJSON["feed"]["entry"][0]["im:name"]["label"].string!
                print(theImageArray)
                print(theTextArray)
                  let theImageURL = NSURL(string: theImageArray)
                 if let ImageData = NSData(contentsOfURL: theImageURL!)
                 {
                self.theImage.image = UIImage(data: ImageData)
                }
                
                self.text.text = theTextArray
            }
        }
        task.resume()
    }

   

}

