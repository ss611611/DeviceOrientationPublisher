import UIKit
import Foundation
import Combine


/*
let publisher = Just(123)

let cancellable = publisher.sink { value in
    print(value)
}


cancellable.cancel()
*/

//let numbersPublisher = [1,2,3,4,5,6].publisher
//let doublePublisher = numbersPublisher.map { $0 * 2 }
//
//let cancellable = doublePublisher.sink { value in
//    print(value)
//}



/*   Subscribers - to - Publishers */

//let timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
//let cancellable = timerPublisher.autoconnect().sink { timestamp in
//    print("Timestamp: \(timestamp)")
//}



/* Combine Lifecycles */

//let numbersPublisher = [1...10].publisher
//let cancellable = numbersPublisher.sink { value in
//    print(value)
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//    cancellable.cancel()
//}



/* Error Handling */

enum NumberError: Error {
    case operationFailed
}

let numbersPublisher = [1, 2, 3, 4, 5].publisher
let doublePublisher = numbersPublisher
    .tryMap { number in
        if number == 4 {
            throw NumberError.operationFailed
        }
        
        return number * 2
    }
    .mapError { error in
        return NumberError.operationFailed
    }
let cancellable = doublePublisher.sink { completion in
    switch completion {
    case .finished:
        print("finished")
    case .failure(let error):
        print(error)
    }
} receiveValue: { value in
    print(value)
}

/*
 let doublePublisher = numbersPublisher
     .tryMap { number in
         if number == 4 {
             throw NumberError.operationFailed
         }
         
         return number * 2
     }
     .catch { error in
         if let numberError = error as? NumberError {
             print("Error occurred: \(numberError)")
         }
         
         return Just(0)
     }

 let cancellable = doublePublisher.sink { completion in
     switch completion {
     case .finished:
         print("finished")
     case .failure(let error):
         print(error)
     }
 } receiveValue: { value in
     print(value)
 }
 */

