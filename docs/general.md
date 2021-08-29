# General Notes
Here are some general notes about the [scamp](https://udamonic.com/what-is-a-scamp.html) computer. The contents of this file will eventually migrate over to their own relevant md file.

---
PIC24F64GB202: 64k Flash, 8K Ram

---
Connect to the scamp via micro usb:

    screen /dev/ttyACM0

This is a simple terminal (avoid using arrow keys as they become part of the input stream and it confuses the forth interpreter)

---
## LEDs
Turn on the status LED
    
    ledon

Turn off the status LED

    ledoff

Blink the status LED

    blink

The status LEDs are controlled by the `leds` word. The LEDS are very bright!

    $ffff leds \ Turns on all status LEDS
    $0000 leds \ Turns off all status LEDS
    $aaaa leds \ Every second status LED is on.

---
## Reset
The `warm` word will reset the device without removing the power.

Pressing the reset button on the scamp device, or removing and reconnecting the usb plug will also reset (but you lose your screen connection and have to start it up again)

---
## Number base

To switch the current number base you can use these words:

    decimal \ switch to decimal mode
    hex     \ switch to hexadecimal mode
    binary  \ switch to binary mode

In your source code, it is probably better to not assume what base you are in (unless you set it in your source code). I think it is more readable to prefix numbers with #, $ or % depending on the base you want to use

    #10     \ is a decimal number
    $ff     \ is a hexadecimal number
    %11101  \ is a binary number

For hex numbers, they must be in lowercase (UPPERCASE $FF is not supported and will error)

---
## Source code

Keep the source code in a file, and simply copy and paste it into the screen terminal.

---
## Forth Dictionary

Use markers in your source code. This will allow you to re-paste the same source code in (as flashforth doesn't allow you to redefine words)

    -myMarker
    marker -myMarker

If you have 2 markers -A and -B (and defined in that order) and you remove -A then -B will also be removed.

You can also `forget` words as well (and it will remove words from the dictionary up to and including the forgotten word).

`empty` will reset the entire forth dictionary back to the factory default (erasing all words).

---
## General Forth Tips

Limit stack usage to no more than 3-4 parameters
Keep word definitions short. A word should do one function only, nothing more, nothing less.
Keep it simple. Don't over complicate it. If your word is too complicated then it is a sign that you need to refactor and simplify the problem.

---
## Accessing memory

8-bit:

    c@ \ Byte fetch
    c! \ Byte store

16-bit:

    @ \ 2-Byte Fetch
    ! \ 2-Byte Store

32-bit:

    2@ \ 2 x 2-Byte Fetch
    2! \ 2 x 2-Byte Store

Handy to read or set the contents of the PIC registers

    $018c @

Only use even memory locations with `@` and `!` - If you access an invalid location the scamp will restart.

To access odd memory locations use `c@` and `c!`

Example: 

    $018c @ \ Returns PORTB register contents
    $018d @ \ ERROR: Causes the scamp to reset
    $018c c@ \ Returns the Hi-byte of the PORTB register
    $018d c@ \ Returns the Lo-byte of the PORTB register

Memory dump example:

    pad 32 dump

Erase a block of memory:

    pad 32 erase

Fill a block of memory:

    pad 32 255 fill

---
## Registers

Some simple example words to check the status of a register

    : portb-status $018c @ ;

Continuous status of a register

    : portb-showstatus
        begin
            cr portb-status u.
            key?
        until
    ;

---
## PORT Mappings

Scamp currently maps to the following PORTx on the PIC. Handy to know if you want to send out a nibble (like PB0-PB03) rather than individual Scamp ports

    | Scamp | PORTx | RPx   |
    +-------|-------|-------|
    | 0     | PB0   | RP0   |
    | 1     | PB1   | RP1   |
    | 2     | PB2   | RP2   |
    | 3     | PB3   | RP3   |
    | 4     | PB4   | RP4   |
    | 5     | PA0   | RP5   |
    | 6     | PA1   | RP6   |
    | 7     | PA3   | n/a   |
    | 8     | PA4   | n/a   |
    | 9     | RB7   | RP7   |
    | 10    | RB13  | RP13  |
    | 11    | RB14  | RP14  |
    | 12    | RB15  | RP15  |
    +-------|-------|-------|

---
## PWM

There are 6 channels available for PWM. All pins can do PWM except 4, 7, 8

The duty value is a fraction of the period value. So if the period is $8000 and the duty is $4000 then the duty is 50% of the period.

If duty >= period then no waveform can be generated, and the output just stays high.

---
## Timers

Timer1 is unavailable as FlashForth uses it internally. (I modified the PreScaler and the forth system slowed down).

Timer2/3 and Timer4/5 could be available for use (I've only experimented with Timer2)

Fcy = 16000
Fosc = 2 * Fcy (which is the clock cycle for the timers)

---
