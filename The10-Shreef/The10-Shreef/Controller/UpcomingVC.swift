//
//  UpcomingVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import TMDBSwift

import UIKit
import TMDBSwift
import YouTubePlayer
import AnimatedCollectionViewLayout
import CoreData

class UpcomingVC: UIViewController {
    @IBOutlet weak var collectionView:  ScrollingPagesView!

    var movies: [Movie]  = []
    let interactor       = Interactor()
    let reuseIdentifier  = "poster"
    let imdbIdPath       = "imdbIdPath"
    let trailerPath      = "trailerPath"
    let idString         = "id"
    let movieType        = "Coming Soon"
    let appDelegate      = UIApplication.shared.delegate as! AppDelegate

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Coming Soon"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black

        self.collectionView.dataSource  = self
        self.collectionView.delegate    = self

        let nib = UINib(nibName: "PosterCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        fetchMovieData(movieType: movieType)
    }

    func fetchMovieData(movieType: String) {
        let context = appDelegate.persistentContainer.viewContext

        MovieMDB.upcoming(page: 1) { (client, movies) in
            guard let movies = movies else { return }
            for i in 0...9 {
                let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as! Movie
                movie.parseMovie(data: movies[i])
                movie.type = movieType
            }
            self.movies = self.interactor.fetch(with: "type", with: movieType)
            self.movies.forEach({ (movie) in
                MovieMDB.videos(movieID: Int(movie.id), completion: { (client , trailers) in
                    let trailer = NSEntityDescription.insertNewObject(forEntityName: "Trailer", into: context) as! Trailer
                    guard let trailers = trailers else { return }
                    trailer.parse(client: client, results: trailers)
                    let movie = self.interactor.fetch(with: trailer.id)
                    movie.trailer = trailer
                    self.collectionView.reloadData()
                })
                MovieMDB.movie(movieID: Int(movie.id), completion: { (client, imdbInfo) in
                    let imdb = NSEntityDescription.insertNewObject(forEntityName: "Imdb", into: context) as! Imdb
                    imdb.parse(client: client)
                    let movie = self.interactor.fetch(with: imdb.id)
                    movie.imdb = imdb
                    self.interactor.fetchImdb(imdbID: imdb.path, completionHandler: { (data, error) in
                        guard let data = data else { return }
                        imdb.parse(imdbInfo: data)
                    })
                    self.collectionView.reloadData()
                })
            })
        }
    }
}


extension UpcomingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movies = interactor.fetch(with: "type", with: movieType)
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PosterCell
        let movie = movies[indexPath.row]
        cell.configureNowPlaying(with: movie)
        cell.clipsToBounds = false
        return cell
    }
}

extension UpcomingVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = PresentationController(presentedViewController: presented, presenting: presenting)
        return vc
    }
}
