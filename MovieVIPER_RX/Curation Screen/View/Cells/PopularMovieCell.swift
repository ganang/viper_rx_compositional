//
//  PopularMovieCell.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 18/02/21.
//

import UIKit

class PopularMovieCell: BaseCell {
    
    static let reuseIdentifer = "popular-movie-reuse-identifier"
    
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

extension PopularMovieCell {
    func configure() {
        let data = try? Data(contentsOf: posterURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        coverImageView.image = UIImage(data: data!)
    }
}
