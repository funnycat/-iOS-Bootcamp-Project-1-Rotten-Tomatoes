//
//  MovieViewController.swift
//  RottenTomatoes
//
//  Created by Emily M Yang on 9/17/15.
//  Copyright © 2015 Experiences Evolved. All rights reserved.
//


import Foundation

struct Movie {
    var data: NSDictionary
    
    init(data: NSDictionary) {
        self.data = data
    }
    
    var image: String {
        return data.valueForKeyPath("posters.thumbnail") as! String
    }
    
    var imageHighRes: String {
        var stringURL =  data.valueForKeyPath("posters.thumbnail") as! String
        let range = stringURL.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)

        if let range = range {
            stringURL = stringURL.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        return stringURL
    }
    
    var movieName: String {
        if let name = data.valueForKeyPath("title") as? String {
            return name
        } else{
            return "Anonymous"
        }
    }
    
    var movieSynopsis: String {
        if let name = data.valueForKeyPath("synopsis") as? String {
            return name
        } else{
            return "Anonymous"
        }
    }
    
}