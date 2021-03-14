import UIKit
import Lottie

class PageViewController: UIViewController {

    private var pageVC: UIPageViewController!
    private var controllers: [UIViewController] = []
    
    private var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .themeColor
        
        initAnimatinView()
    }

    private func initPageVC() {
        pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        let homeVC = HomeViewController()

        controllers = [homeVC,]
        pageVC.setViewControllers([controllers[0]], direction: .forward, animated: true)
        
        addChild(pageVC)
        self.view.addSubview(pageVC.view)
    }
    
    private func initAnimatinView() {
        animationView = AnimationView(name: "launch-animation")
        view.addSubview(animationView)
        let size = view.width
        animationView.translatesAutoresizingMaskIntoConstraints = false
        [animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -70),
         animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         animationView.widthAnchor.constraint(equalToConstant: size),
         animationView.heightAnchor.constraint(equalToConstant: size),].forEach({ $0.isActive = true })
        animationView.animationSpeed = 3
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play { [weak self](isOver) in
            if isOver {
                self?.animationView.removeFromSuperview()
                self?.initPageVC()
            }
        }
    }

}


extension PageViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        controllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index < controllers.count - 1 else { return nil }
        return controllers[index + 1]
    }
    
    
}
