//
//  MovieDetailScreen.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 20/02/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenterProtocol?
    
    var movieId: Int?
    var params: [String: Any]?
    var id : Int? {
        didSet {
            configure()
        }
    }
    var movieDetail: MovieDetailResponse?
    var movieReview: ReviewResponse?
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        
        return imageView
    }()
    
    let titleMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let releaseDateMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    let overviewMovieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Overview"
        
        return label
    }()
    
    let overviewMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        label.sizeToFit()
        
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Movie"
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDepedency()
        getMovieDetail()
        getMovieReview()
        showActivityIndicator()
        setupViews()
    }
    
    func setupDepedency() {
        MovieDetailWireframe.createMainModule(movieDetailRef: self)
    }
    
}

// handle view
extension MovieDetailViewController {
    
    func setupViews() {
        setupInterfaceComponent()
        setupConstraint()
    }
    
    func setupInterfaceComponent() {
        view.addSubview(containerView)
        containerView.addSubview(coverImageView)
        containerView.addSubview(titleMovie)
        containerView.addSubview(releaseDateMovie)
        containerView.addSubview(overviewMovieTitle)
        containerView.addSubview(overviewMovie)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            coverImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            coverImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            coverImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            titleMovie.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
            titleMovie.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            releaseDateMovie.topAnchor.constraint(equalTo: titleMovie.bottomAnchor, constant: 4),
            releaseDateMovie.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            overviewMovieTitle.topAnchor.constraint(equalTo: releaseDateMovie.bottomAnchor, constant: 8),
            overviewMovieTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            overviewMovie.topAnchor.constraint(equalTo: overviewMovieTitle.bottomAnchor, constant: 4),
            overviewMovie.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            overviewMovie.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    func showActivityIndicator() {
        let titleLabel = UILabel()
        titleLabel.text = "Connecting"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let fittingSize = titleLabel.sizeThatFits(CGSize(width: 200.0, height: 14))
        titleLabel.frame = CGRect(x: 0, y: 0, width: fittingSize.width, height: fittingSize.height)
        
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.frame = CGRect(x: titleLabel.frame.origin.x + titleLabel.frame.size.width + 8, y: 2, width: 14, height: 14)
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.startAnimating()
        
        let titleView = UIView(frame: CGRect(x: ((activityIndicatorView.frame.size.width + 8 + titleLabel.frame.size.width) / 2), y: (activityIndicatorView.frame.size.height), width: (activityIndicatorView.frame.size.width + 8 + titleLabel.frame.size.width), height: (activityIndicatorView.frame.size.height)))
        titleView.addSubview(activityIndicatorView)
        titleView.addSubview(titleLabel)
        
        self.navigationItem.titleView = titleView
    }
    
    func hideActivityIndicator() {
        self.navigationItem.titleView = nil
    }
}

// configure id
extension MovieDetailViewController {
    func configure() {
        self.movieId = id
        self.params = [
            "page": "1",
            "language": "en-US"
        ] as [String: Any]
    }
}

// handle services
extension MovieDetailViewController {
    func getMovieDetail() {
        presenter?.getMovieDetail(withMovieId: self.movieId ?? 0, withParams: self.params!)
    }
    
    func getMovieReview() {
        presenter?.getMovieReview(withMovieId: self.movieId ?? 0, withParams: self.params!)
    }
}

// handle output services
extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    func displayMovieDetailSuccess(withResponse response: MovieDetailResponse) {
        self.hideActivityIndicator()
        self.movieDetail = response
        self.title = response.title
        self.coverImageView.kf.setImage(with: response.posterURL)
        self.titleMovie.text = response.title
        self.releaseDateMovie.text = "Released : \(response.releaseDate)"
        self.overviewMovie.text = response.overview
    }
    
    func displayMovieDetailError(withError error: Error) {
        self.hideActivityIndicator()
        print(error)
    }
    
    func displayMovieReviewSuccess(withResponse response: ReviewResponse) {
        self.movieReview = response
    }
    
    func displayMovieReviewError(withError error: Error) {
        print(error)
    }
    
    
}
