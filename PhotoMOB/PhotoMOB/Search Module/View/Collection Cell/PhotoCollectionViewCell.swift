//
//  PhotoCollectionViewCell.swift
//  PhotoMOB
//

import Foundation
import UIKit
import TinyConstraints

class PhotoCollectionViewCell: UICollectionViewCell {
    var flickrPhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Hello"
        descLabel.numberOfLines = 0
        descLabel.textColor = .white
        descLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        descLabel.numberOfLines = 2
        descLabel.height(40)
        return descLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 6
        self.contentView.backgroundColor = tintColor
        
        setUpViews()
    }
    
    fileprivate func setUpViews(){
        addViews()
        constrainViews()
    }
    
    fileprivate func addViews(){
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(flickrPhotoView)
    }
    
    fileprivate func constrainViews(){
    
        descriptionLabel.edgesToSuperview(excluding: .top, insets: .left(5) + .right(5) + .bottom(3))
        
        flickrPhotoView.edgesToSuperview(excluding: .bottom)
        flickrPhotoView.bottomToTop(of: descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Никто это никогда не делает")
    }
}
