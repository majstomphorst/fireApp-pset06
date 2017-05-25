# Code review - fireApp-pset06

| Levels          | Mark|
|:---------------:|:---:|
| Names           | 3   |
| Headers         | 4   |
| Comments        | 3   |
| Layout          | 3   |
| Formatting      | 2   |   
| Flow            | 3   |
| Idiom           | 4   |
| Expressions     | 3   |
| Decomposition   | 4   |
| Modularization  | 4   |

## 10 points
1. The location of the alertUser function Was not immediately clear.
```Swift
import Foundation
import UIKit
extension UIViewController {

    func alertUser(title: String, message: String) {

        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
```
2. There is Some inconsistency with the comment style.
```Swift
/// creates a segue back this is needed to make the slide down animations (unwinde)
   @IBAction func returnToMessage(segue: UIStoryboardSegue) {}

/*
This functions read all messages from the Firdatabase, stores it in de "messages" variable of type "JSQMesage".
When its done it reloads the messages view (to display the messages).
*/
func readMessages() {}
```

3. There is some inconsistency with the naming of variables.<br>
Variable names `username` and `displayname` Are used interchangeably.<br>
In the "README" i already explained the reasons.

4. The location of the function `didPressSend` is a bit odd.<br>
Its located under `//MARK: - Action`. But its a part of `JSQMessage functions`.
So is can be located in both places. The advice was to places under `JSQMessage functions`.

5. There are a few spelling mistakes commontsn<br>
This is probably due to my dyslexia.

6. There is some inconsistency with the naming of variables.<br>
Because `JSQMessage` uses the keyword: `signOut` I should do the same in my code its `logOut`.

7. Consistency.
In comments sometimes refer to variables With "randomVariableName" but not always.

8. UIViewControllerExtension name.<br>
I have extended the UIViewController with an alert function. But it's called `ViewController+Error.swift` This was seen as confusing.

9. Create a variable once.<br>
In some places a reference variable is created. But this can be done once and the variable can be reused.
```Swift
let reffrence = FIRDatabase.database().reference().child("users").child(userId)
```

10. The JSQMessage API is not clearly documented what it does and how it works.
