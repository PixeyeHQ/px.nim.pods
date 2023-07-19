import px_nim_pods/px_pods_d as PxPods
import px_nim_pods/px_pods
export PxPods
export px_pods.add
export px_pods.setFlags
export px_pods.`[]`
export px_pods.`[]=`
export px_pods.valPtr
export px_pods.val
export px_pods.fromPod
export px_pods.PodsAPI
export px_pods.PodDigits
export px_pods.toPodHook
export px_pods.fromPodHook
export px_pods.pods
export px_pods.getIO


#---------------------------------------------------------------------------------------------
# @api pod object constructors
#---------------------------------------------------------------------------------------------
using api: PodsAPI


proc initPod*(api; arg: int, flags: varargs[int]): Pod =
  px_pods.initPod(arg, flags)


proc initPod*(api; arg: float, flags: varargs[int]): Pod =
  px_pods.initPod(arg, flags)


proc initPod*(api; arg: string, flags: varargs[int]): Pod =
  px_pods.initPod(arg, flags)


proc initPod*(api; arg: bool, flags: varargs[int]): Pod =
  px_pods.initPod(arg, flags)


proc initPod*(api; arg: pointer, flags: varargs[int]): Pod =
  px_pods.initPod(arg, flags)


proc initPodArray*(api; flags: varargs[int]): Pod =
  px_pods.initPodArray(flags)


proc initPodObject*(api; flags: varargs[int]): Pod =
  px_pods.initPodObject(flags)


proc fromPodFile*(api; filePath: string): Pod =
  px_pods.fromPodFile(filePath)


proc fromPod*[T: not Pod](api; pod: var Pod, typeof: typedesc[T]): typeof =
  px_pods.fromPod(pod,typeof)


proc fromPod*[T: not Pod](api; pod: Pod, typeof: typedesc[T]): typeof =
  px_pods.fromPod(pod,typeof)


proc fromPodString*[T: not Pod](api; podsource: string, typeof: typedesc[T]): typeof =
  px_pods.fromPodString(podsource, typeof)


proc fromPodFile*(api; filePath: string, pod: var Pod) =
  var next = px_pods.fromPodFile(filePath)
  pod.merge(next)


proc fromPodFile*[T: not Pod](api; filePath: string, typeof: typedesc[T]): typeof =
  var pod = px_pods.fromPodFile(filePath)
  px_pods.fromPod(pod, typeof)


proc toPodFile*(api; path: string, pod: Pod, podStyle: PodStyle = PodStyle.Sparse) =
  px_pods.toPodFile(path, pod, podStyle)


proc toPodString*[T: not (Pod)](api; obj: var T): string =
  px_pods.toPodString(obj)


proc toPod*[T](api; obj: T): Pod =
  px_pods.toPod(obj)