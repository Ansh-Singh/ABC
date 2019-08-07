//
//  BaseDocumentPickerView.swift
//  Profile
//
//  Created by Milan Katiyar on 24/07/19.
//  Copyright © 2019 learning. All rights reserved.
//

import Foundation
import UIKit
import Photos

public class BaseDocumentPickerView : UIView {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var document_titleLbl: UILabel!
    @IBOutlet weak var document_nameTF: UITextField!
    
    let picker = UIImagePickerController()
   
    var vc : UIViewController!
    
      var uploadImage: UIImage!
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    public func setController(vc : UIViewController){
        self.vc = vc
    }
    
    func initializeView() {
        let podBundle = Bundle(for: BaseDocumentPickerView.self)
        let nib = UINib(nibName: "BaseDocumentPickerView", bundle: podBundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        
    }

    @IBAction func openDocumentPicker(_ sender: Any) {
       
        let actionsheet = UIAlertController(title: "", message: "Select a receipt", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
        }))
        actionsheet.addAction(UIAlertAction.init(title: "From Library", style: .default, handler: { (action) in
            self.selectFromLibrary()
        }))
        actionsheet.addAction(UIAlertAction.init(title: "From Camera", style: .default, handler: { (action) in
             self.selectFromCamera()
        }))
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            if let popoverController = actionsheet.popoverPresentationController {
                popoverController.sourceView = self.vc.view
                popoverController.sourceRect = CGRect(x: self.vc.view.bounds.midX, y: self.vc.view.bounds.maxY-60, width: 0, height: 0)
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.down;
            }
        }

        vc.present(actionsheet, animated: true, completion: nil)

    }
    
    
    func selectFromLibrary() {
        picker.allowsEditing = false
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        vc.present(picker, animated: true, completion: nil)
    }

    
    func selectFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            vc.present(picker,animated: true,completion: nil)
        } else {
           DataUtil.alertMessage("Sorry, this device has no camera", viewController: vc)
        }
    }
    

    
}

/*extension BaseDocumentPickerView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        guard let chosenImage = info[.originalImage] as? UIImage
            else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

//        let resizedImage = self.resizeImage(image: chosenImage, targetSize: CGSize(width: 200.0, height: 200.0))
        uploadImage = chosenImage
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd_HHmmss"
        document_nameTF.text = dateformatter.string(from: Date()) + ".jpg"
        picker.dismiss(animated:true, completion: nil)
    }

//    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//        let size = image.size
//
//        let widthRatio  = targetSize.width  / size.width
//        let heightRatio = targetSize.height / size.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        }
//
//        // This is the rect that we've calculated out and this is what is actually used below
//        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        image.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
}
*/
