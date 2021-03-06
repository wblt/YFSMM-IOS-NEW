//
//  UIPlaceHolderTextView.swift
//  TestUITextView
//
//  Created by luo on 16/4/30.
//  Copyright © 2016年 luo. All rights reserved.
//

import UIKit


class PlaceHolderTextView: UITextView, UITextViewDelegate {
    
    var placeholder: String = ""
    var placeholderFont: UIFont!
    var placeholderColor: UIColor = UIColor(red: 199 / 255, green: 199 / 255, blue: 204 / 255, alpha: 1.0)
    var maxCharacters: Int = 0
    var showRemind: Bool = false
    var remindColor: UIColor = UIColor.red
    
    override var text: String! {
        didSet {
            if text.isEmpty {
                self.viewWithTag(999)?.alpha = 1
            }else{
                self.viewWithTag(999)?.alpha = 0
            }
        }
    }
    
    let duration: Double = 0.25
    fileprivate var _placeHolderLabel: UILabel?
    fileprivate var _remindLabel: UILabel?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        placeholderFont = self.font
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    func textChanged(_ notification: Notification) {
        if placeholder.isEmpty { return }
        
        UIView.animate(withDuration: duration, animations: {
            if self.text.lengthOfBytes(using: String.Encoding.utf8) == 0 {
                self.viewWithTag(999)?.alpha = 1
            } else {
                self.viewWithTag(999)?.alpha = 0
            }
        }) 
    }
    
    override func draw(_ rect: CGRect) {
        
        if placeholder.characters.count > 0 {
            if _placeHolderLabel == nil {
                _placeHolderLabel = UILabel(frame: CGRect(x: 5, y: 7, width: self.bounds.size.width-10, height: 0))
                _placeHolderLabel?.lineBreakMode = .byWordWrapping
                _placeHolderLabel?.numberOfLines = 0
                _placeHolderLabel?.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
                _placeHolderLabel?.textColor = placeholderColor
                _placeHolderLabel?.font = placeholderFont ?? self.font ?? UIFont.systemFont(ofSize: 14)
                _placeHolderLabel?.alpha = 0
                _placeHolderLabel?.tag = 999
                self.addSubview(_placeHolderLabel!)
            }
            
            _placeHolderLabel?.text = placeholder
            _placeHolderLabel?.sizeToFit()
            self.sendSubview(toBack: _placeHolderLabel!)
            
            if showRemind && maxCharacters > 0 {
                if _remindLabel == nil {
                    _remindLabel = UILabel(frame: CGRect(x: 5, y: self.bounds.size.height - 23, width: self.bounds.size.width - 10, height: 20))
                    _remindLabel?.lineBreakMode = .byWordWrapping
                    _remindLabel?.numberOfLines = 0
                    _remindLabel!.font = UIFont.systemFont(ofSize: self.font!.pointSize - 1)
                    _remindLabel?.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
                    _remindLabel?.textColor = remindColor
                    _remindLabel?.textAlignment = .right
                    _remindLabel?.tag = 998
                    self.addSubview(_remindLabel!)
                }
                _remindLabel?.text = "还可以输入\(maxCharacters)个字"
                self.sendSubview(toBack: _remindLabel!)
            }
        }
        
        if self.text.lengthOfBytes(using: String.Encoding.utf8) == 0 && self.placeholder.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            self.viewWithTag(999)?.alpha = 1
        }
        
        super.draw(rect)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if maxCharacters == 0 { return true }
        
        let newLength = (textView.text.characters.count - range.length) + text.characters.count
        
        if newLength <= maxCharacters {
            if let remindLabel = _remindLabel {
                remindLabel.text = "还可以输入\(maxCharacters - newLength)个字"
            }
            return true
        } else {
            if let remindLabel = _remindLabel {
                remindLabel.text = "已经超出最大字符！"
            }
            textView.text = textView.text.substringToIndex(maxCharacters)
            return false
        }
    }
    
    // MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
        LogManager.shared.log("PlaceHolderTextView deinit")
    }
}

// 解决Assertion failure in -[UITextView _firstBaselineOffsetFromTop], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit/UIKit-3512.60.12/UITextView.m:1683
extension UITextView {
    
    func _firstBaselineOffsetFromTop() {
        
    }
    
    func _baselineOffsetFromBottom() {
        
    }
}
