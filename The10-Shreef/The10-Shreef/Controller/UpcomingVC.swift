//
//  UpcomingVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import TMDBSwift

class UpcomingVC: UIViewController {

    var upcomingMovies: [MovieMDB] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        MovieMDB.upcoming(page: 1) { (data, movies) in
            if let movies = movies {
                self.upcomingMovies = movies
            }
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
}
