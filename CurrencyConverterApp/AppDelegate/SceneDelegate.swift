//
//  SceneDelegate.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setRootViewController(scene: scene)
    }

}

extension SceneDelegate {
    func setRootViewController(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        navigationController.viewControllers = [CurrencyRatesViewController()]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
