//
//  AnimationView.swift
//  Ridiculus
//
//  Created by Kemal Hasan Atay on 7/31/18.
//  Copyright © 2018 ridiculus. All rights reserved.
//

import UIKit

public class AnimationView: UIView {
    var delegate: AnimationViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialize()
    }
    
    func initialize() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panPiece(_:))))
    }
    
    func startAni(translation: CGPoint) {
    }
    
    func finishAnimating() {
    }
    
    func startAndFinishAnimations() {
        
    }
    
    @objc func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else {return}
        let piece = gestureRecognizer.view!
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: piece.superview)
        startAni(translation: translation)
        if gestureRecognizer.state == .began {
            self.delegate?.didBeginAnimating()
        } else if gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended {
            finishAnimating()
        }
    }
}
