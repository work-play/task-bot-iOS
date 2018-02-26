//
//  CollectionNewCell.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 2/25/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import UIKit

class CollectionNewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var bubbleView: UIView!
    
    func displayContent(message: String){
        messageTextView.text = message
    }
    
}
