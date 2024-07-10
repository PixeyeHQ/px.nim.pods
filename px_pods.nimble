# Package

version       = "2024.07.1"
author        = "Dmitry @Pixeye Mitrofanov"
description   = "Text format for serialization and config files"
license       = "MIT"
srcDir        = "src"


# Dependencies
requires "nim >= 1.9.3"

var ex = "ex"
var debug = "debug"

proc run(name, releaseMode="danger") =
  exec "nim cpp --mm:orc  -d:" & releaseMode & " -o=bin/ -r examples/" & name & ".nim"

task ex_pods, ex:
  run "ex_pods"
task ex_pods_d, debug:
  run "ex_pods", "debug"