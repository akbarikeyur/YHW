//
//  AddWeightImageCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/2/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddWeightImageCell: TableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imgCollectionView : CollectionView!
    var arrMedia = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgCollectionView.register(UINib(nibName: String(describing:AddImageCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:AddImageCell.self))
        
        self.imgCollectionView.register(UINib(nibName: String(describing:WeightImageListCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:WeightImageListCell.self))
    }

    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrMedia.count > 2 ? arrMedia.count+0 :arrMedia.count+1)
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row < arrMedia.count) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:WeightImageListCell.self), for: indexPath as IndexPath) as! WeightImageListCell
            cell.configureCellWithImage(imageSting: arrMedia[indexPath.row], withIndexPath: indexPath)
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:AddImageCell.self), for: indexPath as IndexPath) as! AddImageCell
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        if (indexPath.row < arrMedia.count) {
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.deleteImage(with: indexPath)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.parentViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.parentViewController?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.parentViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.parentViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imgUrl:URL!
        if #available(iOS 11.0, *){
             imgUrl = info[UIImagePickerControllerImageURL] as? URL
        }else{
            imgUrl = info[UIImagePickerControllerMediaURL] as? URL
        }
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let data = UIImagePNGRepresentation(image)! as NSData
            data.write(toFile: localPath!, atomically: true)
            arrMedia.append(localPath!)
            imgCollectionView.reloadData()
            
            //let imageData = NSData(contentsOfFile: localPath!)!
            let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            print(photoURL)
            
            picker.dismiss(animated: true, completion: nil)
    }
    
    func deleteImage(with index: IndexPath?) {
        arrMedia.remove(at: (index?.row)!)
        imgCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
