# px.nim.pods
Easy to read and type text format for serialization and config files. This is Nim implementation.
You can read about PODS here: https://github.com/PixeyeHQ/pods

## How to use it?
I encourage you to look in the example folder to find some examples of how to work with PODS in nim.
Use `pods` object hook to get API commands. `pods` is used as API hook. Use `PxPods` to get access to module types.
```nim
type Vector3 = object
  x: int
  y: int
  z: int

var position = Vector3(x:10,y:10,z:1)
var pod      = pods.initPodObject()
pod["position"] = pods.toPod(position)
pods.toPodFile(<your_path>.pods, pod, PxPods.PodStyle.Sparse)
```
## Usage / Contribution
The code may contain bugs and it lacks proper debugging and tests. It's still for personal use and may be rough on edges.
If you like the concept & idea than documentation, bug reports, pull requests or any other contributions are strongly welcome!
