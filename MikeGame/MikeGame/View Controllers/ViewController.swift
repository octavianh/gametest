//
//  ViewController.swift
//  MikeGame
//
//  Created by O on 2020-03-11.
//  Copyright © 2020 O. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var cameraHolderView: UIView!
    @IBOutlet var spaceHelmet:UIImageView!
    
    var cameraView:CameraView?
    var currentlyShowingAFace = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCameraView()
    }
    
    func addCameraView() {
        cameraView = CameraView()
        guard let cv = cameraView else { return }
        
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(cv, belowSubview: spaceHelmet)
        
        NSLayoutConstraint.activate([
          cv.centerXAnchor.constraint(equalTo: cameraHolderView.centerXAnchor),
          cv.centerYAnchor.constraint(equalTo: cameraHolderView.centerYAnchor),
          cv.widthAnchor.constraint(equalTo: cameraHolderView.widthAnchor),
          cv.heightAnchor.constraint(equalTo: cameraHolderView.heightAnchor)
        ])
    }
    
    //MARK: - view manip
    //
    func roundCameraPreviewCorners(_ shouldRound: Bool) {
        shouldRound ? roundCornersForPreview() : squareCornersForPreview()
    }
    
    func roundCornersForPreview() {
        cameraView?.clipsToBounds = true
        cameraView?.layer.cornerRadius = (cameraView?.frame.size.height ?? 0)/2
    }
    
    func squareCornersForPreview() {
        cameraView?.layer.cornerRadius = 0
    }
    
    func showSpaceManHelmet(_ shouldShow: Bool) {
        shouldShow ? showHelmet() : hideHelmet()
    }
    
    func showHelmet() {
        self.spaceHelmet.alpha = 1
        self.spaceHelmet.transform = CGAffineTransform(scaleX: 0.8, y: 0.7)
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: {
            self.spaceHelmet.transform = .identity
        }, completion: nil)
    }
    
    func hideHelmet() {
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: {
            self.spaceHelmet.alpha = 0
        }, completion: nil)
    }
}

extension ViewController : CameraViewDelegate {
    
    func faceDetected() {
        if !currentlyShowingAFace {
            currentlyShowingAFace = true
            roundCameraPreviewCorners(true)
            showSpaceManHelmet(true)
        }
    }
    
    func faceNotDetected() {
        if currentlyShowingAFace {
            currentlyShowingAFace = false
            roundCameraPreviewCorners(false)
            showSpaceManHelmet(false)
        }
    }
}
