//
//  NowPlayingMovieCell.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 18/02/21.
//

import UIKit

class NowPlayingMovieCell: BaseCell {
    
    static let reuseIdentifer = "now-playing-movie-reuse-identifier"
    
    var posterURL: URL? {
        didSet {
            configure()
        }
    }
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override func setupViews() {
        setupInterfaceComponent()
        setupConstraint()
    }
    
    func setupInterfaceComponent() {
        addSubview(coverImageView)
    }
    
    func setupConstraint() {
        coverImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension NowPlayingMovieCell {
    func configure() {
        let url = posterURL
        coverImageView.kf.setImage(with: url)
    }
}
