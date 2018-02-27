# VKProgressHud

Hey All! As it is obvious from the GIF, this project is a ```LoadingIndicator``` based on ```CoreAnimation```. <br />

The Usage is like real simple: <br />
Download the code and drag-drop ```VKProgressHud.Swift``` in your project. <br />

Then add a variable  ```var hudView : VKProgressHud?``` in your Class.

**Showing Hud: <br />**

```hudView = VKProgressHud(crocImageName: "croc")```
```hudView?.showHUD(onView: self.view)```

Please note that ```croc``` is the name of Image you want in the Animation.

**Hiding Hud: <br />**
```hudView?.hideHUD()```

![pk](https://user-images.githubusercontent.com/21070922/36742945-07ac7a8a-1c0f-11e8-8323-fe80ad4e2295.gif)

Crocodile Image : *Designed by Freepik from www.flaticon.com* <br />
Animation: *Heavily inspired from https://dribbble.com/shots/2679536-Dragon-Loading-Indicator*
