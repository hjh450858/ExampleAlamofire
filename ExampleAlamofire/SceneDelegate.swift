//
//  SceneDelegate.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // MARK: - 이 부분을
//        guard let _ = (scene as? UIWindowScene) else { return }
        
        /*
         // MARK: - 이 형태로 바꿔주면 된다
         ViewController() << 처음으로 보여줄 화면 설정
         ViewController -> viewDidLoad() -> view.backgroundColor = .white 설정해야함
         안하면 화면 색이 없어서 어두움
         */
        
        // scene이 UIWindowScene으로 타입 캐스팅 가능한지 확인하고, 불가능하면 함수 종료
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 새 UIWindow 인스턴스를 생성하면서 위에서 얻은 windowScene을 사용
        let window = UIWindow(windowScene: windowScene)
        // 네비게이션 컨트롤러를 생성하고, 루트 뷰 컨트롤러로 ViewController 인스턴스를 설정
        let navController = UINavigationController(rootViewController: ViewController())
        // 윈도우의 루트 뷰 컨트롤러를 위에서 만든 네비게이션 컨트롤러로 설정
        window.rootViewController = navController
        // 현재 SceneDelegate 클래스의 window 속성에 위에서 만든 window를 할당 (window를 유지시킴)
        self.window = window
        // 윈도우를 키 윈도우로 만들고 화면에 표시
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

