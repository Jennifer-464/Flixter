//
//  GridDetailsViewController.swift
//  Unit 1 - Flixter
//
//  Created by Jennifer Lopez on 2/14/21.
//

import UIKit
import AlamofireImage

class GridDetailsViewController: UIViewController {

    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        dateLabel.text = movie["release_date"] as? String
        
        titleLabel.sizeToFit()
        synopsisLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        // Thumbnail IMAGES
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        posterView.af_setImage(withURL: posterUrl)
        
        // Background IMAGES
        let base2Url = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: base2Url + backdropPath)!
        
        backdrop.af_setImage(withURL: backdropUrl)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
