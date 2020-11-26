//
//  DetailViewController.swift
//  PhotoMOB
//

import UIKit
import TinyConstraints
import Kingfisher

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    // MARK: - Views Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpViews()
        presenter.setPhoto()
    }
    
    // MARK: - Views
    var flickrPhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Hello"
        descLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        descLabel.numberOfLines = 2
        return descLabel
    }()
    
    fileprivate func setUpViews(){
        addViews()
        constrainViews()
    }
    
    fileprivate func addViews(){
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(flickrPhotoView)
    }
    
    fileprivate func constrainViews(){
        descriptionLabel.edgesToSuperview(excluding: .bottom, insets: .top(30) + .left(15) + .right(15),isActive: true, usingSafeArea: true)
        
        flickrPhotoView.centerXToSuperview()
        flickrPhotoView.width(self.view.bounds.width - 30)
        flickrPhotoView.topToBottom(of: descriptionLabel, offset: 50)
    }
}

extension DetailViewController: DetailViewProtocol{
    func setPhoto(photo: Photo?) {
        self.descriptionLabel.text = photo?.title
        
        let urlSt = URLBuilder.getUrlForImage(secret: photo!.secret, id: photo!.id, server: photo!.server)
        let url = URL(string: urlSt)
        let image = UIImage(named: "placeholder")
        flickrPhotoView.kf.setImage(with: url, placeholder: image)
    }
}
