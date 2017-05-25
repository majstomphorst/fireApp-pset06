# fireApp-pset06
### Audit - App studio - pset06 - 11436727 - Maxim Stomphorst

As you can see in the screenshots below the better code hub gives me 3 suggestions<br>
- Parameters: 5 Lines of code: 7.
```
Keep Unit Interfaces Small:
  MessageViewController.​didPressSend(UIButton,​String,​String,​String,​Date)
      starts at line 83 in fireApp-pset06/​MessageViewController.​swift
```
I can change these line of code without significant changes to the structure.
Because the complaint is about the 5 Parameters, this is caused by the `JSQMesage` API and the function i'm calling.

- Units of code to long.
```
Write Short Units of Code:
  — RegisterViewController.​registerButton(Any)
      starts at line 23 in fireApp-pset06/​RegisterViewController.​swift
  — MessageViewController.​viewWillAppear(Bool)
      starts at line 18 in fireApp-pset06/​MessageViewController.​swift
```
Better code hub want at most 15 lines of code.<br>
The first complaint is vaild its a bit long. i could create a function to ride the data to the firebase database but i downt see the point.
In my opinion its clear how it works and e function Won't significantly improve the code.


Better code hub want at most 15 lines of code.<br>
The second complaint is about 16 lines of Code.




# Screenshots
## Screenshot - 01 - audit task list
![alt tag](https://github.com/majstomphorst/fireApp-pset06/blob/master/doc/betterCodeHubTasklist.png)
## Screenshot - 02 - audit
![alt tag](https://github.com/majstomphorst/fireApp-pset06/blob/master/doc/betterCodeHubAudit.png)
## Screenshot - 03 - audit detailed
![alt tag](https://github.com/majstomphorst/fireApp-pset06/blob/master/doc/betterCodeHubAuditDetailed.png)
