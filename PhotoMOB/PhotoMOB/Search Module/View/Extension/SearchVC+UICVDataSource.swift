//
//  SearchViewController+UICollectionViewDataSourceDelegate.swift
//  PhotoMOB
//

import UIKit
import Kingfisher

extension SearchViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photoResponce?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == presenter.photoResponce!.count - 1 {
            self.presenter.getNextPage()
            print("last item")
        }
        
        let photoItem = presenter.photoResponce![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.flickrPhotoView.kf.indicatorType = .activity
        let urlSt = URLBuilder.getUrlForImage(secret: presenter.photoResponce![indexPath.row].secret, id: presenter.photoResponce![indexPath.row].id, server: presenter.photoResponce![indexPath.row].server)
        let url = URL(string: urlSt)
        let image = UIImage(named: "placeholder")
        cell.flickrPhotoView.kf.setImage(with: url, placeholder: image)
        
        cell.descriptionLabel.text = photoItem.title
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = presenter.photoResponce?[indexPath.row]
        presenter.tapOnPhoto(photo: photo)
    }
}
