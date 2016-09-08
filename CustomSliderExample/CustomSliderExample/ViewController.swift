//
//  ViewController.swift
//  CustomSliderExample
//
//  Created by shendong on 16/9/8.
//  Copyright © 2016年 shendong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let rangeSlider = RangeSlider(frame: CGRectZero)
    
    @IBOutlet weak var localRangeSlider: RangeSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(rangeSlider)
        rangeSlider.addTarget(self, action: #selector(ViewController.rangeSliderValueChanged(_:)), forControlEvents: .ValueChanged)
        
        let time = dispatch_time(DISPATCH_TIME_NOW, 2)
        dispatch_after(time, dispatch_get_main_queue()) { 
            self.rangeSlider.trackHighlightTintColor = UIColor.redColor()
            self.rangeSlider.curvaceousness = 0.3
            self.rangeSlider.lowerValue = 0.5
            self.rangeSlider.upperValue = 0.9
            self.rangeSlider.thumbTintColor = UIColor.blueColor()
            
        }
        
//        UISlider
        print("sss \(localRangeSlider.lowerValue), \(localRangeSlider.upperValue)")

        
    }
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        print(topLayoutGuide.length)
        print(bottomLayoutGuide)
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length, width: width, height: 32.0)
        
    }
    func rangeSliderValueChanged(rangeSlider: RangeSlider){
        print("RangeSlider value changed : \(rangeSlider.lowerValue), \(rangeSlider.upperValue)")
    }

}

