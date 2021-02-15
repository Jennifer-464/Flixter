//
//  MoviesViewController.swift
//  Unit 1 - Flixter
//
//  Created by Jennifer Lopez on 2/6/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Creating array of dictionaries
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableViews help with scrolling screen
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        // print("hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
                print(error.localizedDescription)
           } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // goes into movie dictionary and gets out results' info
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.tableView.reloadData()
            
                //print("----------------------------")
                //print(dataDictionary)
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    // asks for number of rows, comes when using UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    // for this particular row, give me the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell()
        // dequeue recycles cells, if one goes off screen, it's reused to show next row
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        // prints rows with their respective rows incrementing, using UITableViewDelegate
        // cell.textLabel?.text = "row: \(indexPath.row)"
        // cell.textLabel?.text = title
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        // IMAGES
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("Loading up details screen")
        
        // sender - cell that's tapped on
        // Find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        let detailViewcontroller = segue.destination as! MovieDetailsViewController
        detailViewcontroller.movie = movie
        
        // helps no longer keep row selected when changing page
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

// for scrolling screen with tableView
// Step 1: add UITableViewDataSource, UITableViewDelegate in class section
// Step 2: fill in the functions
// Step 3: add the following inside override function
//        tableView.dataSource = self
//        tableView.delegate = self

// creating an arbitrary custom cell
// Step 1: design cell
// Step 2: create swift cell (UITableCell)
// Step 3: click on cell and put it on two places
//          - custom class w/inherit module check
//          - view identifier
// Step 4: go to view controller and edit functions
