//
//  DownloadManager.swift
//  multipleFileDownload
//
//  Created by ADMS on 04/10/21.
//

import Foundation
import UIKit





class DownloadTaskOperation: Operation {
    private var task : URLSessionDataTask!

    //1.
    enum OperationState : Int {
        case isReady
        case isExecuting
        case isFinished
    }

    //2.
    private var state : OperationState = .isReady {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }

        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }

    //3.
    override var isReady: Bool { return state == .isReady }
    override var isExecuting: Bool { return state == .isExecuting }
    override var isFinished: Bool { return state == .isFinished }

    //4.
    init(url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        super.init()
        guard let url = URL(string: url) else { return }
        sleep(2)
        task = URLSession.shared.dataTask(with: url, completionHandler: {  [weak self] (data, resp, err) in
            //6.
            if (self?.isCancelled == true) {
                print("Don't have to update UI")
                self?.state = .isFinished
                return
            }

            if let err = err {
                completion(nil, err)
                self?.state = .isFinished
                return
            }

            if let imageData = data {
                completion(UIImage(data: imageData), nil)
            } else {
                completion(nil, NSError(domain: "download task operation", code: 0, userInfo: ["message": "invalid image data"]))
            }
            self?.state = .isFinished
        })
    }

    //5.
    override func main() {
        print("begin download task")
        if (self.isCancelled) {
            print("Task is cancelled before executed")
            state = .isFinished
            return
        }

        state = .isExecuting
        self.task.resume()
    }

    //7.
    override func cancel() {
        super.cancel()

        if (state == .isExecuting) {
            task.cancel()
        }
    }

}
