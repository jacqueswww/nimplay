import ../../nimplay/near_runtime


# proc test*(a: int64): int64 {.exportwasm.} =
#     if a == 911.int64:
#         panic()
#     a + 1


proc helloo() {.exportwasm.} =
    var a = 1234321.int32
    # value_return(sizeof(a).int64, cast[int32](addr a))
    value_return(sizeof(a).int64, cast[int64](addr a))
    # value_return(sizeof(a).int64, addr a)


proc hello() {.exportwasm.} =
    discard
