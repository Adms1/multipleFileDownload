//
//  ViewController.swift
//  multipleFileDownload
//
//  Created by ADMS on 04/10/21.
//

import UIKit

class AddTwoNumber {

    private var a:Int = 10
    private var b:Int = 20
    //var c:Int

//    init(a:Int,b:Int) {
//        self.a = a
//        self.b = b
//    }

    func addition()->Int
    {
        return a + b
    }

}
extension AddTwoNumber{

    func print()  {
        a = 20
        b = 30
        debugPrint(a)
        debugPrint(b)

    }

}



struct Example: Decodable {
    var userID: Int
        var ID: Int
        var title: String
        var completed: Bool

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case ID = "id"
            case title = "title"
            case completed = "completed"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            userID = try values.decode(Int.self, forKey: .userID)
            ID = try values.decode(Int.self, forKey: .ID)
            title = try values.decode(String.self, forKey: .title)
            completed = try values.decode(Bool.self, forKey: .completed)
            title = "Title: \(title)"
        }
}


class ViewController: UIViewController {


    @IBOutlet weak var tblImageList:UITableView!
    let downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "download image queue"
        return queue
    }()

    var arrOpration = [String]()
    
    let imageUrls = [
                        "https://images.dog.ceo//breeds//schnauzer-miniature//n02097047_1921.jpg",
                        "https://images.dog.ceo//breeds//bluetick//n02088632_403.jpg",
                        "https://images.dog.ceo//breeds//hound-plott//hhh-23456.jpeg",
                        "https://images.dog.ceo//breeds//terrier-patterdale//320px-05078045_Patterdale_Terrier.jpg",
                        "https://images.dog.ceo//breeds//terrier-norfolk//n02094114_1490.jpg",
                        "https://images.dog.ceo//breeds//havanese//00100trPORTRAIT_00100_BURST20191103202017556_COVER.jpg"
                    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        let addNum = AddTwoNumber()
        let result1 = addNum.addition
        print(addNum.addition())


        let dispetchGroup = DispatchGroup()

//        blockOperation.addExecutionBlock {
        dispetchGroup.enter()
        print("first api call")
        let lock = NSLock()

        lock.lock()
            self.Apicall(urlRequest: "https://jsonplaceholder.typicode.com/todos/1") { (data, error) in
                guard error == nil else {
                            return
                        }

                        guard let data = data else {
                            return
                        }


                do {
                                    let json: Example = try JSONDecoder().decode(Example.self, from: data)
                    print("first api",json.title)
                    lock.unlock()
                                                    dispetchGroup.leave()

                                }catch let error {
                                    print(error.localizedDescription)
                                }



//                        do {
//                            //create json object from data
//                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                                print("first api",json["title"])
//                                print("first api calling done")
//                                dispetchGroup.leave()
//
//
//                            }
//                        } catch let error {
//                            print(error.localizedDescription)
//                        }
            }


        dispetchGroup.enter()
        lock.lock()
        print("second api call")
            self.Apicall(urlRequest: "https://jsonplaceholder.typicode.com/todos/1") { (data, error) in
                guard error == nil else {
                            return
                        }

                        guard let data = data else {
                            return
                        }
                let decoder = JSONDecoder()
                               if let json: Example = try? decoder.decode(Example.self, from: data) {
//                                   completion(json)
                                print("second api",json.title)
                                lock.unlock()
                                                               dispetchGroup.leave()

                               }
//                        do {
//                            //create json object from data
//                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                                print("second api",json["title"])
//                                print("second api calling done")
//                                lock.unlock()
//                                dispetchGroup.leave()
//
//                            }
//                        } catch let error {
//                            print(error.localizedDescription)
//                        }
            }

        dispetchGroup.notify(queue: .main) {
                // whatever you want to do when both are done
            print("both api call done")

            }
      //  }


//        blockOperation.addExecutionBlock {
//            self.Apicall()
//        }


//        let oprationQueue = OperationQueue()
//
//        oprationQueue.addOperation(blockOperation)

      //  let dispetchGroup = DispatchGroup()

     //   dispetchGroup.enter()




//        for (index,_) in imageUrls.enumerated(){
//            arrOpration.append("opration\(index)")
//        }

    }

    func Apicall(urlRequest:String,withCompletionHandler:@escaping(_ data:Data?,_ error: Error?)->Void)
    {
       // let urlRequest = "http://srpl.admssvc.com/GetVehicleType"

       // let dispetchGroup = DispatchGroup()

        let url = URL(string: urlRequest)!
        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        let parameters: [String: Any] = ["LanguageID":"1"]
////        request.httpBody = parameters
//        do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//            } catch let error {
//                print(error.localizedDescription)
//            }


        let session = URLSession.shared


       // dispetchGroup.enter()

        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in

         //   dispetchGroup.leave()


//            dispetchGroup.leave()

            guard error == nil else {
                withCompletionHandler(nil, error)
                return

            }


            guard let data = data else {
                return
            }
            withCompletionHandler(data, nil)
//            lock.unlock()

        })
        task.resume()

    }


    @objc func btnClickDownload(_ sender:UIButton)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tblImageList)
        let indexPath = self.tblImageList.indexPathForRow(at:buttonPosition)
        let cell = self.tblImageList.cellForRow(at: indexPath!) as! TableViewCell


        print(imageUrls[indexPath!.row])

        apiServiceDownloadImage(url: imageUrls[indexPath!.row]) { (image, err) in
            if let err = err {
                print("failed to download image with error: ", err)
                return
            }
            DispatchQueue.main.async {
                print("update UI with image size:", image?.size ?? 0)
                let image = UIImage(data: (image?.pngData())!)
//                let imageView = UIImageView(image: image!)

                cell.img.image = image
                self.tblImageList.reloadData()
            }
        }

    }
    @IBAction func btnClickDownloadPause(_ sender:UIButton)
    {
      //  http://srpl.admssvc.com/GetVehicleType

    }
    @objc func btnClickCancel(_ sender:UIButton)
    {
        print(imageUrls[sender.tag])
        downloadQueue.cancelAllOperations()
      //  DownloadTaskOperation.cancel(downloadQueue)
    }
    func apiServiceDownloadImage(url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        let operation = DownloadTaskOperation(url: url, completion: completion)
        downloadQueue.addOperation(operation)
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return imageUrls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.btnCancel.tag = indexPath.row
        cell.btnDownload.tag = indexPath.row
        cell.btnCancel.addTarget(self, action: #selector(btnClickCancel), for: .touchUpInside)
        cell.btnDownload.addTarget(self, action: #selector(btnClickDownload), for: .touchUpInside)
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }


}
