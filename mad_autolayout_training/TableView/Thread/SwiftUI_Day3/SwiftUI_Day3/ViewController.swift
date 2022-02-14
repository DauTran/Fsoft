//
//  ViewController.swift
//  SwiftUI_Day3
//
//  Created by DauTT1 on 1/7/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageVC: UIImageView!
    @IBOutlet weak var imageByOperationQueue: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loadImage(_ sender: Any) {
        
    let url = URL(string:"https://wallpapers-fenix.eu/full/211221/105131534.jpg")
    
        let queue = DispatchQueue(label: "queue")
        queue.async {
            do{
                let data = try Data(contentsOf: url!)
//                DispatchQueue.main.async {
                    self.imageVC.image = UIImage(data: data)
                    
//                }
            }catch{
                print("\(#line) Didn't catch that!");
            }
        }
        
    }
    
    func testGrandCenterDispatchqueue() {
        
        let queue = DispatchQueue(label: "queue1")
        let group = DispatchGroup()
        
        group.enter();
        queue.async {
            for i in 0...1000000
            {
                print("i: \(i)");
            }
            group.leave();
        }
        
        let rr = group.wait(timeout: DispatchTime.now() + 3);
        print("          ", rr == DispatchTimeoutResult.success)
        
        
//        let queue2 = DispatchQueue(label: "queue2")
//        queue2.async {
////            var j : Character = " ";
//            for j in 0...1000
//            {
//                print("j   : \(j)");
//            }
//        }
//
//        for j in 0...1000
//        {
//            print("k   : \(j)");
//        }
        

    }
    
    func statesOperationQueue(_ ourOperation : BlockOperation)
    {
        print("\n ready state", ourOperation.isReady)
        print("cancel state", ourOperation.isCancelled)
        print("exercute state", ourOperation.isExecuting)
    }
    
    @IBAction func runBlockOperation(_ sender: Any) {
        let ourOperation = BlockOperation()
        statesOperationQueue(ourOperation)
        
        
        ourOperation.completionBlock =    {
                print("Finish on Thread \(Thread.current)")
        }
        
        ourOperation.addExecutionBlock {
            for i in 0...1000
            {
                print("function name \(#function) i \(i)");
                self.statesOperationQueue(ourOperation)
            }
        }
        
        ourOperation.addExecutionBlock {
            for j in 0...1000
            {
                print("j: \(j)")
                self.statesOperationQueue(ourOperation)
            }
        }
        
//        ourOperation.start();
        
//        DispatchQueue.global(qos: .background).async {
//            print("Running on Thread \(Thread.current)")
//            ourOperation.start();
//        }
//
//        print("This will called now \(Thread.current) \(Thread.isMainThread)")

        
        let thread = Thread(block: {ourOperation.start()})
        thread.start();
        
    }
    
    @IBAction func runOperationQueue(_ sender: Any) {
        let operationQueue = OperationQueue()
        
        let blockOperation1 = BlockOperation
        {
            for i in 0...100
            {
                print("function name \(#function) i \(i)");
                print(Thread.isMainThread, Thread.current);
//                print(Thread.)
            }
        }
        
        let blockOperation2 = BlockOperation()
        {
            for i in 0...100
            {
                print("j \(i)");
                print(Thread.isMainThread, Thread.current);
            }
        }
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
    }
}

