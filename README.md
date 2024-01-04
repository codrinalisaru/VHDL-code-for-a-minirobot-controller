**VHDL programming of a controller for a minirobot**

**1. General block diagram description**

The minirobot controller has the following functions:
1. It sets the vehicle motion sense;
2. It sets the vehicle motion direction;
3. It sets the vehicle moving speed.

The objective of the project is motion with constant speed. 
Controller's block diagram:

![image](https://github.com/codrinalisaru/VHDL-code-for-a-minirobot-controller/assets/94629883/cbed5922-9f45-45f2-9b9e-4a9e101b220e)

This controller sets the direction and the sense according to the c code word of 4 bits.

The decodifier block outputs (sens1, sens2, start_stop1, start_stop2) depends on the c code word, according to a truth table. If the sense signal is '1', then the vehicle is moving forward. If the sense signal is '0', then the vehicle is moving backwards.

If the signal start_stop is '1', then the motor is rotating, meaning the vehicle is moving, and if it's '0', the motor is stopped. 

SRA is the automatic adjustment system for controlling the motor speed. This SRA makes sure the motor speed is mmodified according to 3 parameters: speed, t = motor speed, k = proportionality constant.

The block must calculate:

dif=k*|vp-t|

vp>=t => semn ‘1’

vp<t => semn ‘0’

Motor speed t is provided using a speed transducer, using a code word. 

The speed and the proportionality constant are parameters that modify the SRA output signals. 

SRA2 has t1 as an input signal for the speed.

SRA1 synchronizes SRA2 by reducing the motor speed error m2.

The adaptive block translates the voltage levels from 3.3-5V to 9-48V.

The static converter provides the motor's command voltage by interpreting the signals provided by the controller: sens, start_stop, semn and dif. 

The motor speed transducer measures the motor speed, providing a binary signal to the SRA block. 

**2. Decoder design**

Truth table:

![image](https://github.com/codrinalisaru/VHDL-code-for-a-minirobot-controller/assets/94629883/b063994d-2274-4ae1-8f9b-b552a2c122e7)

Sens1=f(c1)

Sens2=f(c2)

Start_stop1=f(c)

Start_stop2=f(c)

VHDL code: decodifier.vhd

Chronograms: 

![image](https://github.com/codrinalisaru/VHDL-code-for-a-minirobot-controller/assets/94629883/24410513-e124-4506-90a3-dd054db04957)


**3.SRA - Automatic adjustment system**

Block-diagram: 

![image](https://github.com/codrinalisaru/VHDL-code-for-a-minirobot-controller/assets/94629883/9bde19b3-f3e0-4c5e-b6e4-2a057a91ba4f)

VHDL code: multiplexer_comparator.vhd

Chronograms:

![image](https://github.com/codrinalisaru/VHDL-code-for-a-minirobot-controller/assets/94629883/b42a0a71-605a-42a8-b115-983a3e1dcfb9)


**Difference block**

Block diagram:

![image](https://github.com/codrinalisaru/VHDL-code-for-a-minirobot-controller/assets/94629883/bedc9c17-81bb-41b2-8035-4dbe0dfd5125)

VHDL code: difference.vhd

