//
//  SecondViewController.swift
//  multipleFileDownload
//
//  Created by ADMS on 14/10/21.
//

import UIKit


class IOS {

    class var iosStoredTypeProperty:String
  {

    return "iOS Developer"
  }

  static var swiftStoredTypeProperty = "Swift Developer"

    static func myMethod1() {

        }
        class func myMethod2() ->String{
            return ""
        }

 }

class IOS1:IOS {

    override class func myMethod2() ->String{
            return ""
        }

 }





class SecondViewController: MsterViewController {

    @IBOutlet var btnVehicle:UIButton!
    @IBOutlet var lblDalagate:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(pvtName)
//        print(fileLastName)

        btnVehicle.layer.borderWidth = 0.5
        btnVehicle.layer.borderColor = UIColor.systemBlue.cgColor

        print("btnVehicle frame",btnVehicle.frame)

        btnVehicle.setTitle("--select--", for: .normal)
        setActivityIndicator()
        openDropDownList(customButton: btnVehicle)


//let obj = IOS()


        print("static var",IOS.swiftStoredTypeProperty)

        print("var",IOS.iosStoredTypeProperty)

        print("var",IOS.iosStoredTypeProperty)

        IOS.swiftStoredTypeProperty = "static jkhkjhjkhkjhkjhkj"

        print("static var",IOS.swiftStoredTypeProperty)

//        print("class func",obj.me())


    }

    @IBAction func startActivity(_ sender:UIButton){
        startActivityIndicator()

        print(API.isLoginApi)
    }

    @IBAction func customAlertController(_ sender:UIButton){
        customAlertController(message: "jhfjksdfhjdshfjkhsdkjfhjkdsh")
    }

    @IBAction func stopActivity(_ sender:UIButton){
        stopActivityIndicator()

        print(ValidationMessage.Error_Email)
    }
    @IBAction func showBarButtonDropDown(_ sender: UIButton) {

          rightBarDropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnVehicle.setTitle(item, for: .normal)
//            print("rightBarDropDown cellheight: \(item) at index: \(index)")

          }
//        rightBarDropDown.cellHeight = 2 * sender.frame.height
        rightBarDropDown.width = sender.frame.width
          rightBarDropDown.bottomOffset = CGPoint(x: 0, y:(rightBarDropDown.anchorView?.plainView.bounds.height)!)
          rightBarDropDown.show()

        //((rightBarDropDown.anchorView?.plainView.bounds.height)! - 1 * sender.frame.height)
       }
    @IBAction func otherVC(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        vc.sendDataToOtherVC = {
            dataTotherScreen in
            self.lblDalagate.text = dataTotherScreen
        }
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
