Message-ID: <4A67F5D2.4090708@domain.hid>
Date: Thu, 23 Jul 2009 07:32:02 +0200
From: David <correupeldavid@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Advice for a newbie on Xenomai & USB
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,
=20
I am a PhD student at the Technical University of Catalonia. I work on=20
UAV helicopters. It is a new field in my research group so I need to=20
develop the rig before start working on Identification and Control=20
Theory (which is supposed to be THE topic of the Thesis). =20
=20
We chose to use en embedded PC as 'brain'. The readings of the system=20
come from an IMU and the actuators (R/C servos) are commanded by a=20
microcontroller (already programmed and working). Both devices Tx/Rx=20
input/output data with the computer through TTL USART converted to USB.
=20
The PC is an Intel Atom Z520, on a chipset ..., with 1GB of RAM and=20
booting on a high-speed Compact Flash.
=20
On the first stage of the software, a human is choosing the=20
microcontroller inputs (that is: piloting the craft), and the computer=20
'only' needs to gather the input to the microcontroller and the output=20
from the IMU and write it to disk with due time stamps. 10Hz would be=20
OK, 100Hz would be the goal.
=20
On the second stage, the computer will have to gather the output data,=20
compute the control input and send it to the microcontroller. On hard=20
real time at (>10 to 100) Hz, of course.
=20
As you may guess, I chose Xenomai to make sure time requirements are=20
respected. It would run on a command-line Ubuntu 9.04. The programming=20
would be developed for C++ (compiled with g++).
=20
As a totally newbie on Xenomai and only average user on Ubuntu-Linux, I=20
would need some community guidance to get my feet wet.
=20
As you already know my specifications, do you think the computing system=20
is suited for the needs? As the computer does not have embedded USART=20
modules, I rely on USB to TTL USART converters (ttyUSBx). Are there any=20
suitable drivers for Xenomai? USB4RT? With interruptions and=20
configuration for SSP? =20
Where do you guess the bottlenecks will be?
Is there any detailed guide for newbies? Could you suggest me any=20
documentation on PC architecture and/or Linux OS to fully understand the=20
system? I have mainly programmed microcontrollers, on which I would make=20
use of interruptions and input/output modules all the time, and I need=20
to port it to PC, for which I have never used interruptions nor used the=20
input/output modules' drivers deeply nor write them.
=20
Any suggestions would be very useful.
=20
Thanks for your help.
=20
Best regards,
=20
David Lav=E8rnia =20
=20
=20

