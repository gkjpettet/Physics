# Xojo Physics Engine

This `Physics` module finally brings Erin Catto's amazing [Box2D] library to Xojo.

`Physics` is a rigid body, high performance physics engine written in 100% native Xojo code. It's a direct port of Dart's [Forge2D] and so tutorials for using both Box2D and Forge2D should be closely compatible with `Physics`.

## Features
Box2D is pretty well known but here are some of the features of the engine:

- Continuous collision detection with time of impact solver
- Convex polygons and circles
- Multiple shapes per body
- Dynamic tree broadphase
- Contact filtering
- Stable stacking with a linear time solver
- Multiple joints types including revolute, distance and constant volume
- Joint motors
- Variable body density, friction and restitution
- Sleep management

## Usage

Everything you need to get started is in this repository. If you download and run the project you'll be presented with a demo app that showcases a few of the engine's features.

The engine is entirely contained within the `Physics` module to make it easy to move between projects. There are two other modules in the project that the `Physics` module depends on: `Maths` and `VMaths`. You'll need to copy these to any projects you want to use the engine in as well. The `Maths` module contains some maths-specific methods and constants and the `VMaths` module contains classes related to vector maths.

Included is the `Physics.DebugCanvas` class which is a subclass of `DesktopCanvas`. This is a drop-in control that will render the physics simulation. The `DebugCanvas` is not intended to be used for a game (it could be better optimised) but it's quite performant nonetheless.

## Requirements

The engine was developed on a 16" MacBook Pro with an M1 Pro using Xojo 2022 Release 2. The code is entirely API 2.0. I've not tested it on earlier Xojo releases.

Since the engine is 100% Xojo code it will run on all desktop platforms and iOS. I'm not much of an iOS developer but I do plan on adding an iOS version of the included `Physics.DebugCanvas` that would render the simulation on iOS.

## Performance

I've been pleasantly surprised by the performance of the demo app. In the built demo app, I'm consistently able to get 60 FPS on my M1 Pro Macbook Pro. Very surprisingly I found the performance was even better on my Windows 11 gaming rig where I was able to get 60 FPS with > 200 bodies on screen at once! This was not case on a Windows 11 laptop with an integrated GPU. Your mileage may vary.

Please note that performance will be much slower when running the demo in the debugger as a lot of additional checks are performed by the engine when in debug mode.

## Port Progress

I'm about 95% of the way through porting Forge2D. The engine is fully operational. All that is missing are a few joint types that I intend to port as well.

## Development background

I've been trying (on and off) since about 2019 to write a physics engine for Xojo. After multiple failed attempts at porting various physics engines written in C++ (such as the original [Box2D], [Bullet] and [Chipmunk]) and Javascript ()[Matter.js][Matterjs]) I decided to write my own. After a lot of reading I released a simple engine called [ImpulseEngine]. Whilst I was pretty proud of this it was lacking in a number of areas. Firstly it was slow as it lacked a decent broadphase. Secondly I never managed to figure out how to implement joints which were very important to me.

I've recently been dabbling in Flutter and Dart and came across the [Flame] game engine which uses a Dart-port of Box2D called [Forge2D]. Dart is similar enough in its object model to allow me to port it to Xojo.

[Box2D]: https://box2d.org
[Forge2D]: https://github.com/flame-engine/forge2d]
[Chipmunk]: https://chipmunk-physics.net
[Bullet]: https://github.com/bulletphysics/bullet3
[Matterjs]: https://brm.io/matter-js/
[ImpulseEngine]: https://github.com/gkjpettet/ImpulseEngine
[Flame]: https://flame-engine.org