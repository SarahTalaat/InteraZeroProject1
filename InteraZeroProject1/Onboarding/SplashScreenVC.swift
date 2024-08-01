//
//  OnboardingVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 31/07/2024.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {
    
    @IBOutlet weak var splashScreenLottieView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        splashScreenLottieView.contentMode = .scaleAspectFit
        splashScreenLottieView.loopMode = .loop
        splashScreenLottieView.play()


        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(navToTabBar), userInfo: nil, repeats: false)
    }
    
    

    @objc func navToTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController {
            UIApplication.shared.windows.first?.rootViewController = tabBarController
        }
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
