//
//  ExplorerComponents.swift
//  ExplorerGoogle
//
//  Created by Weslley on 02/10/19.
//  Copyright © 2019 URPay. All rights reserved.
//

import UIKit
import GoogleMaps

class ExplorerComponents {
    
    var bgGradientLayer : CAGradientLayer = {
             let bg = CAGradientLayer()
             bg.backgroundColor = #colorLiteral(red: 0.7417137027, green: 0.4405708313, blue: 1, alpha: 1)
             bg.colors = [  #colorLiteral(red: 0.01175031811, green: 0.3921851218, blue: 0.7913323045, alpha: 1).cgColor, #colorLiteral(red: 0.7417137027, green: 0.4405708313, blue: 1, alpha: 0.3135728433).cgColor, #colorLiteral(red: 0.7417137027, green: 0.4405708313, blue: 1, alpha: 1).cgColor]
             bg.startPoint = CGPoint.init(x: 0.5, y: 0)
             bg.endPoint = CGPoint.init(x: 0.5, y: 1)
             return bg
    }()
         

    var bgLayer : CALayer = {
          let element = CALayer()
          element.contentsGravity = CALayerContentsGravity.resizeAspectFill
          element.contents = UIImage(named: "maps-2")?.cgImage
          element.compositingFilter = "multiplyBlendMode"
    
             
          return element
      }()

 
    var baseView : UIView = {
        
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = #colorLiteral(red: 0.09959946066, green: 0.09959946066, blue: 0.09959946066, alpha: 1)
        
        element.layer.cornerRadius = 15.0
        element.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        element.layer.masksToBounds = true
        
        return element
    }()
    
    var testeDegrade : UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
      
        if UIDevice().userInterfaceIdiom == .phone {
               switch UIScreen.main.nativeBounds.height {
               case 1136:
                   //                print("iPhone 5 or 5S or 5C")
                   break
               case 1334:
                   //                print("iPhone 6/6S/7/8")
                   break
               case 1920, 2208:
                   //                print("iPhone 6+/6S+/7+/8+")
                element.frame.size = CGSize(width: 414, height: 200)
                
               case 2436:
                   //                print("iPhone X, XS")
                   element.frame.size = CGSize(width: 414, height: 140)
                  
               case 2688:
                   //                print("iPhone XS Max")
                  
                   element.frame.size = CGSize(width: 414, height: 250)
                 
               case 1792:
                   //                print("iPhone XR")
                   element.frame.size = CGSize(width: 414, height: 140)
                 
               default:
                   print("Unknown")
               }
           }
        
        
        let gradient = CAGradientLayer(layer: element.layer)
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.6)
        let whiteColor = #colorLiteral(red: 0.0862745098, green: 0.09803921569, blue: 0.1176470588, alpha: 1)
        gradient.colors = [whiteColor.withAlphaComponent(1.0).cgColor, whiteColor.withAlphaComponent(0.7).cgColor, whiteColor.withAlphaComponent(0.0).cgColor]
//        gradient.locations = [NSNumber(value: 0.0),NSNumber(value: 0.2),NSNumber(value: 1.0)]
        gradient.frame = element.bounds
//        element.layer.mask = gradient

        
        gradient.cornerRadius = 15.0
        gradient.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
////
        element.layer.cornerRadius = 15.0
        element.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//
        element.layer.insertSublayer(gradient, at: 0)
////        element.layer.addSublayer(bg)
        
        

        
        return element
    }()
    
    
    var teste : UIView = {
        
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        element.layer.cornerRadius = 15.0
        element.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        element.layer.masksToBounds = true
     
        
        return element
    }()
    
    var titleLabel: UILabel = {
        let element = UILabel()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        
        
        guard let gothamBook = UIFont(name: "gotham-book", size: 22) else {
            fatalError("""
                Failed to load the "GothamBook" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
            """)
        }
        let title = "Explorer"
        let normalAttributteString = [.font: gothamBook, .foregroundColor: #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9647058824, alpha: 1) ] as [NSAttributedString.Key: Any]
        
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: normalAttributteString)
        element.attributedText = attributedTitle
      
        return element
    }()
    
    
    var myMapView: GMSMapView = {
        let element = GMSMapView()
        element.translatesAutoresizingMaskIntoConstraints=false
        
        return element
    }()
    
       var seachTextField : CustomTextField = {
         let element = CustomTextField()
         element.translatesAutoresizingMaskIntoConstraints=false
         element.padding = UIEdgeInsets(top: 16, left: 75, bottom: 16, right: 50)
         element.backgroundColor = .clear
         guard let gotham = UIFont(name: "gotham", size: 16) else {
             fatalError("""
                 Failed to load the "GothamBold" font.
                 Make sure the font file is included in the project and the font name is spelled correctly.
             """)
         }
         element.alpha = 1
         element.layer.cornerRadius = 15
         element.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
         
         element.attributedPlaceholder
             = NSAttributedString( string: "Pesquisar",
                                   attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) , NSAttributedString.Key.font: gotham] )
         
         
         element.font = gotham
         element.elevate(elevation: 0)

         return element
         
     }()
    
    let btnMyLocation: UIButton = {
        let element = UIButton()
        element.backgroundColor = UIColor.white
        element.setImage(#imageLiteral(resourceName: "my_location"), for: .normal)
        element.layer.cornerRadius = 25
        element.clipsToBounds=true
        element.tintColor = UIColor.gray
        element.imageView?.tintColor=UIColor.gray
        element.translatesAutoresizingMaskIntoConstraints=false
       
        element.alpha = 0.6
        return element
    }()
    
    
}


