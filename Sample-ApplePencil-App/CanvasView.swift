//
//  CanvasView.swift
//  Sample-ApplePencil-App
//
//  Created by 주성민 on 2021/01/10.
//

import UIKit

struct Line {
    let storkeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}

struct TaskStack {
    private(set) var redoStack: [Line]

    mutating func push(_ task: Line) {
        redoStack.append(task)
    }

    mutating func pop() -> Line? {
        return redoStack.popLast()
    }
}

class CanvasView: UIView {

    var taskStack = TaskStack(redoStack: [])
    var lines: [Line] = []
    var strokeWidth: Float = 3.0
    var strokeColor: UIColor = UIColor.black

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(storkeWidth: strokeWidth, color: strokeColor, points: []))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)

        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskStack = TaskStack(redoStack: [])
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        lines.forEach { (line) in

            for (index, point) in line.points.enumerated() {
                if index == 0 { // first index
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }

    }

}

extension CanvasView {

    func clearCanvasView() {
        lines = []
        taskStack = TaskStack(redoStack: [])
        setNeedsDisplay()
    }

    func undo() {
        guard let lastTask = lines.popLast() else { return}
        taskStack.push(lastTask)
        setNeedsDisplay()
    }

    func redo() {
        guard let lastTask = taskStack.pop() else { return }
        lines.append(lastTask)
        setNeedsDisplay()
    }
}
