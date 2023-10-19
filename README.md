# ROBO Platform

Use this project to implement your wildest ideas! This project allows you to:

- record your phone's sensors and feed the extracted data to special software to reconstruct the 3D environment and localize your phone's 3D pose in that map.
- control any robot with your phone, from a drone to a smart farm.
- and do much more! You can always integrate other modules with this project to extend its functionality.

This project consists of three main modules:

- [Android App](https://github.com/m-dayani/robo-platform-android)
- [AVR Development Board](https://github.com/m-dayani/robo-platform-avr)
- [Desktop App](https://github.com/m-dayani/robo-platform-desktop)

Follow the links to each module to find more information about it. To record datasets, you only need the Android component. But if you want to control a remote robot with your laptop, you need all three modules. It is also possible to use two cell phones, one as the controller server and the other as the controlled client.

## Motivation

With all the development boards and software apps out there, you might wonder why you would ever need to endanger your precious phone with this code.

- **Cost**: Although Arduino and RasperyPie boards may sound very cheap to you, believe it or not, many cannot afford dedicated hardware in my country. All necessary sensors and communication means are packed in your phone, ready for use.
- **Flexibility**: You are using the app to power a drone and now want to turn it into a car? Just download the car app to your phone, and you are done! No additional hardware and software upgrade is needed.
- **R&D**: You might just need a quick feature test for your autonomous application, but you do not want to spend money on a dedicated system you use only once.
- **Entertainment**: You just need to record data for 3D reconstruction, AR, or VR applications.
