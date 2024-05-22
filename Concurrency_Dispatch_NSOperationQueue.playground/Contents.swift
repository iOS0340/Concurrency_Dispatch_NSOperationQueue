//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

/*let global1 = DispatchQueue.global()
let global2 = DispatchQueue.global()
let global3 = DispatchQueue.global()

print("Reference of Global 1 Queue: \(Unmanaged.passUnretained(global1).toOpaque())")
print("Reference of Global 2 Queue: \(Unmanaged.passUnretained(global2).toOpaque())")
print("Reference of Global 3 Queue: \(Unmanaged.passUnretained(global3).toOpaque())")

let customQueue1 = DispatchQueue(label: "Con1", attributes: [.concurrent])
let customQueue2 = DispatchQueue(label: "Con2", attributes: [.concurrent])
let customQueue3 = DispatchQueue(label: "Con3", attributes: [.concurrent])
let customQueue4 = DispatchQueue(label: "Con4", attributes: [.concurrent])

print("Reference of Custom Queue 1: \(Unmanaged.passUnretained(customQueue1).toOpaque())")
print("Reference of Custom Queue 2: \(Unmanaged.passUnretained(customQueue2).toOpaque())")
print("Reference of Custom Queue 3: \(Unmanaged.passUnretained(customQueue3).toOpaque())")
print("Reference of Custom Queue 4: \(Unmanaged.passUnretained(customQueue4).toOpaque())")

let global4 = DispatchQueue.global()
print("Reference of Global 4 Queue: \(Unmanaged.passUnretained(global4).toOpaque())")*/

/**
 Below Code shows the total execution time of sync and async Queues.
 when the queues are async then print statement execute immediately else it will wait for all the sync tasks to complete.
 */

let startTime = CFAbsoluteTimeGetCurrent()

/*DispatchQueue.global().async {
    for i in 0 ..< 7000 {
        print("Async : \(i)")
    }
}

global2.async {
    for i in 0 ..< 7000 {
        print("Async 2 : \(i)")
    }
}

print("Time Duration to Execute: \(CFAbsoluteTimeGetCurrent() - startTime)")*/

/**
    Below block of code shows Serial Queue execution.
 */


/*let queue = DispatchQueue(label: "SerialQueue")

queue.async {
    for i in 0 ..< 10 {
        print("Queue 1: \(i)")
    }
}

queue.async {
    for i in 0 ..< 10 {
        print("Queue 2: \(i)")
    }
}

print("Total Execution duration: \(CFAbsoluteTimeGetCurrent() - startTime)")*/

/**
 Dispatch Group with Wait method. If we have scenario in which we have to wait for first two task to complete and depend on their result we have to do our next course of action then we can use this Dispatch group with wait. But when we use wait we have to make sure that it will not called on main thread else main thread will be blocked.
 */

/*let queue = DispatchQueue(label: "dispatchGroup", attributes: [.concurrent])

let group = DispatchGroup()
group.enter()
queue.async(execute: {
    for i in 0 ..< 100 {
        print("Value of i - 1  : \(i)")
    }
    group.leave()
})
group.wait()
group.enter()
queue.async(execute: {
    for i in 0 ..< 100 {
        print("Value of i - 2  : \(i)")
    }
    group.leave()
})

queue.async {
    group.wait()
    print("Last Statement Executed")
}
*/

/**
    Below I use Dispatch group with notify method. The group will be notify when all the tasks executed and you can go further with your logic.
 */

/*let queue = DispatchQueue(label: "dispatchGroup", attributes: [.concurrent])
let group = DispatchGroup()

queue.async(group: group, execute: {
    for i in  0 ..< 100 {
        print("Value of i - 1: \(i)")
    }
})

queue.async(group: group, execute: {
    for i in  0 ..< 100 {
        print("Value of i - 2: \(i)")
    }
})

group.notify(queue: queue) {
    print("All group task has been done")
}

queue.async(group: group, execute: {
    for i in  0 ..< 100 {
        print("Value of i - 3: \(i)")
    }
})*/

/**
    Below block of code show the implementation of Concurrent Dispatch Queue with Barrier Flag which block the execution untill previous tasks complete.
 */

/*
let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: [.concurrent])

concurrentQueue.async {
    for i in 0 ..< 700 {
        print("First Queue : \(i)")
    }
}

concurrentQueue.async {
    for i in 0 ..< 700 {
        print("Second Queue : \(i)")
    }
}

concurrentQueue.async(flags: .barrier) {
       for i in 0 ..< 700 {
           print("Barrier Queue : \(i)")
       }
   }

concurrentQueue.async {
    print("Last Block of Code")
}
*/

/**
 Below block of code demonstrate the Operation queue functionality with Block operation, Thread. There is a completion Block functionality which will called after all the tasks executed. We can cancel the operation anytime we want using Cancel method of Operation. We can limit the operation count for perticular OperationQueue by setting value of maxConcurrentOperationCount variable. We can add dependancy on operation so depent operation will not start untill all the previous operaion not complete. When we add waitUntilFinished: true then it will wait to this line untill all the operaitons are finished.
 */

/*let blockOperation = BlockOperation()
blockOperation.completionBlock = {
    print("All Blocl Executed successfully")
}
blockOperation.addExecutionBlock {
    for i in 0 ..< 700 {
        print("inside First Block Operation \(i)")
    }
    
    print("First Block Thread Reference: \(Unmanaged.passUnretained(Thread.current).toOpaque())")
    print("Is Main Thread First: \(Thread.isMainThread)")
}

blockOperation.addExecutionBlock {
    for i in 0 ..< 700 {
        print("inside Second Block Operation \(i)")
    }
    
    print("Second Block Thread Reference: \(Unmanaged.passUnretained(Thread.current).toOpaque())")
    print("Is Main Thread Second: \(Thread.isMainThread)")
}

/*DispatchQueue.global(qos: .background).async {
    blockOperation.start()
}*/

let thread = Thread.init {
    blockOperation.start()
}

thread.start()
print("After Start Block Operation")*/


/*class MyCustomConcurrentOperation: Operation {
    override func start() {
        if (isCancelled)
        {
            return
        }
        Thread.init(block: main).start()
    }
    
    override func main() {
        for i in 0 ..< 100000 {
            guard !isCancelled else {
                print("On is Cancel")
                break
            }
            print("Custom Class \(i)")
            print("iS Main Thread: \(Thread.isMainThread)")
        }
        
    }
}


let obj = MyCustomConcurrentOperation()
obj.start()
sleep(1)
obj.cancel()*/

let operationQueue = OperationQueue()

let blockOpration = BlockOperation.init {
    for i in 0 ..< 100 {
        print("First Block of Code: \(i)")
        print("First Block is on Main Thread \(Thread.isMainThread)")
    }
}

let blockOpration1 = BlockOperation.init {
    for i in 0 ..< 100 {
        print("Second Block of Code: \(i)")
        print("Second Block is on Main Thread \(Thread.isMainThread)")
    }
    
}

blockOpration1.addDependency(blockOpration)
operationQueue.maxConcurrentOperationCount = 2
operationQueue.addOperations([blockOpration, blockOpration1], waitUntilFinished: true)
print("Last Block of code Executed")
