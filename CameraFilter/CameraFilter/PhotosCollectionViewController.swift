//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by KEEN on 2022/02/16.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
  
  private var images = [PHAsset]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populatePhotos()
  }
  
  private func populatePhotos() {
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      if status == .authorized { // 사진첩 접근 권한이 있는 경우
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        
        assets.enumerateObjects { (object, count, stop) in
          self?.images.append(object)
        }
        
        self?.images.reverse() // 가장 마지막에 선택한 이미지를 사용하기 위해서 reverse
        // print(self?.images)
      }
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = UICollectionViewCell()
    return cell
  }
}
