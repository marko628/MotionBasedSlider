//
//  ViewController.swift
//  Motion-Based Slider Demo
//
//  Created by Mark on 3/24/15.

// 1.:
import UIKit
import CoreMotion

class ViewController: UIViewController {

    // 2.:
    @IBOutlet weak var labelRollValue: UILabel!
    @IBOutlet weak var sliderTiltMe: UISlider!
    
    
    // 3.:
    let myManager = CMMotionManager()

    // 4.:
    func RadiansToDegrees(rad: Double) -> Double {
        return rad * 180/M_PI}
    
    // 5.:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 6.:
        if myManager.deviceMotionAvailable {
            
            // 7.:
            println(myManager.deviceMotionUpdateInterval)
            myManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                (data: CMDeviceMotion!, error: NSError!) in
                
                // 8.:
                var degreesRoll: Double! =
                    self.RadiansToDegrees(data.attitude.roll)
                var rollLabel: String! = degreesRoll.description
                
                // 9.:
                self.labelRollValue.text =
                    rollLabel.substringToIndex(advance(rollLabel.startIndex, 5))
                
                // 10.:
                if degreesRoll <= -10.0 {
                    self.sliderTiltMe.value -= 0.5
                } else if degreesRoll >= 10.0 {
                    self.sliderTiltMe.value += 0.5
                }
            }
        } else {
            println("device motion not available")
        }

        
    }
    
}

                                