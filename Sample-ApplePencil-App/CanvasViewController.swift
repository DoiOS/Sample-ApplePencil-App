//
//  CanvasViewController.swift
//  Sample-ApplePencil-App
//
//  Created by Sungmin on 2020/12/11.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!

}

extension CanvasViewController {

    @IBAction func didTapClearButton(_ sender: Any) {
        canvasView.clearCanvasView()
    }

    @IBAction func undo(_ sender: Any) {
        canvasView.undo()
    }

    @IBAction func redo(_ sender: Any) {
        canvasView.redo()
    }

}

