//
//  SpiralView.swift
//  Ridiculus
//
//  Created by Kemal Hasan Atay on 7/31/18.
//  Copyright © 2018 ridiculus. All rights reserved.
//

import UIKit

@IBDesignable public class SpiralView: AnimationView {
    
    @IBInspectable public var fillColor: UIColor = .darkGray
    @IBInspectable public var strokeColor: UIColor = .white
    
    var arcs = [ArcView]()
    
    override func initialize() {
        super.initialize()
        for i in 0..<6 {
            let arcView = ArcView(angle: CGFloat(i) * 60, frame: CGRect(origin: .zero, size: CGSize(width: bounds.height + 200, height: bounds.height + 200)))
            addSubview(arcView);
            arcs.append(arcView)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        for arcView in arcs {
            arcView.backgroundColor = UIColor.clear;
            arcView.center = center
            arcView.center.x += (center.x - arcView.endPoint.x)
            arcView.center.y += (center.y - arcView.endPoint.y)
            arcView.fillColor = fillColor
            arcView.strokeColor = strokeColor
        }
    }
    
    private var currentRatio: CGFloat = 0;
    
    override func startAni(translation: CGPoint) {
        let totalDistance = sqrt(pow(bounds.width / 2, 2) + pow(bounds.height / 2, 2))
        let distance = sqrt(pow(abs(translation.x), 2) + pow(abs(translation.y), 2))
        currentRatio = pow(min(distance / totalDistance, 1), 2)
        let angle = currentRatio * (-(CGFloat.pi / 3))
        for arc in arcs {
            arc.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    override func finishAnimating() {
        var angle: CGFloat = 0
        if currentRatio > 0.4 {
            angle = -(CGFloat.pi / 3)
        }
        UIView.animate(withDuration: 0.3, animations: {
            for arc in self.arcs {
                arc.transform = CGAffineTransform(rotationAngle: angle)
            }
        }) { (completed) in
            if angle != 0 {
                self.delegate?.didFinishAnimating()
            }
        }
    }
    
    override func startAndFinishAnimations() {
        currentRatio = 1
        finishAnimating()
    }
}
