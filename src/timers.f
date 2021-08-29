\ ****************************************************************************
\ File: timers.f
\ ****************************************************************************
\ Timer related words

-timers
marker -timers

$0252 constant TMR2
$0258 constant PR2
$025c constant T2CON

$0256 constant TMR3
$025a constant PR3
$025e constant T3CON

: timer2-on ( -- )
    T2CON @ %1000.0000.0000.0000 or T2CON !
;

: timer2-off ( -- )
    T2CON @ %1000.0000.0000.0000 xor T2CON !
;

: timer3-on ( -- )
    T3CON @ %1000.0000.0000.0000 or T3CON !
;

: timer3-off ( -- )
    T3CON @ %1000.0000.0000.0000 xor T3CON !
;

: watch-timer2
    timer2-on
    begin
        cr TMR2 @ u.
        key?
    until
    timer2-off
;

: watch-timer3
    timer3-on
    begin
        cr TMR3 @ u.
        key?
    until
    timer3-off
;
