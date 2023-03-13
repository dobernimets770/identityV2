import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}







// import UIKit
// import Flutter
// import CallKit

// var channel: FlutterMethodChannel?

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
    
//     var controller:FlutterViewController?
  
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
      
//       self.controller = window?.rootViewController as? FlutterViewController
      
//       channel = FlutterMethodChannel(name: "FlutterFramework/swift_native", binaryMessenger: controller!.binaryMessenger)
//       GeneratedPluginRegistrant.register(with: self)
//             channel?.setMethodCallHandler({
//                [weak self]  (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//                // This method is invoked on the UI thread.
//                // Handle battery messages.
//                guard call.method == "startCallListen" else {
//                    result(FlutterMethodNotImplemented)
//                    return
//                }
           
     
//                result(self?.startCallListen())
//            })
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
    
    
//     // func callNumber(phoneNumber:String) {
//     //   if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
//     //     let application:UIApplication = UIApplication.shared
//     //     if (application.canOpenURL(phoneCallURL)) {
//     //         application.open(phoneCallURL, options: [:], completionHandler: nil)
            
//     //     }
//     //   }
//     // }
//     func startCallListen()->String{
       
//         let obj = PhoneCallObserver.sharedObserver
//         print("is my state = \(obj.myState)")
//         return ("its work");
//     }
    


// //  f      func startCall(){
// //         let handle = CXHandle(type: .phoneNumber, value: "0584109770")
// //         let startCall = CXStartCallAction(call: UUID(), handle: handle): handle))
//     //}
  
// }



//  class PhoneCallObserver: NSObject {
    
//      static let sharedObserver = PhoneCallObserver()
    
//      private let serialQueue = DispatchQueue(label: "my.ios10.call.status.queue")
//      private let callObserver = CXCallObserver()
//      var myState = ""
//      var number = ""
//      private override init() {
//          super.init()
//          self.callObserver.setDelegate(self, queue: self.serialQueue)
//      }

//  }



    
// extension PhoneCallObserver: CXCallObserverDelegate {
    
//     func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        
//         let identifier = call.uuid.uuidString
        
//         // let args = [check: "123"]
//         channel?.invokeMethod("gocode", arguments: identifier)
//         var state = ""
        
//         if call.isOutgoing {
//             state = "Outgoing "
//         } else {
//             state = "Incoming "
//         }
        
//         if call.isOnHold {
//             state = state+"On hold "
//         }
        
//         if call.hasConnected {
//             state = state+"Connected "
//         } else {
//             state = state+"Alerting "
//         }
        
//         if call.hasEnded {
//             state = state+"Ended"
//         }
//         self.myState = state
//         print("Call \(identifier) is now in state \(state)")
//     }

// }