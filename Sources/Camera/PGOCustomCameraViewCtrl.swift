//
//  PGOCustomCameraViewCtrl.swift
//  ZLPhotoBrowser
//
//  Created by alnk on 2024/8/2.
//

import Foundation

final class PGOCustomCameraViewCtrl: ZLCustomCamera {

    private var countTimer: Timer?
    private var count: Int = 0
    
    public lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .zl.font(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .zl.rgba(246, 73, 63)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
    }
    
    private func startCount() {
        cleanTimer()
        countTimer = Timer.scheduledTimer(timeInterval: 1, target: ZLWeakProxy(target: self), selector: #selector(updateCount), userInfo: nil, repeats: true)
        RunLoop.current.add(countTimer!, forMode: .common)
    }
    
    private func cleanTimer() {
        if countTimer != nil {
            countTimer?.invalidate()
            countTimer = nil
        }
    }
    
    @objc private func updateCount() {
        count += 1
        timeLabel.text = "\(count)"
    }
    
    override func startRecordTime() {
        count = 0
        startCount()
    }
    
    override func finishRecordTime() {
        cleanTimer()
    }
    
    override func retakeRecordTime() {
        count = 0
        cleanTimer()
    }
    
    deinit {
        cleanTimer()
        zl_debugPrint("PGOCustomCameraViewCtrl deinit")
    }
}
