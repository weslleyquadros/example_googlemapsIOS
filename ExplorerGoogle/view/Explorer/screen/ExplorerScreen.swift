//
//  ExplorerScreen.swift
//  ExplorerGoogle
//
//  Created by Weslley on 02/10/19.
//  Copyright © 2019 URPay. All rights reserved.
//

import UIKit

final class ExplorerScreen : UIView {
    
    
    private var initialConstraints = [NSLayoutConstraint]()
    private let components: ExplorerComponents!
    private let stepComponents: StepComponents
    
  
    init( stepComponents: StepComponents, components: ExplorerComponents, frame : CGRect) {
        self.stepComponents = stepComponents
        self.components = components
        super.init(frame: frame)
        
        setupView()
        setupConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        components.bgGradientLayer.frame = (bounds)
        layer.addSublayer(components.bgGradientLayer)
        
        components.bgLayer.frame = (bounds)
        layer.addSublayer(components.bgLayer)
        
        addSubview(components.baseView)
        
        addSubview(components.titleLabel)
        
        addSubview(components.testeDegrade)
        
        components.baseView.addSubview(components.myMapView)
       
//        components.testeDegrade.
        
        
        
        
        components.myMapView.addSubview(components.btnMyLocation)
        
        components.myMapView.addSubview(components.testeDegrade)
        addSubview(stepComponents.seachTextField)
        stepComponents.seachTextField.setIconSearchLeft()
        
        addSubview(stepComponents.cardzin)
        addSubview(stepComponents.imageUser)
        addSubview(stepComponents.user)
        addSubview(stepComponents.priceLabel)
    }
    
    private func setupConstraints() {
        
        components.baseView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: percentOfHeight(percente: 75), trailling: nil, leading: nil)
        
        components.testeDegrade.anchor(top: components.baseView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: percentOfHeight(percente: 15), trailling: nil, leading: nil)
        
        components.titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: percentOfHeight(percente: 2), paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, trailling: nil, leading: nil)
        
        initialConstraints.append(components.titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor))
        
        components.myMapView.anchor(top: components.baseView.topAnchor, left: components.baseView.leftAnchor, bottom: components.baseView.bottomAnchor, right: components.baseView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: percentOfHeight(percente: 75), trailling: nil, leading: nil)
       
        
        stepComponents.seachTextField.anchor(top: components.baseView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50, trailling: nil, leading: nil)
        
        components.btnMyLocation.anchor(top: components.myMapView.topAnchor, left: nil, bottom: nil, right: components.baseView.rightAnchor, paddingTop: 130, paddingLeft: 0, paddingBottom: 0, paddingRight: -20, width: 50, height: 50, trailling: nil, leading: nil)

        
        stepComponents.cardzin.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: -15, width: 0, height: percentOfHeight(percente: 13), trailling: nil, leading: nil)
              
        stepComponents.imageUser.anchor(top: nil, left: stepComponents.cardzin.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft:  percentOfWidth(percente: 8), paddingBottom: 0, paddingRight: 0, width: 40, height: 40, trailling: nil, leading: nil)
             
        stepComponents.imageUser.centerY(inView: stepComponents.cardzin)
             
        stepComponents.user.anchor(top: stepComponents.cardzin.topAnchor, left: stepComponents.imageUser.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: percentOfWidth(percente: 5), paddingBottom: 0, paddingRight: 0, width: 0, height: 0, trailling: nil, leading: nil)
             
             
        stepComponents.priceLabel.anchor(top: stepComponents.user.bottomAnchor, left: stepComponents.imageUser.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: percentOfWidth(percente: 5), paddingBottom: 0, paddingRight: 0, width: 0, height: 0, trailling: nil, leading: nil)
        
         NSLayoutConstraint.activate(initialConstraints)
    }
    
}
