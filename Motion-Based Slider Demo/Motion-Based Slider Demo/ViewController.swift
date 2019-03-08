//
//  ViewController.swift
//  Motion-Based Slider Demo
//
//  Created by Mark on 3/24/15.
//  Updated by Mark on 10/16/18

// 1.: required frameworks
import UIKit
import CoreMotion

class ViewController: UIViewController {

  // 2.: outlets to display the tilt
  @IBOutlet weak var rollValue: UILabel!
  @IBOutlet weak var slider: UISlider!
  
  // 3.: start with a Motion Manager object
  let motionManager = CMMotionManager()

  // 4.: helper function to covert radians to degress
  func radiansToDegrees(rad: Double) -> Double {
    return rad * 180 / .pi
  }
    
  // 5.: it all happens in viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 6.: stop if device doesn't detect motion (e.g. the simulator)
    if motionManager.isDeviceMotionAvailable {
      
      // 7.: closure handles updates to the outlets
      print(motionManager.deviceMotionUpdateInterval)
      motionManager.startDeviceMotionUpdates(to: OperationQueue.main) {
        (data, error) in
        
        // 8.: show degrees in the outlets
        let degreesRoll: Double! = self.radiansToDegrees(rad: data!.attitude.roll)
        let rollLabel: String! = degreesRoll.description
        
        // 9.: update the roll value label with the degrees
        self.rollValue.text = rollLabel
        
        // 10.: tilt the slider if device tilted more that 10 degrees
        if degreesRoll <= -10.0 {
          self.slider.value -= 0.5
        } else if degreesRoll >= 10.0 {
          self.slider.value += 0.5
        }
      }
    } else {
      print("device motion not available")
      }
  }
    
}
