//
//  CurationViewController.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 16/02/21.
//

import UIKit

class CurationViewController: UIViewController {
    
    var presenter: CurationPresenterProtocol?
    static let sectionHeaderElementKind = "section-header-element-kind"
    var page = 1
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    var nowPlayingMovies = [Movie]()
    var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
    
    enum Section: String, CaseIterable {
        case popularMovies = "Popular"
        case topRatedMovies = "Top Rated"
        case nowPlayingMovies = "Now Playing"
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>! = nil
    var moviesCollectionView: UICollectionView! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Movies"
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDepedency()
        setupViews()
        setupServices()
        configureCollectionView()
        configureDataSource()
    }
    
    func setupDepedency() {
        CurationWireframe.createMainModule(curationRef: self)
    }
}

// handle services input
extension CurationViewController {
    
    func setupServices() {
        getPopularMovies()
        getTopRatedMovies()
        getNowPlayingMovies()
    }
    
    func getPopularMovies() {
        let params = [
            "page": "\(page)",
            "language": "en-US"
        ] as [String: Any]
        
        presenter?.getPopularMovies(withParams: params)
    }
    
    func getTopRatedMovies() {
        let params = [
            "page": "2",
            "language": "en-US"
        ] as [String: Any]
        
        presenter?.getTopRatedMovies(withParams: params)
    }
    
    func getNowPlayingMovies() {
        let params = [
            "page": "3",
            "language": "en-US"
        ] as [String: Any]
        
        presenter?.getNowPlayingMovies(withParams: params)
    }
}

// handle services output
extension CurationViewController: CurationViewControllerProtocol {
    
    func displayPopularMoviesSuccess(withResponse response: MovieResponse) {
        DispatchQueue.main.async {
            self.popularMovies = response.results
            
            self.snapshot.appendSections([Section.popularMovies])
            self.snapshot.appendItems(self.popularMovies)
            
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    func displayPopularMoviesError(withError error: Error) {
        print(error)
    }
    
    func displayTopRatedMoviesSuccess(withResponse response: MovieResponse) {
        DispatchQueue.main.async {
            self.topRatedMovies = response.results
            
            self.snapshot.appendSections([Section.topRatedMovies])
            self.snapshot.appendItems(self.topRatedMovies)
            
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    func displayTopRatedMoviesError(withError error: Error) {
        print(error)
    }
    
    func displayNowPlayingMoviesSuccess(withResponse response: MovieResponse) {
        DispatchQueue.main.async {
            self.nowPlayingMovies = response.results
            
            self.snapshot.appendSections([Section.nowPlayingMovies])
            self.snapshot.appendItems(self.nowPlayingMovies)
            
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    func displayNowPlayingMoviesError(withError error: Error) {
        print(error)
    }
    
}

// Handle view of controller
extension CurationViewController {
    
    func setupViews() {
        setupInterfaceComponent()
        setupConstraint()
    }
    
    func setupInterfaceComponent() {
    }
    
    func setupConstraint() {
        
    }
}

// handle collectionview - compositional layout
extension CurationViewController {
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: PopularMovieCell.reuseIdentifer)
        collectionView.register(TopRatedMovieCell.self, forCellWithReuseIdentifier: TopRatedMovieCell.reuseIdentifer)
        collectionView.register(NowPlayingMovieCell.self, forCellWithReuseIdentifier: NowPlayingMovieCell.reuseIdentifer)
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: CurationViewController.sectionHeaderElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier)
        moviesCollectionView = collectionView
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, Movie>(collectionView: moviesCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, movie: Movie) -> UICollectionViewCell? in
            
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .popularMovies:
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PopularMovieCell.reuseIdentifer,
                        for: indexPath) as? PopularMovieCell else { fatalError("Could not create new cell") }
                cell.backgroundColor = .lightGray
                
                if self.popularMovies.count != 0 {
                    cell.posterURL = self.popularMovies[indexPath.row].posterURL
                }
                
                return cell
                
            case .topRatedMovies:
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TopRatedMovieCell.reuseIdentifer,
                        for: indexPath) as? TopRatedMovieCell else { fatalError("Could not create new cell") }
                cell.backgroundColor = .lightGray
                
                if self.topRatedMovies.count != 0 {
                    cell.posterURL = self.topRatedMovies[indexPath.row].posterURL
                }
                
                return cell
                
            case .nowPlayingMovies:
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: NowPlayingMovieCell.reuseIdentifer,
                        for: indexPath) as? NowPlayingMovieCell else { fatalError("Could not create new cell") }
                
                cell.backgroundColor = .lightGray
                if self.nowPlayingMovies.count != 0 {
                    cell.posterURL = self.nowPlayingMovies[indexPath.row].posterURL
                }
                
                return cell
                
            }
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.reuseIdentifier,
                    for: indexPath) as? HeaderView else { fatalError("Cannot create header view") }
            
            supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        
//        let snapshot = self.snapshotForCurrentState()
//        self.dataSource.apply(snapshot, animatingDifferences: false)
    
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .popularMovies: return self.generatePopularMoviesLayout(isWide: isWideView)
            case .topRatedMovies: return self.generateTopRatedMoviesLayout()
            case .nowPlayingMovies: return self.generateNowPlayingMoviesLayout(isWide: isWideView)
            }
        }
        return layout
    }
    
    func generatePopularMoviesLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Show one item plus peek on narrow screens, two items plus peek on wider screens
        let groupFractionalWidth = isWide ? 0.475 : 0.95
        let groupFractionalHeight: Float = isWide ? 1/3 : 2/3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: CurationViewController.sectionHeaderElementKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generateTopRatedMoviesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(140),
            heightDimension: .absolute(186))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: CurationViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generateNowPlayingMoviesLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 2)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: CurationViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
//    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, Movie> {
//        let popularMovies = self.popularMovies
//        let topRatedMovies = self.topRatedMovies
//        let nowPlayingMovies = self.nowPlayingMovies
//
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
//        snapshot.appendSections([Section.popularMovies])
//        snapshot.appendItems(popularMovies)
//
//        snapshot.appendSections([Section.topRatedMovies])
//        snapshot.appendItems(topRatedMovies)
//
//        snapshot.appendSections([Section.nowPlayingMovies])
//        snapshot.appendItems(nowPlayingMovies)
//        return snapshot
//    }
}

extension CurationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var id = 0
        
        if section == 0 {
            id = self.popularMovies[row].id
        } else if section == 1 {
            id = self.topRatedMovies[row].id
        } else {
            id = self.nowPlayingMovies[row].id
        }
        
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.id = id
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
