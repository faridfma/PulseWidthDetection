onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib BlockDesignArtyS7_opt

do {wave.do}

view wave
view structure
view signals

do {BlockDesignArtyS7.udo}

run -all

quit -force
