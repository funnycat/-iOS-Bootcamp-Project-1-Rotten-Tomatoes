//
//  alertView.swift
//  RottenTomatoes
//
//  Created by Emily M Yang on 9/18/15.
//  Copyright © 2015 Experiences Evolved. All rights reserved.
//

import UIKit

class alertView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertBackground: UIView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic        
       let nib = UINib(nibName: "alertView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
 //       NSBundle.mainBundle().loadNibNamed("alertView", owner: self, options: nil)
   //     self.addSubview(view)
        contentView.frame = bounds
        addSubview(contentView)
        
      
        
    }
    
    var caption: String? {
        get { return alertLabel?.text }
        set { alertLabel.text = newValue }
    }
        
    var bgColor: UIColor? {
        get { return alertBackground.backgroundColor}
        set { alertBackground.backgroundColor = newValue }
    }
    

}
