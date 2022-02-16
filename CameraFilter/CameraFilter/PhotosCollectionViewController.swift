//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by KEEN on 2022/02/16.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populatePhotos()
  }
  
  private func populatePhotos() {
    PHPhotoLibrary.requestAuthorization { status in
      if status == .authorized {
        // 사진첩 접근 권한이 있는 경우
        
      }
    }
  }
}
