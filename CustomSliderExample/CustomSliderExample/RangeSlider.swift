//
//  RangeSlider.swift
//  CustomSliderExample
//
//  Created by shendong on 16/9/8.
//  Copyright © 2016年 shendong. All rights reserved.
//

import UIKit
import QuartzCore
/*
 Note
 1. The method 'rectByInsetting' in CGRect extenison has been replaced by 'insetBy'
 
 */
@IBDesignable

class RangeSlider: UIControl {
    @IBInspectable var minimumValue: Double = 0.0 {
        didSet{
            updateLayerFrames()
        }
    }
    /// default 1.0. the current value may change if outside new max value
    @IBInspectable var maximunValue: Double = 1.0 {
        didSet{
            updateLayerFrames()
        }
    }
    /// default 0.2. this value will be pinned to min/max
    @IBInspectable var lowerValue: Double = 0.2 {
        didSet{
            if lowerValue > upperValue {
                assert(lowerValue > upperValue)
            }
            updateLayerFrames()
        }
    }
    /// default 0.8. this value will be pinned to min/max
    @IBInspectable var upperValue: Double = 0.8 {
        didSet{
            
            if lowerValue > upperValue {
                assert(lowerValue > upperValue)
            }
           
            updateLayerFrames()
        }
    }
    var thumbWidth: CGFloat{
        return CGFloat(bounds.height)
    }
    @IBInspectable var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0){
        didSet{
            trackLayer.setNeedsDisplay()
        }
    }
    @IBInspectable var trackHighlightTintColor: UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet{
            trackLayer.setNeedsDisplay()
        }
    }
    @IBInspectable var thumbTintColor: UIColor = UIColor.whiteColor(){
        didSet{
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    @IBInspectable var curvaceousness: CGFloat = 1.0 {
        didSet{
            trackLayer.setNeedsDisplay()
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    private var previousLocation = CGPoint()
    
    let trackLayer      = RangeSliderTrackLayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    //MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        trackLayer.rangeSlider = self
        layer.addSublayer(trackLayer)
        lowerThumbLayer.rangeSlider = self
        layer.addSublayer(lowerThumbLayer)
        upperThumbLayer.rangeSlider = self
        layer.addSublayer(upperThumbLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override var frame: CGRect{
        didSet{
            updateLayerFrames()
        }
    }
    //MARK: private method
    func updateLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let lowerThumCenter = CGFloat(positionForValue(lowerValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
                                       width: thumbWidth, height: thumbWidth)
        
        upperThumbLayer.setNeedsDisplay()
        CATransaction.commit()
    }
    func positionForValue(value: Double) -> Double{
        return Double(bounds.width - thumbWidth) * (value - minimumValue) / (maximunValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double{
        return min(max(value, lowerValue), upperValue)
    }
    //MARK: UIControl override method
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        previousLocation = touch.locationInView(self)
        if  lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
            print("beign lower");
        }else if upperThumbLayer.frame.contains(previousLocation){
            upperThumbLayer.highlighted = true
            print("begin upper")
        }
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        
        //determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let delvaValue = (maximunValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        previousLocation = location
        //update the values
        if lowerThumbLayer.highlighted {
            lowerValue += delvaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
            print("continue lower")
            
        }else if upperThumbLayer.highlighted{
            upperValue += delvaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue, upperValue: maximunValue)
            print("continue upper")
        }
        //update the UI
        sendActionsForControlEvents(.ValueChanged)
        return true
    }
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
}
