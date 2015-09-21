//
//  MoviesViewController.swift
//  
//
//  Created by Emily M Yang on 9/15/15.
//
//

import UIKit


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var alertBanner: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie]?
    var filteredMovies: [Movie]!
    
    var radialWaveView : BFRadialWaveView!
    var refreshControl: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //     alertViewBanner = alertView(frame: CGRectMake(0, 20, view.bounds.width, 200))
//        alertViewBanner.bgColor = UIColor.darkGrayColor()
//        alertViewBanner.caption = "Networking Error!"
//        alertViewBanner.hidden = true
        
        alertBanner.hidden = true;
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        
        setupRadialWave()
        setupRefreshControl()
        loadLatestMovies()

    }
    
    func setupRadialWave(){
        radialWaveView = BFRadialWaveView(view: self.view, circles: BFRadialWaveView_DefaultNumberOfCircles, color: nil, mode:BFRadialWaveViewMode.Default, strokeWidth: BFRadialWaveView_DefaultStrokeWidth, withGradient: true)
        tableView.insertSubview(radialWaveView, atIndex: 0)
        radialWaveView.show()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
            action: "onRefresh",
            forControlEvents: UIControlEvents.ValueChanged
        )
        
        tableView.insertSubview(refreshControl, atIndex: 2)
    }

    
    func checkInternetConnection(){
        if Reachability.isConnectedToNetwork() == true {
            self.alertBanner.hidden = true
        } else {
            self.alertBanner.hidden = false
        }
    }
    
    
    
    func loadLatestMovies() {
            checkInternetConnection()
        
            let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
            request(url) { response -> Void in
                print("Loaded Movies")
                
                
                let results = response["movies"] as! [NSDictionary]
                self.movies = results.map { Movie(data: $0) }
                self.filteredMovies = results.map { Movie(data: $0) }
                
                self.refreshControl.endRefreshing()
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData();
                    self.radialWaveView.hidden = true
                }
            }

    }
    
    
    
    private func request(url: NSURL, responseHandler: NSDictionary -> Void) {
        let request = NSURLRequest(URL: url)
        let config  = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    if let json = json {
                        print("Got JSON")
                        //print(json)
                        responseHandler(json)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredMovies = filteredMovies {  //not nil
            return filteredMovies.count
        } else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //DUPLICATE
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MovieCell.identifier, forIndexPath: indexPath) as! MovieCell
        
        let movie = filteredMovies![indexPath.row]  //row
        print("Requesting row \(indexPath.row) out of \(filteredMovies?.count): \(movie.image)")
        
        cell.titleLabel.text = movie.movieName
        cell.synopsisLabel.text = movie.movieSynopsis
        
    
        cell.posterView.setImageWithURLRequest(NSURLRequest(URL: NSURL(string:movie.image)!), placeholderImage: UIImage(named: "iconmonstr-video-icon-128"), success: { (NSURLRequest, NSHTTPURLResponse, UIImage) -> Void in
            
            cell.posterView.image = UIImage
            cell.posterView.alpha = 0
            UIView.animateWithDuration(1.0) {
                cell.posterView.alpha = 1
            }
            
            
            }) { (NSURLRequest, NSHTTPURLResponse, NSError) -> Void in
                print(NSError)
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = searchText.isEmpty ? movies : movies!.filter({(movie: Movie) -> Bool in
            return movie.movieName.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        
        tableView.reloadData()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        let movie = filteredMovies![indexPath!.row]
        movieDetailsViewController.movie = movie
        view.endEditing(true)
       // vc.photo = photo
        
    }
    
    
    func onRefresh() {
        loadLatestMovies()
    }
    

}
