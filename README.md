# Scamp computer Experiments
Experiments and learnings with [FlashForth](https://flashforth.com/) on the [SCAMP](https://udamonic.com/what-is-a-scamp.html) forth computer

This repository contains all my little experiments and forth source code that I have developed for the SCAMP computer. I am no expert in forth but feel it would be helpful to keep  a repository of forth code (as I haven't found many examples, except for the [scamp] website). Feel free to use these files as you like.

## Hardware Setup
My hardware setup is an Scamp computer running on a breadboard connected by a microUSB cable. The 'about' word reports:

```
  Udamonic Scamp2
  www.udamonic.com
  Scamp BSP v1.2 by John Catsoulis
  FlashForth v5.0 (GPL3) by Mikael Nordman
```

## Communications

I am using [gtkterm](https://github.com/Jeija/gtkterm) hosted on Regolith linux setup with these port configurations:

    /dev/ttyACM0 38400-8-N-1
    Flow Control: Xon/Xoff
    End of line Delay: 250ms

The 'end of line delay' allows me to 'Send RAW files' over serial to the scamp
