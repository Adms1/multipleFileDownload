//
//  MsterViewController.swift
//  multipleFileDownload
//
//  Created by ADMS on 14/10/21.
//

import UIKit
import DropDown

class MsterViewController: UIViewController {

     var pvtName:Int = 0
     var fileLastName:Int = 0

    public var rightBarDropDown = DropDown()

    public var alertController:UIAlertController = UIAlertController()
    public var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //        check()
        // setActivityIndicator()

//        print(pvtName)
//        print(fileLastName)

    }

    public func setActivityIndicator()  {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2-25, y: self.view.frame.height/2-25, width: 50, height: 50))
        activityIndicator.style = .large
        activityIndicator.color = .systemGreen
        self.view.addSubview(activityIndicator)
    }

    public func customAlertController(message:String)  {
        alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        //        self.view.addSubview(alertController.view)
    }

    public func startActivityIndicator()  {
        activityIndicator.startAnimating()
    }
    public func stopActivityIndicator()  {
        activityIndicator.stopAnimating()
    }

    public func openDropDownList(customButton:UIButton)
    {
        rightBarDropDown.backgroundColor = .white
//        let frame2 = self.view.convert(customButton.frame, to: view)
//
//        let view = UIView()
//        view.frame = CGRect(x: frame2.origin.x, y: frame2.origin.y + frame2.height, width: frame2.width, height: frame2.height*2)
        rightBarDropDown.anchorView =   customButton
        print("anchoreView frame",view.frame)
        rightBarDropDown.dataSource = ["Car", "Motorcycle", "Truck","Car", "Motorcycle", "Truck"]
//        print("drop down height",2 * customButton.frame.height)
//        rightBarDropDown.anchorView = 2 * customButton.frame.height
        rightBarDropDown.cellConfiguration = { (index, item) in return "\(item)" }
    }

}

extension MsterViewController{


    func check()  {
        pvtName = 20
        fileLastName = 20

        debugPrint(pvtName)
        debugPrint(fileLastName)
    }

}
