//
//  ArcView.swift
//  Ridiculus
//
//  Created by Kemal Hasan Atay on 7/31/18.
//  Copyright © 2018 ridiculus. All rights reserved.
//

import UIKit

@IBDesignable class ArcView: UIView {
    var fillColor: UIColor = .red
    var strokeColor: UIColor = .black
    
    var angle: CGFloat = 0
    init(angle: CGFloat, frame: CGRect) {
        self.angle = angle
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var radius: CGFloat {
        return bounds.width / 2;
    }
    private var centerOuter: CGPoint {
        return CGPoint(x: bounds.width / 2, y: bounds.height / 2);
    }
    var centerInner: CGPoint {
        var p = centerOuter;
        p.x += cos(.pi * angle / 180) * radius
        p.y += sin(.pi * angle / 180) * radius
        return p
    }
    private var outerStartAngle: CGFloat { // 60
        return (.pi / 3) + (.pi * angle / 180);
    }
    private var outerEndAngle: CGFloat { // 300
        return (.pi / 3 * 5) + (.pi * angle / 180);
    }
    private var innerStartAngle: CGFloat { // 240
        return (.pi / 3 * 4) + (.pi * angle / 180);
    }
    private var innerEndAngle: CGFloat {  // 120
        return (.pi / 3 * 2) + (.pi * angle / 180);
    }
    
    var endPoint: CGPoint {
        var p = center
        p.x += cos(outerEndAngle) * radius
        p.y += sin(outerEndAngle) * radius
        return p
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect);
        
        let path = UIBezierPath()
        path.addArc(withCenter: centerOuter, radius: radius, startAngle: outerStartAngle, endAngle: outerEndAngle, clockwise: true);
        path.addArc(withCenter: centerInner, radius: radius, startAngle: innerStartAngle, endAngle: innerEndAngle, clockwise: false)
        path.close();
        
        let shapeLayerOuter = CAShapeLayer();
        shapeLayerOuter.path = path.cgPath;
        shapeLayerOuter.fillColor = fillColor.cgColor;
        shapeLayerOuter.strokeColor = strokeColor.cgColor;
        shapeLayerOuter.lineWidth = 1;
        layer.addSublayer(shapeLayerOuter)
    }
    
}
