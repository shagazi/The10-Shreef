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
    @IBOutlet weak var pageControl: UIPageControl!
    
    var movies: [Movie]  = []
    let interactor       = Interactor()
    let reuseIdentifier  = "poster"
    let imdbIdPath       = "imdbIdPath"
    let trailerPath      = "trailerPath"
    let idString         = "id"
    let movieType        = "Coming Soon"

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
        MovieMDB.upcoming(page: 1) { (client, movies) in
            guard let movies = movies else { return }
            for i in 0...9 {
                let movie = Movie.createNew()
                movie.parse(data: movies[i])
                movie.type = movieType
            }
            self.movies = Movie.fetchObjects(with: "type", with: movieType)
            self.movies.forEach({ (movie) in
                MovieMDB.videos(movieID: Int(movie.id), completion: { (client , trailers) in
                    guard let trailers = trailers else { return }

                    let trailer = Trailer.createNew()
                    trailer.parse(client: client, results: trailers)

                    let movie = Movie.fetch(with: trailer.id)
                    movie?.trailer = trailer

                    self.collectionView.reloadData()
                })
                MovieMDB.movie(movieID: Int(movie.id), completion: { (client, imdbInfo) in
                    let imdb = Imdb.createNew()
                    imdb.parse(client: client)

                    let movie = Movie.fetch(with: imdb.id)
                    movie?.imdb = imdb
                    
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
        self.movies = Movie.fetchObjects(with: "type", with: movieType)
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PosterCell
        let movie = movies[indexPath.row]
        cell.configureNowPlaying(with: movie)
        cell.clipsToBounds = false
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
}

extension UpcomingVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = PresentationController(presentedViewController: presented, presenting: presenting)
        return vc
    }
}
