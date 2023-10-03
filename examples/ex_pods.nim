#[
  POD (Pack of Data) is the engine Intermediate Data Format like JSON
]#
import std/strutils
import std/strformat
import std/tables
import std/os
import std/times
import px_pods


type UnitKind = enum
  Melee = "Melee",
  Range = "Range",
  Mage  = "Mage"


type Vec3 = object
  x: int
  y: int
  z: int


type UnitObj = object
  name:  string
  pos:   Vec3
  power: int
  cost:  int
  kind:  UnitKind
  friends:  seq[string]
  inventory: Table[string,string]
  dead:  bool


# Doesn't know by default how to save enum
proc toPodHook*(api: PodsAPI, pod: var Pod, val: enum) =
  api.toPodHook(pod, $val)


proc fromPodHook*(api: PodsAPI, pod: var Pod, result: var UnitKind) =
  result = parseEnum[UnitKind](pod.vstring)


var inventoryAlain = initTable[string,string]()
var inventoryCuthbert = initTable[string,string]()
var inventoryRoland = initTable[string,string]()


var friendsAlain = @["Cuthbert","Roland"]
var friendsCuthbert = @["Alain","Roland"]
var friendsRoland= @["Alain","Cuthbert","Susan"]


inventoryAlain["book"]        = "Homilies and Meditations"
inventoryCuthbert["necklace"] = "The Lookout"
inventoryCuthbert["weapon1"]  = "carver"
inventoryCuthbert["weapon2"]  = "slingshot"
inventoryRoland["pet"]        = "David"


var unit1 = UnitObj(name: "Alain", pos: Vec3(x:5,y:10,z:0), power: 90, cost: 10, kind: Mage, inventory: inventoryAlain, friends: friendsAlain, dead: true)
var unit2 = UnitObj(name: "Cuthbert", pos: Vec3(x:10,y:10,z:0), power: 100, cost: 10, kind: Range, inventory: inventoryCuthbert, friends: friendsCuthbert, dead: true)
var unit3 = UnitObj(name: "Roland", pos: Vec3(x:12,y:10,z:5), power: 150, cost: 20, kind: Melee, inventory: inventoryRoland, friends: friendsRoland, dead: false)


let path = os.getAppDir()
let densePath = &"{path}/dense.pods"
let sparsePath = &"{path}/sparse.pods"
let compactPath = &"{path}/compact.pods"
var pod = pods.newPodObject()
pod["Alain"]    = pods.toPod(unit1)
pod["Cuthbert"] = pods.toPod(unit2)
pod["Roland"]   = pods.toPod(unit3)

pods.toPodFile(densePath,   pod, PxPods.PodStyle.Dense)
pods.toPodFile(compactPath, pod, PxPods.PodStyle.Compact)
pods.toPodFile(sparsePath,  pod, PxPods.PodStyle.Sparse)


# Compact: save pod to file without spaces in one line.
# Dense:   save pod to file in a verbose tree format. Usually used for configs.
# Sparse:  save pod to file in a json like tree format. Sparse also enables pretty formatting for variables. In future this will be optional.
var podLoaded   = pods.fromPodFile(compactPath)
var unit1Loaded = pods.fromPod(podLoaded["Alain"], UnitObj)
var unit2Loaded = pods.fromPod(podLoaded["Cuthbert"], UnitObj)
var unit3Loaded = pods.fromPod(podLoaded["Roland"], UnitObj)

echo unit1Loaded
echo unit2Loaded
echo unit3Loaded

