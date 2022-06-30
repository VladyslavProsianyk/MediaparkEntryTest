//
//  Button.swift
//  MediaparkEntryTest
//
//  Created by Vladyslav Prosianyk on 30.06.2022.
//

import UIKit

class BaseButton: UIButton {
    
    var titleText: String? {
        didSet {
            self.setTitle(self.titleText, for: .normal)
        }
    }
    
    var backColor: UIColor? {
        didSet {
            self.backgroundColor = self.backColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? self.backColor : .lightGray
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            self.setTitleColor(self.titleColor, for: .normal)
        }
    }
    
    var disableTextColor: UIColor? {
        didSet {
            self.setTitleColor(self.disableTextColor, for: .disabled)
        }
    }
    
    var cornerRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    var borderWidth: CGFloat? {
        didSet {
            self.layer.borderWidth = borderWidth ?? 0
        }
    }
    
    var borderColor: CGColor? {
        didSet {
            self.layer.borderColor = borderColor
        }
    }
    
    var actionHandler: (() -> (Void))?
    
    init(title: String? = nil, color: UIColor? = nil, titleColor: UIColor? = nil) {
        super.init(frame: .zero)
        self.titleText = title
        self.backColor = color
        self.titleColor = titleColor
        self.setup()
    }
    
    private func setup() {
        self.removeTarget(self, action: #selector(touchDown), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: .touchUpInside)
        self.setupStyle()
    }
    
    private func setupStyle() {
        self.setTitle(self.titleText, for: .normal)
        self.setTitleColor(self.titleColor, for: .normal)
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth ?? 0
        self.backgroundColor = backColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    @objc private func touchDown() {
        actionHandler?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isUserInteractionEnabled = false
            self.alpha = 0.5
            self.setTitle("", for: .normal)
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.color = .darkGray
            indicator.layer.shadowPath = UIBezierPath(roundedRect: indicator.bounds, cornerRadius: indicator.layer.cornerRadius).cgPath
            indicator.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            indicator.layer.shadowOpacity = 1
            indicator.layer.shadowRadius = 2.0
            indicator.layer.shadowColor = UIColor.white.cgColor
            indicator.style = .medium
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isUserInteractionEnabled = true
            self.alpha = 1.0
            self.setTitle(titleText, for: .normal)
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
}
