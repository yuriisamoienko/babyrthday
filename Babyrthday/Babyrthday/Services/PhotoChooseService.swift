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
import AssetsPickerViewController // used https://github.com/DragonCherry/AssetsPickerViewController becouse this will not be effective doing yourself

final class PhotoChooseService: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AssetsPickerViewControllerDelegate {

    // MARK: Private properties
    
    private lazy var cameraPicker = UIImagePickerController()
    private lazy var picker: AssetsPickerViewController = {
        let picker = AssetsPickerViewController()
        picker.pickerDelegate = self
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

    public func pickImage(callback: @escaping (([UIImage]) -> ())) {
        pickImageCallback = callback

        alert.popoverPresentationController?.sourceView = self.viewController.view

        viewController.present(alert, animated: true, completion: nil)
    }
    
    @discardableResult
    public func setMaximumSelectionCount(_ value: Int) -> Self {
        picker.pickerConfig.assetsMaximumSelectionCount = value
        return self
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalMistake("Expected a dictionary containing an image, but was provided the following: \(info)")
            return
        }
        pickImageCallback?([image])
    }

    // MARK: AssetsPickerViewControllerDelegate
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {
        
    }
    
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {
        
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        // do your job with selected assets
        var images = [UIImage]()
        for item in assets {
            if let image = item.originalImage {
                images.append(image)
            }
        }
        pickImageCallback?(images)
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {
        
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {
        
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
