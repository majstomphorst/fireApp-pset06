# fireApp-pset06
### Audit - App studio - pset06 - 11436727 - Maxim Stomphorst

As shown in the screenshots below, the better code hub (Better Code Hub) gave me three suggestions.<br>
- Parameters: 5 Lines of code: 7.
```
Keep Unit Interfaces Small:
  MessageViewController.​didPressSend(UIButton,​String,​String,​String,​Date)
      starts at line 83 in fireApp-pset06/​MessageViewController.​swift
```
I can't change these lines of code without making significant changes to the structure. Because the complaint is about the 5 parameters, this is caused by the `JSQMesage` API and the function i'm calling.
Better code hub want's at most 4 Parameters.

- Units of code to long.
```
Write Short Units of Code:
  — RegisterViewController.​registerButton(Any)
      starts at line 23 in fireApp-pset06/​RegisterViewController.​swift
  — MessageViewController.​viewWillAppear(Bool)
      starts at line 18 in fireApp-pset06/​MessageViewController.​swift
```
Better code hub wants at most 15 lines of code.
The first complaint is valid, because the code is in fact a bit (too) long. I could create a function to write the data to the firebase database but I do not see the point. In my opinion it is clear how it (the code) works and a function  would not significantly improve the code.

Better code hub requires at most 15 lines of code.
The second complaint is about 16 lines of Code

# Screenshots
## Screenshot - 01 - audit task list
![alttag](https://github.com/majstomphorst/fireApp-pset06/blob/master/doc/betterCodeHubTasklist.png)
## Screenshot - 02 - audit
![alt tag](https://github.com/majstomphorst/fireApp-pset06/blob/master/doc/betterCodeHubAudit.png)
## Screenshot - 03 - audit detailed
![alt tag](https://github.com/majstomphorst/fireApp-pset06/blob/master/doc/betterCodeHubAuditDetailed.png)
