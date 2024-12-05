//
//  LaunchScreenViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 05/12/24.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var pokeballImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPokeballAnimation()
    }

    private func setupPokeballAnimation() {
        animateShake()
    }

    private func animateShake() {
        let shakeAnimation = CAKeyframeAnimation(
            keyPath: "transform.rotation.z")
        shakeAnimation.values = [-0.2, 0.2, -0.1, 0.1, 0]
        shakeAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        shakeAnimation.duration = 0.5
        shakeAnimation.repeatCount = 3

        let bounceAnimation = CABasicAnimation(keyPath: "transform.scale")
        bounceAnimation.fromValue = 1.0
        bounceAnimation.toValue = 0.9
        bounceAnimation.duration = 0.25
        bounceAnimation.autoreverses = true
        bounceAnimation.repeatCount = 6

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [shakeAnimation, bounceAnimation]
        animationGroup.duration = 1.5
        animationGroup.beginTime = CACurrentMediaTime()
        animationGroup.isRemovedOnCompletion = true

        pokeballImageView.layer.add(animationGroup, forKey: UIConstants.SplashScreen.shakeAndBounceAnimationKey)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.animatePopOpen()
        }
    }

    private func animatePopOpen() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.pokeballImageView.transform = CGAffineTransform(
                    scaleX: 1.5, y: 0.5)
            }
        ) { _ in
            UIView.animate(
                withDuration: 0.2,
                animations: {
                    self.pokeballImageView.transform = CGAffineTransform(
                        scaleX: 1.0, y: 1.0)
                }
            ) { _ in
                UIView.animate(
                    withDuration: 0.5,
                    animations: {
                        self.pokeballImageView.alpha = 0
                    }
                ) { _ in
                    self.pokeballImageView.removeFromSuperview()
                    self.transitionToMainScreen()
                }
            }
        }
    }

    func transitionToMainScreen() {
        let mainTabBarController =
            self.storyboard?.instantiateViewController(
                withIdentifier: Files.Storyboard.mainTabBarControllerID)
            as! UITabBarController

        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene

        if let window = windowScene?.windows.first {
            window.rootViewController = mainTabBarController
            window.makeKeyAndVisible()
        }
    }
}
