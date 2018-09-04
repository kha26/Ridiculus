//
//  BubbleView.swift
//  Ridiculus
//
//  Created by Kemal Hasan Atay on 7/31/18.
//  Copyright © 2018 ridiculus. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class BubbleView: AnimationView {
    
    @IBInspectable public var bubbleColor: UIColor = .black
    
    var bubbles = [UIView]()
    
    override func initialize() {
        super.initialize()
        
        let noColumns = 2
        let noRows = 3
        let width = bounds.width / CGFloat(noColumns)
        let height = bounds.height / CGFloat(noRows)
        let size = max(width, height) * 2
        for i in 0..<noRows {
            for j in 0..<noColumns {
                let x = CGFloat(j) * width + CGFloat.random(width / 5, width * 4 / 5)
                let y = CGFloat(i) * height + CGFloat.random(height / 5, height * 4 / 5)
                let view = UIView()
                view.frame.size = CGSize(width: size, height: size)
                view.center = CGPoint(x: x, y: y)
                view.layer.cornerRadius = size / 2
                view.backgroundColor = bubbleColor
                addSubview(view)
                bubbles.append(view)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for bubble in bubbles {
            bubble.backgroundColor = bubbleColor
        }
    }
    
    private var currentRatio: CGFloat = 1
    override func startAni(translation: CGPoint) {
        let totalDistance = sqrt(pow(bounds.width / 2, 2) + pow(bounds.height / 2, 2))
        let distance = sqrt(pow(abs(translation.x), 2) + pow(abs(translation.y), 2))
        currentRatio = 1 - sqrt(min(distance / totalDistance, 1)) //pow(, 2)
        for bubble in bubbles {
            bubble.transform = CGAffineTransform(scaleX: currentRatio, y: currentRatio)
        }
    }
    
    override func finishAnimating() {
        var scale: CGFloat = 1
        if currentRatio < 0.5 {
            scale = 0.001
        }
        UIView.animate(withDuration: 0.3, animations: {
            for bubble in self.bubbles {
                bubble.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }) { (completed) in
            if scale == 0.001 {
                self.delegate?.didFinishAnimating()
            }
        }
    }
    
    override func startAndFinishAnimations() {
        currentRatio = 0
        finishAnimating()
    }
}
