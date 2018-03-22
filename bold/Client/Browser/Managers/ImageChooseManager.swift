//
//  ImageChooseManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 3/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class ImageChooseManager:NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    private var imagePicker = UIImagePickerController()
    public var imagePickerDelegate:ImagePickerDelegate?
    override init() {
        super.init()
        self.imagePicker.delegate = self
    }
    
    @objc func setBackgroundImage(){
        imagePicker.sourceType = .photoLibrary;
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePickerDelegate?.imagePicker(picker, imageChosen: chosenImage)
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated:true, completion: nil)
        imagePickerDelegate?.imagePicker(picker, imageNotChosen: #imageLiteral(resourceName: "background-image"))
    }

}

