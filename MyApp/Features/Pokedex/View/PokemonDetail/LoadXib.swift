//
//  LoadXib.swift
//  MyApp
//
//  Created by Lorusso, Michele on 28/11/24.
//

import UIKit

extension UIView{
    func viewInit(){
        let bundle = Bundle(for: type(of: self))
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Failed to load nib for view \(className).")
        }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}
