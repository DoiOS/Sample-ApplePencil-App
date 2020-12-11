//
//  CanvasViewController.swift
//  Sample-ApplePencil-App
//
//  Created by Sungmin on 2020/12/11.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var canvasView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }

        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, 0.0)

        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        canvasView.image?.draw(in: canvasView.bounds)

        let previousPoint = firstTouch.previousLocation(in: canvasView)
        let currentPoint = firstTouch.location(in: canvasView)
        let lineWidth: CGFloat = 3.0

        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(lineWidth)
        context.setLineCap(.round)

        context.move(to: CGPoint(x: previousPoint.x, y: previousPoint.y))
        context.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))

        context.strokePath()

        canvasView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

}

extension CanvasViewController {

    @IBAction func didTapClearButton(_ sender: Any) {
        canvasView.image = .none
    }

}

