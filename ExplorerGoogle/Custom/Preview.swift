//
//  Preview.swift
//  ExplorerGoogle
//
//  Created by Weslley on 04/10/19.
//  Copyright © 2019 URPay. All rights reserved.
//
import UIKit

class Preview {

    func setData(title: String, img: UIImage, price: Int) {
           user.text = title
           imageUser.image = img
           priceLabel.text = "R$\(price)"
       }
    
    
    var cardzin : UIView = {
        
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = #colorLiteral(red: 0.09959946066, green: 0.09959946066, blue: 0.09959946066, alpha: 1)
        
        element.layer.cornerRadius = 15.0
        element.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        element.layer.masksToBounds = true
        element.isHidden = true
        
        return element
    }()
    
    
    var user : UILabel = {
        let element = UILabel()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        
        
        guard let gothamBook = UIFont(name: "gotham-book", size: 15) else {
            fatalError("""
                Failed to load the "GothamBook" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
            """)
        }
        let title = "Fulano"
        let normalAttributteString = [.font: gothamBook, .foregroundColor: #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9647058824, alpha: 1) ] as [NSAttributedString.Key: Any]
        
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: normalAttributteString)
        element.attributedText = attributedTitle
      
        element.isHidden = true
        return element
    }()
    
    var priceLabel : UILabel = {
        let element = UILabel()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        
        
        guard let gothamBook = UIFont(name: "gotham-book", size: 10) else {
            fatalError("""
                Failed to load the "GothamBook" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
            """)
        }
        let title = "R$"
        let normalAttributteString = [.font: gothamBook, .foregroundColor: #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9647058824, alpha: 1) ] as [NSAttributedString.Key: Any]
        
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: normalAttributteString)
        element.attributedText = attributedTitle
      
        element.isHidden = true
        return element
    }()
    
    var imageUser : UIImageView = {
         let element = UIImageView()
         element.contentMode = .scaleAspectFit
         element.translatesAutoresizingMaskIntoConstraints = false
         
         element.layer.borderWidth = 1.5
         element.layer.masksToBounds = false
         element.layer.borderColor = UIColor.white.cgColor
         element.layer.cornerRadius = 19
         element.clipsToBounds = true
         element.isHidden = true
         return element
     }()
     
    
    
}
