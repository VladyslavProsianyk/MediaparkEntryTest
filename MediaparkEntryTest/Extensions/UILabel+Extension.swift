//
//  UILabel+Extension.swift
//  MediaparkEntryTest
//
//  Created by Vladyslav Prosianyk on 30.06.2022.
//

import UIKit

extension UILabel {
    
    @objc var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.hasSuffix("Regular") == true {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
        
    }
    
    @objc var substituteFontNameSemiBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.hasSuffix("Semibold") == true {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
        
    }
    
    @objc var substituteFontNameLight : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.hasSuffix("Light") == true {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
        
    }
    
    
    @objc var substituteFontNameMedium : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.hasSuffix("Medium") == true {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
        
    }
    
    @objc var substituteFontNameDemiBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.hasSuffix("Bold") == true {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
}
