import std/tables
const 
  POD_DONT_SAVE* = 1
type 
  PodStyle* {.pure.} = enum 
    Compact,
    Sparse,
    Dense
  PodKind* = enum
    PInt,
    PBool,
    PFloat,
    PArray,
    PString,
    PObject,
    PPointer
  PodErrorKind* = enum
    NoFile,
    NonConvertable,
    InvalidKey,
    InvalidNodeKey,
    InvalidStringEnding,
    InvalidTreeRootKey,
    InvalidNumber,
    UnknownValue
  PodsIO* = ref object
    style*:     PodStyle
    debugProc*: proc(message: string)
  PodError* = object of ValueError
  PodWriter* = object
    charIndex*: int
    buffer*:    string
    bufferLen*: int
    depth*:     int
    tokens*:    seq[string]
    ident*:     int
    objDepth*:  int
  PodReader* = object
    charIndex*: int
    token*:     string
    source*:    ptr UncheckedArray[char]
    sourceLen*: int
  Pod* = ref object
    flag*: int
    case kind*: PodKind
      of PInt:
        vint*: int
      of PFloat:
        vfloat*: float
      of PBool:
        vbool*: bool
      of PString:
        vstring*: string
      of PArray:
        list*: seq[Pod]
      of PObject:
        isTable*: bool
        fields*:  OrderedTable[string,Pod]
      of PPointer:
        vpointer*: pointer
