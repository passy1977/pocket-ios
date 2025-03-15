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
    
    private var timerAccelerometer = Timer()
    
    private let motionManager = CMMotionManager()
    private var motionManagerSamplingCursor = 0
    private let motionManagerSamplingMax = 100
    private var motionManagerX : [Double]
    private var motionManagerY : [Double]
    private var motionManagerZ : [Double]
    
    private let k = 0.3
   
    private var timerReady : Bool = false
    private var timerRunning : Bool = false
    private var timer : Timer?
    
    var _callback : Callback = {}
    var callback : Callback = {} {
        didSet {
            _callback = callback
            timerReady = true
        }
    }
    
    init() {
        motionManager.startAccelerometerUpdates()
        motionManagerX = [Double](repeating: 0, count: motionManagerSamplingMax)
        motionManagerY = [Double](repeating: 0, count: motionManagerSamplingMax)
        motionManagerZ = [Double](repeating: 0, count: motionManagerSamplingMax)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: timerCallback)
        
    }

    
    public func start() {
        timerRunning = true
        
        timerAccelerometer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if let data = self.motionManager.accelerometerData {
                
                if self.motionManagerX.count >= self.motionManagerSamplingMax {
                    self.motionManagerSamplingCursor = 0
                }
                self.motionManagerX[self.motionManagerSamplingCursor] = data.acceleration.x
                self.motionManagerY[self.motionManagerSamplingCursor] = data.acceleration.y
                self.motionManagerZ[self.motionManagerSamplingCursor] = data.acceleration.z
                
                self.motionManagerSamplingCursor += 1
            }
        }
        RunLoop.current.add(timerAccelerometer, forMode: RunLoop.Mode.common)
        
        timer?.fire()
    }
    
    
    @inlinable
    public func stop() {
        if !timerReady {
            return
        }
        timer?.invalidate()
        timerAccelerometer.invalidate()
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
        if motionManagerX.reduce(0, { $0 + $1 }) > k  {
            UserDefaults.standard.set(sessionTimeoutInSeconds, forKey: "timeout4logout")
            timerTimeout = sessionTimeoutInSeconds
        } else {
            timerTimeout = UserDefaults.standard.integer(forKey: "timeout4logout")
        }
        
        if motionManagerY.reduce(0, { $0 + $1 }) > k  {
            UserDefaults.standard.set(sessionTimeoutInSeconds, forKey: "timeout4logout")
            timerTimeout = sessionTimeoutInSeconds
        } else {
            timerTimeout = UserDefaults.standard.integer(forKey: "timeout4logout")
        }
        
        if motionManagerZ.reduce(0, { $0 + $1 }) > k  {
            UserDefaults.standard.set(sessionTimeoutInSeconds, forKey: "timeout4logout")
            timerTimeout = sessionTimeoutInSeconds
        } else {
            timerTimeout = UserDefaults.standard.integer(forKey: "timeout4logout")
        }
        
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
    
