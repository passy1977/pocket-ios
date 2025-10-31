/***************************************************************************
 *
 * Pocket
 * Copyright (C) 2018/2025 Antonio Salsi <passy.linux@zresa.it>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/

import Foundation
import CoreMotion

final class Timeout4Logout {
    
    public typealias Callback = () -> Void
    
    static public let shared = Timeout4Logout()
    
    
    
    private let motionManager = CMMotionManager()
    var magnitude : Double = 0.0
    
    private let k = 1.3
   
    private var timerAccelerometer = Timer()
    
    private var timerReady : Bool = false
    private var timerRunning : Bool = false
    private var timer = Timer()
    

    
    var _callback : Callback = {}
    var callback : Callback = {} {
        didSet {
            _callback = callback
            timerReady = true
        }
    }
    
    init() {
        motionManager.startAccelerometerUpdates()
        
        timerAccelerometer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if let data = self.motionManager.accelerometerData {
                self.magnitude = sqrt(pow(data.acceleration.x, 2) + pow(data.acceleration.y, 2) + pow(data.acceleration.z, 2))
            }
        }
        RunLoop.current.add(timerAccelerometer, forMode: RunLoop.Mode.common)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: timerCallback)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }

    
    public func start() {
        timerRunning = true
        timer.fire()
    }
    
    
    @inlinable
    public func stop() {
        if !timerReady {
            return
        }
        timer.invalidate()
        timerRunning = false
    }
    
    @inlinable
    public func updateTimeLeft() {
        if !timerReady {
            return
        }
        UserDefaults.standard.set(sessionTimeoutInSeconds, forKey: "timeout4logout")
    }
    
    @inlinable
    public func isStarted() -> Bool {
        return timerRunning;
    }

    private func timerCallback(_ timer: Timer) {
        if !timerReady {
            return
        }
        
        var timerTimeout = 0;
        if magnitude > k  {
            UserDefaults.standard.set(sessionTimeoutInSeconds, forKey: "timeout4logout")
            timerTimeout = sessionTimeoutInSeconds
        } else {
            timerTimeout = UserDefaults.standard.integer(forKey: "timeout4logout")
        }
        
        print(timerTimeout)
        timerTimeout -= 1
        if timerTimeout <= 0 {
            timer.invalidate()
            _callback()
            UserDefaults.standard.set(0, forKey: "timeout4logout")
        } else {
            UserDefaults.standard.set(timerTimeout, forKey: "timeout4logout")
        }
    }
}
    
