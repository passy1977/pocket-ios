//
//  LogoutTimer.swift
//  Pocket
//
//  Created by Antonio Salsi on 17/04/2020.
//  Copyright © 2020 Scapix. All rights reserved.
//

import Foundation
import CoreMotion

final class Timeout4Logout {
    
    static private var shared : Timeout4Logout? = nil
    
    private var timerAccelerometer = Timer()
    
    private let motionManager = CMMotionManager()
    
    private let k = 0.3
    
    var callback : ()->Void = {} {
        didSet {
            countDown.setCallback {
                DispatchQueue.main.async {
                    self.callback()
                }
            }
        }
    }
    
    private let countDown : CountDown

    init(_ user : User) {
        motionManager.startAccelerometerUpdates()
        
        
#if ENABLE_SERVER_DEBUG
        countDown = CountDown(user: user, sessionTimeoutInSeconds: Int16(sessionTimeoutInSecondsDebug))
#else
        countDown = CountDown(user: user, sessionTimeoutInSeconds: Int16(sessionTimeoutInSeconds))
#endif
    }
    
    public func start() {
        countDown.start()
        
        timerAccelerometer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
            if let data = self.motionManager.accelerometerData {
                if data.acceleration.x > self.k || data.acceleration.y > self.k || data.acceleration.z > self.k {
                    self.countDown.updateTimeLeft()
                }
            }
        }
        RunLoop.current.add(timerAccelerometer, forMode: RunLoop.Mode.common)
    }
    
    @inlinable
    public func resume() {
        countDown.start()
    }
    
    @inlinable
    public func stop() {
        self.countDown.stop()
        self.timerAccelerometer.invalidate()
    }
    
    @inlinable
    public func updateTimeLeft() {
        countDown.updateTimeLeft()
    }
    
    @inlinable
    public func isStarted() -> Bool {
        countDown.isStarted()
    }
    
    static public func getShared(user: User?) -> Timeout4Logout {
        if let user = user {
            Timeout4Logout.shared = Timeout4Logout(user);
        }
        return Timeout4Logout.shared!
    }
    
    static public func getShared() -> Timeout4Logout {
        return Timeout4Logout.shared!
    }
}
