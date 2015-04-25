//
//  UISliderLabel.swift
//  Workouts
//
//  Created by Ian MacCallum on 3/22/15.
//  Copyright (c) 2015 MacCDevTeam. All rights reserved.
//

import UIKit

protocol UISliderLabelDelegate {
    func sliderLabel(sliderLabel: UISliderLabel, didChangeValue value: CGFloat)
    func sliderLabel(sliderLabel: UISliderLabel, formatForValue value: CGFloat) -> String?
    func sliderLabel(defaultValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat?
    func sliderLabel(minValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat?
    func sliderLabel(maxValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat?
    func sliderLabel(deviationValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat?
    func sliderLabel(incrementByValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat?
}

class UISliderLabel: UILabel {
    
    typealias ProgressBlock = (value: CGFloat) -> ()
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var startX: CGFloat!
    private var startValue: CGFloat!
    
    var delegate: UISliderLabelDelegate? {
        didSet {
            value = delegate?.sliderLabel(defaultValueForSliderLabel: self) ?? defaultValue
            min = delegate?.sliderLabel(minValueForSliderLabel: self) ?? 0
            max = delegate?.sliderLabel(maxValueForSliderLabel: self) ?? 1000
            deviation = delegate?.sliderLabel(deviationValueForSliderLabel: self) ?? 1
            increment = delegate?.sliderLabel(incrementByValueForSliderLabel: self) ?? 1
        }
    }

    var value: CGFloat! {
        didSet {
            delegate?.sliderLabel(self, didChangeValue: value)
            self.text = self.delegate?.sliderLabel(self, formatForValue: self.value) ?? "\(self.value)"
        }
    }
    
    var defaultValue: CGFloat = 0
    var min: CGFloat = 0
    var max: CGFloat = 1000
    var deviation: CGFloat = 10
    var increment: CGFloat = 1
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handleGestureRecognizer:")
        addGestureRecognizer(panGestureRecognizer)
        userInteractionEnabled = true
        
    }
    
    func handleGestureRecognizer(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            startX = sender.locationInView(self).x
            startValue = value
        case .Changed:
            let d = startValue + (floor((sender.locationInView(self).x - startX) / deviation) * increment)
            if min <= d && d <= max && d != value {
                println("d = \(d) startX = \(startX) startValue = \(startValue)")
                value = d
            }
        default:
            println("FAIL: currentX = \(sender.locationInView(self).x)   startX = \(startX) startValue = \(startValue)")
            break
        }
    }
}
