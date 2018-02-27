# VKProgressHud

Hey All! As it is obvious from the GIF, this project is a ```LoadingIndicator``` based on ```CoreAnimation```. <br />

The Usage is like real simple: <br />
Download the code and drag-drop ```VKProgressHud.Swift``` in your project. <br />

Then add a variable  ```var hudView : VKProgressHud?``` in your Class.

**Showing Hud: <br />**

```hudView = VKProgressHud(crocImageName: "croc")``` <br />
```hudView?.showHUD(onView: self.view)```

Please note that ```croc``` is the name of Image you want in the Animation.

**Hiding Hud: <br />**

```hudView?.hideHUD()```

**Editable Properties:** <br />

1) Image in the Animator. <br />
2) Radius of animator from the variable named ```refreshRadius``` in ```VKProgressHud.Swift```. <br />
3) Size of the dot from the variable named ```dotLength``` in ```VKProgressHud.Swift```. <br />
4) Spacing of the dots from the variable named ```instanceCount``` in ```VKProgressHud.Swift```. <br />
5) Duration of the animation from the variable named ```animationDuration``` in ```VKProgressHud.Swift```. <br />
6) Also the colour codes from the line ```circle.backgroundColor``` in ```VKProgressHud.Swift```. <br />
7) Label text saying 'Loading' can be edited in in ```VKProgressHud.Swift```. <br />

![pk](https://user-images.githubusercontent.com/21070922/36742945-07ac7a8a-1c0f-11e8-8323-fe80ad4e2295.gif)

Crocodile Image : *Designed by Freepik from www.flaticon.com* <br />
Animation: *Heavily inspired from https://dribbble.com/shots/2679536-Dragon-Loading-Indicator*
