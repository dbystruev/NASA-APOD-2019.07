//
//  ViewController.swift
//  JSON Practice
//
//  Created by Denis Bystruev on 02/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var copyrightLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    var date = Date()
    var photoInfo: PhotoInfo?
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotoInfo()
    }
    
    func fetchPhotoInfo() {
        photoInfoController.parameters["date"] = formattedDate
        photoInfoController.fetchPhotoInfo { photoInfo in
            if let photoInfo = photoInfo {
                self.photoInfo = photoInfo
                self.updateLabels()
                self.photoInfoController.fetchImage(from: photoInfo.url) { image in
                    self.updateImage(with: image)
                }
            }
        }
    }
    
    func updateLabels() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.photoInfo?.title
            self.descriptionLabel.text = self.photoInfo?.description
            self.copyrightLabel.text = self.photoInfo?.copyright
            self.dateLabel.text = self.formattedDate
        }
    }
    
    func updateImage(with image: UIImage?) {
        OperationQueue.main.addOperation {
            self.imageView.image = image
        }
    }
    
    @IBAction func swipeGestureRecognized(_ sender: UISwipeGestureRecognizer) {
        print(#line, #function, sender.direction)
        
        switch sender.direction {
        case .right:
            print(#line, #function, "Right")
            date = date.addingTimeInterval(-60 * 60 * 24)
        case .left:
            print(#line, #function, "Left")
            let newDate = date.addingTimeInterval(60 * 60 * 24)
            guard newDate < Date() else { return }
            date = newDate
        default:
            return
        }
        fetchPhotoInfo()
    }
}

