//
//  CollectionViewController.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 2/25/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Test Data
    
    let messegeExampleArray: Array = ["Hello! Welcome to Work/Play Chat App!:)","What do you want to talk?"]
    
    //MARK: - Properties
    private let cellId = "MessageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messegeExampleArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionNewCell

        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedHeight = NSString(string: messegeExampleArray[indexPath.item]).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        // Adjust a size of the bubble and the text
        cell.bubbleView.frame = CGRect(x: 20, y: 0, width: estimatedHeight.width, height: estimatedHeight.height + 40)
        cell.messageTextView.frame = CGRect(x: 25, y: 0, width: estimatedHeight.width + 8, height: estimatedHeight.height + 40)
        
        // Create a Bubble style
        cell.bubbleView.layer.cornerRadius = 15
        cell.bubbleView.layer.masksToBounds = true
        
        cell.displayContent(message: messegeExampleArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedHeight = NSString(string: messegeExampleArray[indexPath.item]).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        return CGSize(width: view.frame.width, height: estimatedHeight.height + 40)
    }
    
}
