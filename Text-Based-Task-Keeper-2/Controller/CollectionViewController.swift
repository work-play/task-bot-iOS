//
//  CollectionViewController.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 2/25/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import UIKit
import Alamofire

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Test Data
    let messegeExampleArray: Array = ["Hello! Welcome to Work/Play Chat App!:)","What do you want to talk?"]
    var messageExample: [Message] = [Message(message:"Hello! Welcome to Work/Play Chat App!:)", isSender: false), Message(message:"What do you want to talk?", isSender: false)]
    
    //MARK: - Properties
    private let cellId = "MessageCell"
    @IBOutlet weak var taskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("auth key:" + Constants.Auth.keychain[string: "Authorization"]!)
        print("open!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageExample.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionNewCell

        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedHeight = NSString(string: messageExample[indexPath.item].message).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        var defaultWidth = estimatedHeight.width
        var defaultHeight = estimatedHeight.height
        
        if estimatedHeight.width < 50 {
            defaultWidth = 100
        }
        
        if messageExample[indexPath.item].isSender == false {
            // Adjust a size of the bubble and the text
            cell.bubbleView.frame = CGRect(x: 0, y: 0
                , width: defaultWidth, height: estimatedHeight.height + 60)
            cell.messageTextView.frame = CGRect(x: 5, y: 10, width: defaultWidth + 8, height: estimatedHeight.height + 60)
            
            // Create a Bubble style
            let rectShape = CAShapeLayer()
            rectShape.bounds = cell.bubbleView.frame
            rectShape.position = cell.bubbleView.center
            rectShape.path = UIBezierPath(roundedRect: cell.bubbleView.bounds, byRoundingCorners: [.bottomRight , .topRight], cornerRadii: CGSize(width: 35, height: 35)).cgPath

            cell.bubbleView.layer.masksToBounds = true
            cell.bubbleView.backgroundColor = UIColor(red: 85/255, green: 123/244, blue: 226/255, alpha: 1)
            cell.messageTextView.textColor = UIColor.white
            cell.bubbleView.layer.mask = rectShape
            
            cell.displayContent(message: messageExample[indexPath.item].message)
            
        } else {
            // Adjust a size of the blue bubble and the text
            cell.bubbleView.frame = CGRect(x: view.frame.width - defaultWidth, y: 0, width: defaultWidth, height: estimatedHeight.height + 60)
            cell.messageTextView.frame = CGRect(x: view.frame.width - defaultWidth + 18, y: 10, width: defaultWidth + 8 , height: estimatedHeight.height + 60)
            
            // Create a blue Bubble style
            let rectShape = CAShapeLayer()
            rectShape.bounds = cell.bubbleView.frame
            rectShape.position = cell.bubbleView.center
            rectShape.path = UIBezierPath(roundedRect: cell.bubbleView.bounds, byRoundingCorners: [.bottomLeft , .topLeft], cornerRadii: CGSize(width: 35, height: 35)).cgPath
            
            cell.bubbleView.layer.masksToBounds = true
            cell.bubbleView.backgroundColor = UIColor(red: 58/255, green: 207/255, blue: 213/255, alpha: 1)
            cell.messageTextView.textColor = UIColor.white
            cell.bubbleView.layer.mask = rectShape
            
            cell.displayContent(message: messageExample[indexPath.item].message)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedHeight = NSString(string: messageExample[indexPath.item].message).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        return CGSize(width: view.frame.width, height: estimatedHeight.height + 60)
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        //If the text field is not empty, add the input to the array, show it as sender's message (blue bubble)
        if let newMessageText = taskTextField.text {
            let newMessage = Message(message: newMessageText, isSender: true)
            messageExample.append(newMessage)
            
            //Send server
            sendMessageTotheServer(message: newMessageText)
            
        }
        taskTextField.text = nil
        collectionView?.reloadData()
    }
    
    func sendMessageTotheServer(message: String){
        let url = Constants.Config.baseURL + "/9/tasks"
        let parameters = ["task": message]
        
        // cookies
        // let cookies = HTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(authUrl!)
        let cookies = HTTPCookieStorage.shared.cookies
        
        //let header  = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies!)
        //request.allHTTPHeaderFields = header
        
        let header = HTTPCookie.requestHeaderFields(with: cookies!)
        
        var headers: HTTPHeaders = [:]
        headers["Authorization"] = Constants.Auth.keychain[string: "Authorization"]

        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header).responseString { response in
            print("Success: \(response.result.isSuccess)")
            
            if response.result.isSuccess {
                print("success")
                
            } else {
                // Show error
                print("false")
                
            }
        }
    }
}
