//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Emily M Yang on 9/15/15.
//  Copyright (c) 2015 Experiences Evolved. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        titleLabel.text = movie.movieName
        synopsisLabel.text = movie.movieSynopsis
        
        imageView.setImageWithURLRequest(NSURLRequest(URL: NSURL(string:movie.imageHighRes)!), placeholderImage: UIImage(named: "iconmonstr-video-icon-128"), success: { (NSURLRequest, NSHTTPURLResponse, UIImage) -> Void in
            
            self.imageView.image = UIImage
            self.imageView.alpha = 0
            UIView.animateWithDuration(1.0) {
                self.imageView.alpha = 1
            }
            
            }) { (NSURLRequest, NSHTTPURLResponse, NSError) -> Void in
                print(NSError)
        }
        
     //   imageView.setImageWithURL(NSURL(string:movie.imageHighRes)!)
    
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
