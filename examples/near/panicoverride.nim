{.push stack_trace: off, profiler:off.}

# import ./sysstr

proc revert(dataOffset: pointer; length: int32) {.noreturn, cdecl, importc.}
proc rawoutput(s: string) = 
  revert(cstring(s), s.len.int32)
   # log_utf8(cstring(s), s.len.int64)
proc panic(s: string) = rawoutput(s)
{.pop.}
