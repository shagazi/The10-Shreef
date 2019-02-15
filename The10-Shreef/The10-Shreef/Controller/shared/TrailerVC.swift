//
//  TrailerVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import YouTubePlayer

class TrailerVC: UIViewController {
    @IBOutlet weak var trailerView: YouTubePlayerView!

    var trailerID: String

    init(trailerID: String) {
        self.trailerID = trailerID
        super.init(nibName: "TrailerVC", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trailerView.loadVideoID(trailerID)
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
