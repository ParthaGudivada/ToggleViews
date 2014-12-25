//
//  ToggleViewController.swift
//  ToggleViews
//
//  Created by Parthasarathy Gudivada on 12/25/14.
//  Copyright (c) 2014 LearnJava. All rights reserved.
//

import UIKit


enum validStates  : Int
{
    case viewInvisible = 0
    case viewVisible = 1
}

class ToggleViewController: UIViewController
{
    var verPosConst : NSArray?
    var toggleSwitch : UIButton?
    var viewState : Bool = false
    var viewsDict : Dictionary<String, UIView>?
    var metricsDict : Dictionary<String, CGFloat>?
    
    
   /*
    *  creates the label with specific set of values
    */
    private let crLabel =  { (lblValue : String , align : NSTextAlignment, baseView : UIView  ) -> UILabel in
        let lbl = UILabel()
        lbl.setTranslatesAutoresizingMaskIntoConstraints(false)
        lbl.textAlignment = align
        lbl.font = UIFont(name: "Verdana", size: 15.0)
        lbl.text = lblValue
        lbl.textColor = UIColor.blackColor()
        lbl.backgroundColor = UIColor.lightGrayColor()
        baseView.addSubview(lbl)
        return lbl
    }
    
   /*
    *  creates the button with specific set of values
    */
    private let crButton = { (btnValue : String, baseView : UIView) -> UIButton in
        let btn = UIButton.buttonWithType(UIButtonType.Custom ) as UIButton
        btn.setTranslatesAutoresizingMaskIntoConstraints(false)
        btn.setTitle(btnValue, forState: .Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        baseView.addSubview(btn)
        return btn
    }


    /*
      *  adds 3 labels of varying heights and a button to hide/unhide the middle label
      *
      */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let lbl1 = crLabel("Label1", .Center, view)
        let lbl2 = crLabel("Label2", .Center, view)
        let lbl3 = crLabel("Label3", .Center, view)
        toggleSwitch = crButton("Hide Label2", view)
        
        viewsDict = ["lbl1" : lbl1, "lbl2" : lbl2, "lbl3" : lbl3, "toggleSwitch" : toggleSwitch!]
        metricsDict = ["ht1" : 50.0, "ht2" : 75.0, "ht3" : 100.0, "vs" : 40.0, "width" : 150.0]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[lbl1]-|", options: .allZeros, metrics: metricsDict!, views: viewsDict!))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[lbl2]-|", options: .allZeros, metrics: metricsDict!, views: viewsDict!))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[lbl3]-|", options: .allZeros, metrics: metricsDict!, views: viewsDict!))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[toggleSwitch]-20-|", options: .allZeros, metrics: metricsDict!, views: viewsDict!))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[toggleSwitch(==width)]", options: .allZeros, metrics: metricsDict!, views: viewsDict!))
        toggleSwitch!.addTarget(self, action: "toggleViews:", forControlEvents: UIControlEvents.TouchUpInside)
        toggleViews(toggleSwitch!)
        
           // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /*
      *  Tapping the button hides/unhides the label named "Label2".
      *
      *
      */
    func toggleViews(sender : UIButton)
    {
        viewState = !viewState
        
        if let const = verPosConst {
            view.removeConstraints(verPosConst!)
        }
        
        if ( viewState )
        {
            verPosConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-vs-[lbl1(==ht1)]-[lbl2(==ht2)]-[lbl3(==ht3)]",
                options: .allZeros,
                metrics: metricsDict!,
                views: viewsDict!)
            sender.setTitle("Hide Label2", forState: .Normal)
        }
        else
        {
            verPosConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-vs-[lbl1(==ht1)]-[lbl2(==0)][lbl3(==ht3)]",
                options: .allZeros,
                metrics: metricsDict!,
                views: viewsDict!)
            sender.setTitle("UnHide Label2", forState: .Normal)
        }
        
        view.addConstraints(verPosConst!)
        view.layoutIfNeeded()
        
    }


}
