MIME-Version: 1.0
Date: Tue, 28 Jul 2009 14:09:34 +0200
Message-ID: <b88603c30907280509u685a18di730cc0b021ab06eb@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Pagefaults during mlocked Realtime task
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

Hi everyone,

I have a basic Xenomai realtime user task which does a read call to a
basic RTDM driver. The problem is that the realtime task is generating
pagefaults when the system is under heavy network load even while the
current and future memory is locked with mlockall(MCL_CURRENT |
MCL_FUTURE);. There should also be enough free memory.

Both the MSW and PF go up when showing the stat. So the realtime task
switches to the secondary domain causing long latencies which we don't
want.

(Aside from that I just want to mention that when we generate the high
load on the usb-gadget ethernet interface (g_ether), the realtime task
even gets defunct or generates a segfault. I first want to understand
the pagefaults when using the normal ethernet interface, which might
then later explain the things we are seeing using the usb-gadget
interface.)

I used the sigxcpu.c example to try to find the root of the
pagefaults, but that only provides me one address which seems to be on
the [stack] according to the process maps. Running the app in the
debugger halts when the signal triggers and the call stack shows it is
at <rt_dev_read+60>: pop    {r4, r7, pc}
I cannot really find anything in our driver code (rt_dev_read) or
realtime app that would generate these pagefaults.

Any help to explain and get rid of the pagefaults is very welcome!

I am currently running a 2.6.28 linux kernel and Xenomai version 2.4.8
on an ARM926EJ-S (at91sam9263ek) processor, using the EABI and
-msoft-float cross compiled with CodeSourcery 2007q3.

root@domain.hid:~# free
Unknown HZ value! (86) Assume 100.
             total       used       free     shared    buffers     cached
Mem:         60788      17100      43688          0        564       7464
-/+ buffers/cache:       9072      51716
Swap:            0          0          0

root@domain.hid:~# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          9310038    0     00500080   49.7  ROOT
  0  1317   7          4223140    7     00320182   47.8  RTT
  0  0      0          1356807    0     00000000    0.2  IRQ19: [timer]
  0  0      0          13455406   0     00000000    2.1  IRQ31: fpga

Thanks,
Henri

