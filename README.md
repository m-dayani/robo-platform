# ROBO Platform

Use this project to implement your wildest ideas! This project allows you to:

- record your phone's sensors and feed the extracted data to special software to reconstruct the 3D environment and localize your phone's 3D pose in that map.
- control any robot with your phone, from a drone to a smart farm.
- and do much more! You can always integrate other modules with this project to extend its functionality.

This project consists of three main modules:

- [Android App](https://github.com/m-dayani/robo-platform-android)
- [AVR Development Board](https://github.com/m-dayani/robo-platform-avr)
- [Desktop App](https://github.com/m-dayani/robo-platform-desktop)

Follow the links to each module to find more information about it. To record datasets, you only need the Android component. But if you intend to control a remote robot with your laptop, you need all three modules. It is also possible to use two cell phones, one as the controller server and the other as the controlled client.

A sample dataset is available at: [The Robo-Platform Dataset](https://drive.google.com/drive/folders/1OZqdA1xa-SyJ64qL_TibqhtwhR1fWWrx?usp=sharing)

There is also a [preprint](https://arxiv.org/abs/2409.16595) explaining the details of the system.

The video instructions about how to work with this project:

[![Robo-Platform Instructions](https://img.youtube.com/vi/BTQ4yLB1bak/0.jpg)](https://www.youtube.com/watch?v=BTQ4yLB1bak)


## Motivation

With all the development boards and software packages out there, you might wonder why you would ever need to endanger your precious phone with this code.

- **Cost**: Although Arduino and Raspberry Pi boards may sound very cheap to you, some might prefer to use their phones for its convenience. All necessary sensors and communication means are packed in your phone, ready for use.
- **Flexibility**: You are using the app to power a drone and now want to turn it into a car? Just download the car app to your phone, and you are done! No additional hardware and software upgrade is needed.
- **R&D**: You might just need a quick feature test for your autonomous application, but you do not want to spend money on a dedicated system you use only once.
- **Entertainment**: You just need to record data for 3D reconstruction, AR, or VR applications.
