//
//  AnimationViewController.swift
//  Ridiculus
//
//  Created by Kemal Hasan Atay on 7/31/18.
//  Copyright © 2018 ridiculus. All rights reserved.
//

import UIKit

public class AnimationViewController: UIViewController {
    var type: AnimationType
    var viewControllerToPresent: UIViewController!
    var animationView: AnimationView!
    
    init(type: AnimationType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        type = .spiral
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public required init?(coder aDecoder: NSCoder) {
        type = .spiral
        super.init(coder: aDecoder)
    }
    
    var needsToAddView = true;
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.bounds
        switch type {
        case .spiral:
            animationView = SpiralView(frame: frame)
            (animationView as? SpiralView)?.fillColor = UIColor.darkGray
            (animationView as? SpiralView)?.strokeColor = UIColor.darkGray
        case .bubble:
            animationView = BubbleView(frame: frame)
            (animationView as? BubbleView)?.bubbleColor = UIColor.groupTableViewBackground
        }
        animationView.delegate = self
        view.addSubview(animationView)
    }
}

extension AnimationViewController: AnimationViewDelegate {
    func didBeginAnimating() {
        if needsToAddView {
            needsToAddView = false
            if type == .bubble {
                viewControllerToPresent = AnimationViewController(type: .spiral)
            } else {
                viewControllerToPresent = AnimationViewController(type: .bubble)
            }
            self.view.insertSubview(viewControllerToPresent.view, belowSubview: animationView)
        }
    }
    
    func didFinishAnimating() {
        let viewControllerToPresent: AnimationViewController
        if type == .bubble {
            viewControllerToPresent = AnimationViewController(type: .spiral)
        } else {
            viewControllerToPresent = AnimationViewController(type: .bubble)
        }
        present(viewControllerToPresent, animated: false, completion: nil)
    }
}

protocol AnimationViewDelegate {
    func didFinishAnimating();
    func didBeginAnimating();
}
