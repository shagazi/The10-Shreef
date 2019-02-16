//
//  NowPlayingVC.swift
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

class NowPlayingVC: UIViewController {
    @IBOutlet weak var collectionView:  ScrollingPagesView!

    var movies : [NowPlaying]               = []
    let interactor                          = Interactor()
    let reuseIdentifier                     = "poster"
    let imdbIdPath                          = "imdbIdPath"
    let trailerPath                         = "trailerPath"
    let idString                            = "id"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "In Theaters"

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let context = appDelegate.persistentContainer.viewContext
        self.view.backgroundColor = UIColor.black

        self.collectionView.dataSource  = self
        self.collectionView.delegate    = self

        let nib = UINib(nibName: "PosterCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        MovieMDB.nowplaying(page: 1) { (client, movies) in
            guard let movies = movies else { return }
            for i in 0...9 {
                let movie = NSEntityDescription.insertNewObject(forEntityName: "NowPlaying", into: context) as! NowPlaying
                movie.parseMovie(data: movies[i])
            }
            self.movies = self.fetchMovies()
            self.movies.forEach({ (movie) in
                MovieMDB.videos(movieID: Int(movie.id), completion: { (client , trailers) in
                    let trailer = NSEntityDescription.insertNewObject(forEntityName: "Trailer", into: context) as! Trailer
                    guard let trailers = trailers else { return }
                    trailer.parse(client: client, results: trailers)
                    let movie = self.fetch(with: trailer.id)
                    movie.trailer = trailer
                    self.collectionView.reloadData()
                })
                MovieMDB.movie(movieID: Int(movie.id), completion: { (client, imdbInfo) in
                    let imdb = NSEntityDescription.insertNewObject(forEntityName: "Imdb", into: context) as! Imdb
                    imdb.parse(client: client)
                    let movie = self.fetch(with: imdb.id)
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

    func fetch(with ID: String) -> NowPlaying {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NowPlaying>(entityName: String("NowPlaying"))
        request.predicate = NSPredicate(format: "id == %@", ID)
        let fetchedObjects = try! context.fetch(request)
        if let first = fetchedObjects.first {
            return first
        }
        return NSEntityDescription.insertNewObject(forEntityName: "NowPlaying", into: context) as! NowPlaying
    }

    func fetchMovies() -> [NowPlaying] {
        let request = NSFetchRequest<NowPlaying>(entityName: "NowPlaying")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return try! context.fetch(request)
    }
}

extension NowPlayingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movies = fetchMovies()
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

extension NowPlayingVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = PresentationController(presentedViewController: presented, presenting: presenting)
        return vc
    }
}
