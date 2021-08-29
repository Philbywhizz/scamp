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
    %1000.0000.0000.0000 T2CON mset
;

: timer2-off ( -- )
    %1000.0000.0000.0000 T2CON mclr
;

: timer3-on ( -- )
    %1000.0000.0000.0000 T3CON mset
;

: timer3-off ( -- )
    %1000.0000.0000.0000 T3CON mclr
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
