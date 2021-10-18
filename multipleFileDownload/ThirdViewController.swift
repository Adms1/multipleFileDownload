//
//  ThirdViewController.swift
//  multipleFileDownload
//
//  Created by ADMS on 18/10/21.
//

import UIKit

typealias dataSendToOtherPlace = ((String) -> Void)


class ThirdViewController: MsterViewController {

    @IBOutlet var btnBack:UIButton!

    @IBOutlet var txtData:UITextField!

//    public var selectionAction: SelectionClosure?



    var sendDataToOtherVC :dataSendToOtherPlace?

    override func viewDidLoad() {
        super.viewDidLoad()
        checking()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBackButton(_ sender:UIButton){
        sendDataToOtherVC!(txtData.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MsterViewController
{
    func checking() {
        debugPrint(pvtName)
        debugPrint(fileLastName)
    }
}
