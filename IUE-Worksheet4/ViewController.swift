
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var plusButton: CustomButton!
    @IBOutlet weak var minusButton: CustomButton!
    @IBOutlet weak var slidingButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        plusButton.transform = CGAffineTransform(translationX: -view.bounds.width/2, y: 0)
        minusButton.transform = CGAffineTransform(translationX: view.bounds.width/2, y: 0)
        
        counterView.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height)
        counterLabel.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
        
        slidingButton.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {[weak self] in
                        self?.plusButton.transform = CGAffineTransform.identity
                        self?.minusButton.transform = CGAffineTransform.identity
                        self?.counterView.transform = CGAffineTransform.identity
                        self?.counterLabel.transform = CGAffineTransform.identity
            }, completion: nil)
        
        UIView.animate(withDuration: 1,
                       delay: 2,
                       options: [.curveEaseOut],
                       animations: {[weak self] in
                        self?.slidingButton.transform = CGAffineTransform.identity
            }, completion: {[weak self] (par) in
                UIView.animate(withDuration: 1,
                               animations: {[weak self] in
                                guard let self = self else {return}
                                
                                self.slidingButton.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
                        
                    }, completion: {[weak self] (par) in
                        UIView.animate(withDuration: 2,
                                       delay: 0,
                                       options: [.autoreverse, .repeat],
                                       animations: {[weak self] in
                                        guard let self = self else {return}
                                        
                                        self.slidingButton.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
                            }, completion: nil)
                })})
                
        }
        
        @IBAction func buttonPlusClick(_ sender: Any) {
            UIView.animate(withDuration: 0.5,
                           animations:  {[weak self] in
                            self?.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                            self?.plusButton.transform = CGAffineTransform.identity
            })
            
            counterView.currentNumber += 1
            updateCounterLabel()
        }
        @IBAction func buttonMinusClick(_ sender: Any) {
            UIView.animate(withDuration: 0.25,
                           animations:  {[weak self] in
                            self?.minusButton.transform = CGAffineTransform(scaleX: 2, y: 2)
                            self?.minusButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            
            counterView.currentNumber -= 1
            updateCounterLabel()
        }
        
        private func updateCounterLabel() {
            UIView.transition(with: counterLabel,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                guard let self = self else { return }
                                self.counterLabel.text = String(self.counterView.currentNumber)
                }, completion: nil
            )
        }
}

