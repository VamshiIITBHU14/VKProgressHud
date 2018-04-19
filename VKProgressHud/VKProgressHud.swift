//
//  VKProgressHud.swift
//  VKProgressHud
//
//  Created by Vamshi Krishna on 25/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class VKProgressHud: UIView, UIScrollViewDelegate {
    
    var activeView : UIView!
   
    let rotatorImageLayer: CALayer = CALayer()
    let replicatorCircleLayer = CAReplicatorLayer()
    var circle = CALayer()
    var shapeLayerForCroc = CAShapeLayer()
    
    var animationDuration : Double = 2.5
    
    init(crocImageName:String) {
        
        let frame:CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        super.init(frame: frame)
        
        let backgroundImageView = UIImageView()
        backgroundImageView.frame = frame
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.backgroundColor = UIColor.clear
        addSubview(backgroundImageView)
        
        replicatorCircleLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let dotLength : CGFloat = 12
        let refreshRadius : CGFloat = 40
        circle.frame = CGRect(x:frame.size.width/2-refreshRadius , y:frame.size.height/2 - refreshRadius , width: dotLength, height: dotLength)
        circle.backgroundColor = UIColor.darkGray.cgColor
        circle.cornerRadius = dotLength/2
        let instanceCount = 12
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.3
        fadeOut.toValue = 1
        fadeOut.duration = animationDuration
        fadeOut.repeatCount = Float.greatestFiniteMagnitude
        
        circle.add(fadeOut, forKey: nil)
        
        replicatorCircleLayer.instanceDelay = fadeOut.duration / CFTimeInterval(instanceCount)
        replicatorCircleLayer.addSublayer(circle)
        replicatorCircleLayer.instanceCount = instanceCount
        
        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorCircleLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorCircleLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(replicatorCircleLayer)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width/2,y: frame.height/2), radius: refreshRadius+dotLength-2, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        shapeLayerForCroc.path = circlePath.cgPath
        shapeLayerForCroc.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayerForCroc)
        
        let airplaneImage = UIImageView()
        airplaneImage.image = UIImage(named:"croc")
        rotatorImageLayer.contents = airplaneImage.image?.cgImage
        rotatorImageLayer.frame = CGRect(x: 0, y: 0,
                                    width: airplaneImage.image!.size.width,
                                    height: airplaneImage.image!.size.height)
        
        
        rotatorImageLayer.opacity = 1.0
        rotatorImageLayer.position = CGPoint(
            x: frame.size.width/2 ,
            y: frame.size.height/2)
        rotatorImageLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(rotatorImageLayer)
        
        let label = VKLabel(frame: CGRect(origin: CGPoint(x:0 ,y:(frame.size.height/2)-(dotLength/2)), size: CGSize(width: frame.size.width, height: 24)))
        label.text = "LOADING"
        backgroundImageView.addSubview(label)
        
        
        beginRefreshing()
        
   
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showHUD(onView view:UIView){
        beginRefreshing()
        activeView = view
        activeView.addSubview(self)
        activeView.layer.opacity = 0.5
        activeView.isUserInteractionEnabled = false
    }
    
    func hideHUD(){
        endRefreshing()
    }
    
    func endRefreshing(){
        activeView.layer.opacity = 1.0
        activeView.isUserInteractionEnabled = true
        removeFromSuperview()
    }
  
    func beginRefreshing() {
        
        let crocAnimationPos = CAKeyframeAnimation(keyPath: "position")
        crocAnimationPos.path = shapeLayerForCroc.path
        crocAnimationPos.calculationMode = kCAAnimationLinear
    
        let crocOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        crocOrientationAnimation.fromValue = 0
        crocOrientationAnimation.toValue = 2.0 * .pi
        
        let crocAnimation = CAAnimationGroup()
        crocAnimation.duration = animationDuration
        crocAnimation.repeatDuration = .infinity
        crocAnimation.animations = [crocAnimationPos, crocOrientationAnimation]
        rotatorImageLayer.add(crocAnimation, forKey: nil)
        
    }
}


class VKLabel: UIView {
    
    let gradientLabelLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [
            UIColor.black.cgColor,
            UIColor.white.cgColor,
            UIColor.black.cgColor,
            ]
        gradient.colors = colors
        
        let locations: [NSNumber] = [
            0.0, 0.5 ,1.0
        ]
        gradient.locations = locations
        
        return gradient
    }()
    
    
     let textAttributesForLabel: [NSAttributedStringKey: Any] = {
        let ps = NSMutableParagraphStyle()
        ps.alignment = .center
        return [
            
            NSParagraphStyleAttributeName as NSString: ps
        ]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            
             let image = UIGraphicsImageRenderer(size: bounds.size)
                .image { _ in
                    text.draw(in: bounds, withAttributes: textAttributesForLabel as [String : Any])
            }
            
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image.cgImage
            
            gradientLabelLayer.mask = maskLayer
        }
    }
    
    
    override func layoutSubviews() {
        gradientLabelLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 3 * bounds.size.width,
            height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.addSublayer(gradientLabelLayer)
        
        let labelAnimation = CABasicAnimation(keyPath: "locations")
        labelAnimation.fromValue = [0.0, 0.0, 0.25]
        labelAnimation.toValue = [0.75, 1.0, 1.0]
        labelAnimation.duration = 1.5
        labelAnimation.repeatCount = Float.infinity
        
        gradientLabelLayer.add(labelAnimation, forKey: nil)
    }
    
}
