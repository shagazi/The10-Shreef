//
//  UpcomingVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

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

        MovieMDB.upcoming(page: 1) { (client, movies) in
            guard let movies = movies else { return }
            for i in movies {
                let movie = Movie.fetchOrCreate(with: String(i.id))
                movie.parse(data: i)
                movie.type = self.movieType
            }
            self.interactor.fetchMovieData(movieType: self.movieType) { (_) in
                self.movies = Movie.fetchObjects(with: "type", with: self.movieType)
                self.movies.sort { $0.imdb.imdbScore > $1.imdb.imdbScore }
                self.collectionView.reloadData()
            }
        }
    }
}

extension UpcomingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.movies.count > 10 {
            return 10
        }
        else {
            return self.movies.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PosterCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}
