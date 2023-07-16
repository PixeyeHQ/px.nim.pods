#[
  POD (Pack of Data) is the engine Intermediate Data Format like JSON
]#
import std/strutils
import std/strformat
import std/tables
import std/os
import px_nim_pods


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
  table: Table[int,string]
  list:  seq[int]
  dead:  bool


# Doesn't know by default how to save enum
proc toPodHook*(api: PodsAPI, pod: var Pod, val: enum) =
  api.toPodHook(pod, $val)


proc fromPodHook*(api: PodsAPI, pod: var Pod, result: var UnitKind) =
  result = parseEnum[UnitKind](pod.vstring)


# Doesn't know by default how to save Table[int,string]
proc toPodHook*(api: PodsAPI, pod: var Pod, val: Table[int,string]) =
  var t = initTable[string,string]()
  for k,v in val.pairs:
    t[intToStr(k)] = v
  api.toPodHook(pod, t)


proc fromPodHook*(api: PodsAPI, pod: var Pod, result: var Table[int,string]) =
  var t = pod.fields
  for k,pod in t.pairs:
    result[k.parseInt] = pod.vstring


var table = initTable[int,string]()
table[1]  = "one"
table[10] = "ten"
table[13] = "black"


var list = @[0,1,2,3,4,5,13]
var unit1 = UnitObj(name: "Alain", pos: Vec3(x:5,y:10,z:0), power: 90, cost: 10, kind: Mage, table: table, dead: true)
var unit2 = UnitObj(name: "Cuthbert", pos: Vec3(x:10,y:10,z:0), power: 100, cost: 10, kind: Range, table: table, dead: true)
var unit3 = UnitObj(name: "Roland", pos: Vec3(x:12,y:10,z:5), power: 150, cost: 20, kind: Melee, table: table, list: list, dead: false)


var pod = pods.initPodObject()
pod["Alain"]    = pods.toPod(unit1)
pod["Cuthbert"] = pods.toPod(unit2)
pod["Roland"]   = pods.toPod(unit3)

let path = &"{os.getAppDir()}"
let densePath = &"{path}/dense.pods"
let sparsePath = &"{path}/sparse.pods"
let compactPath = &"{path}/compact.pods"
pods.toPodFile(densePath,   pod, PodStyle.Dense)
pods.toPodFile(compactPath, pod, PodStyle.Compact)
pods.toPodFile(sparsePath,  pod, PodStyle.Sparse)
# Compact: save pod to file without spaces in one line.
# Dense:   save pod to file in a verbose tree format. Usually used for configs.
# Sparse:  save pod to file in a json like tree format. Sparse also enables pretty formatting for variables. In future this will be optional.
var podLoaded   = pods.fromPodFile(densePath)
var unit1Loaded = pods.fromPod(podLoaded["Alain"], UnitObj)
var unit2Loaded = pods.fromPod(podLoaded["Cuthbert"], UnitObj)
var unit3Loaded = pods.fromPod(podLoaded["Roland"], UnitObj)


echo unit1Loaded
echo unit2Loaded
echo unit3Loaded

