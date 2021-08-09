//
//  PhotoChooseService.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation
import UIKit
import Photos
import FoundationExtension

final class PhotoChooseService: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Private properties
    
    private lazy var cameraPicker = UIImagePickerController()
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    private lazy var alert = createAlert()
    private var viewController: UIViewController!
    private var pickImageCallback : (([UIImage]) -> ())?
    
    // MARK: Overriden functions
    
    convenience init(in viewController: UIViewController) {
        self.init()
        self.viewController = viewController
    }
    
    // MARK: Public functions

    func pickImage(callback: @escaping (([UIImage]) -> ())) {
        pickImageCallback = callback

        alert.popoverPresentationController?.sourceView = self.viewController.view

        viewController.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalMistake("Expected a dictionary containing an image, but was provided the following: \(info)")
            return
        }
        pickImageCallback?([image])
    }
    
    // MARK: Private functions
    
    private func createAlert() -> UIAlertController {
        let alert = UIAlertController(title: .localize.chooseImage.capitalizingFirstLetter(), message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: .localize.camera.capitalizingFirstLetter(), style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: .localize.gallery.capitalizingFirstLetter(), style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: .localize.cancel.capitalizingFirstLetter(), style: .cancel){
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    private func closeAlert() {
        alert.dismiss(animated: true, completion: nil)
    }
    
    private func openCamera() {
        closeAlert()
        if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
            cameraPicker.sourceType = .camera
            cameraPicker.delegate = self
            self.viewController.present(cameraPicker, animated: true, completion: nil)
        } else {
            self.viewController.alert.showErrorAlert(message: .localize.cameraNotFound.capitalizingFirstLetter())
        }
    }
    
    private func openGallery() {
        closeAlert()
        self.viewController.present(picker, animated: true, completion: nil)
    }
    
}
