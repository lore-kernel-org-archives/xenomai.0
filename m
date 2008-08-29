Message-ID: <acb0c1690808291407x70ee253embb3659de01cb94dc@domain.hid>
Date: Fri, 29 Aug 2008 18:07:42 -0300
From: "Paulo Matias" <thotypous@domain.hid>
Sender: syscoder@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Ethernet & PS/2 interfering with Parallel Port
	Interrupts (IRQ 7)
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

Hi,

First of all, thank you all for the excellent work on Xenomai.

I was testing the following example code:
http://www.captain.at/xenomai-parallel-port-interrupt.php

This example code increases a counter every time a parallel port
interrupt occurs.

However, driving the parallel port pin 10 with a logic pulser, I found
that sometimes the example program was increasing the counter above
the number of pulses I was actually driving to the port.

Investigating the problem further, I found that unplugging mouse and
Ethernet cable made the problem to cease.

To confirm the problem really existed, I plugged pin 10 to the ground
to ensure no interrupts would be driven to the parallel port. Then, I
directed a ping flood ("ping -f") from another computer against the
computer that was running Xenomai. The result was an increase of
roughly one interrupt per second (or faster) into the counter of the
example program running in the Xenomai machine.

Moving a PS/2 mouse causes an interrupt being catch by the example
program sometimes (perhaps one interrupt at each half minute). I had
tested an USB mouse and an USB drive too, and it seems to cause the
same problem, although rarely.

Just to be sure it was not a hardware problem, I tested the parallel
port using this program running under FreeDOS -
http://parallelport.pastebin.com/f103d2e6a - compiled with OpenWatcom.
It did ran correctly and didn't presented the problem. I was running
Ethernet packet driver and mouse TSRs under FreeDOS when I did the
test.


Some details about my system follows:

Linux 2.6.25.8 & Xenomai-2.4.4

# uname -a
Linux xenomai 2.6.25-xenomai #1 SMP PREEMPT Tue Aug 19 10:26:44 BRT
2008 i686 AMD Athlon(TM)Processor AuthenticAMD GNU/Linux
# cat /proc/xenomai/irq
IRQ         CPU0
  7:        7921         parint
230:           0         [IPI]
233:      983297         [timer]
234:           0         [critical sync]
258:         111         [virtual]
# cat /proc/xenomai/registry/native/interrupts/parint
hits=4, pending=0, mode=0x200
+Int
# ls /proc/irq/7
smp_affinity  spurious
# cat /proc/irq/7/spurious
count 0
unhandled 0
last_unhandled 0 ms
# cat /proc/irq/7/smp_affinity
ffff
# cat /proc/interrupts
           CPU0
  0:         95    XT-PIC-XT        timer
  1:      15673    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  6:          0    XT-PIC-XT        ohci_hcd:usb2
  7:         35    XT-PIC-XT
  9:      65897    XT-PIC-XT        ohci_hcd:usb1, CMI8738-MC6
 10:    1196033    XT-PIC-XT        eth0
 12:      30791    XT-PIC-XT        i8042
 14:       8908    XT-PIC-XT        pata_ali
 15:         58    XT-PIC-XT        pata_ali
NMI:          0   Non-maskable interrupts
LOC:    1408542   Local timer interrupts
RES:          0   Rescheduling interrupts
CAL:          0   function call interrupts
TLB:          0   TLB shootdowns
TRM:          0   Thermal event interrupts
SPU:          0   Spurious interrupts
ERR:         37
MIS:          0


Note: "parint" is the name of the example program I'm running.

I hope someone can help me discovering what is going wrong here.

Thanks a lot!


Best regards,

Paulo Matias

