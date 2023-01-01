//
//  ChatCollectionViewCell.swift
//  Messenger
//
//  Created by Aamer Essa on 31/12/2022.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var messageText: UILabel!
    
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var messageBody: UIView!
    
    
    
    //    let textView:UITextView = {
//        let textV = UITextView()
//        textV.text = "AAAA"
//        textV.font = UIFont.systemFont(ofSize: 16)
//        return textV
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(textView)
//        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true 
//        
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
