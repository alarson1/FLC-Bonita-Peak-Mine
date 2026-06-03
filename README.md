# FLCServerTemplate

FLCServerTemplate is a foundational repository designed to streamline the development of XR Lab applications.
It provides a structured base for integrating real-time visualizations with scientific simulations, supporting synchronization 
between physical and digital environments.

---

The template includes a base Godot Server application configured to sync with NOODLES, UI elements, and a flask backend API.

### NOODLES
Syncs all Godot objects inderserted as a child of `NoodlesRoot`. 

See [noodles_server](https://github.com/FLC-Solar-Lab/noodles_server#) on GitHub for more details and configuration.

### 3D NOODLES-friendly User Interface (UI)

A simple demo UI is implimented. The button can be pressed to set the visibility of the Vicon-tracked
object. The UI panel can be grabbed and repositioned by the HMD clients using the `UIgrabbable` script and associated nodes.

See [hmdUI](https://github.com/FLC-Solar-Lab/hmdUI) on GitHub for more details and configuration.

### SimLink

Inlcuded is a `SimLink` scipt that is a foundation for making requests to backend API such as a Flask API. This allows 
for optional Python library integration. Notice the `request` method, which can be called to make a request to an API.
The `simulate` methods demonstrates an example implimentation.

### Vicon-tracked Object

An example tracked object named `Object` is included. The center of the Godot virtual object can be repositioned by the custom
child node `VRPNLink`, which is configure to reflect the `Object` in the Vicon Tracker app on the Vicon server: `10.16.10.10`.


### Sensing

Microcontrollers can be connected over websockets using this script. The `handle_msg` method can be used to parse the messsages from the 
microcontroller. 

---

This repository serves as a flexible starting point, allowing researchers and developers to build and extend new Lab applications.
