From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 17:55:02 +0200
Message-Id: <1282319702.5255.405.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt timer jitter
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Do you have any idea about reducing rt timer jitter ?
I experience annoyingly big jitter in a thread which is supposed to run
at 400us (i reckon this is nothing extra demanding from atom @1.6G)


the thread's loop looks like:

{
function1()
..2()
..3()
..4()

rt_task_wait_period()
}

(^yet another simplified model^)

task is periodic while native skin works in aperiodic timer mode.
(periodic timer has horrible timings - it is apparently not rt timer).

rt_task_wait_period() always exists with 0 (no overruns) and also these
functions take no longer than 120usec (average is: 80 .. 90)

after task_wait_period() i read tsc (on atom it is constant and also any
frq adjusting is disabled)

and if compared to previous readout and converted to ns i got jitter in
range of 10usec .. -18usec.  10 usec means that wait_period exited
before given time point and -18usec means that it did it with 18usec
delay.

I noticed that UP configuration has sligthly less jitter.

a part of dmesg:

SGEN-lpc 0x148f: division factor 20 (700), tcks: 2, 15
sgen_fpga_init:736 [0]: acc 00000000 (before rst 00000000) test 00000000
sgen_fpga_init:742 0000 c000
sgen_fpga_init:742 0000 c000
sgen_fpga_init:742 0000 c000
sgen_fpga_init:752 0000 8000
thread_task:2651 peak rt jitter -710[ns], tsc delta 667850
SGEN-lpc :detected inputs failure. Mask 0x000c
MOTION: setting Traj cycle time to 400000 nsecs
MOTION: setting Servo cycle time to 4000000 nsecs
thread_task:2651 peak rt jitter -3512[ns], tsc delta 672520
thread_task:2651 peak rt jitter 3694[ns], tsc delta 660510
thread_task:2651 peak rt jitter -4382[ns], tsc delta 673970
thread_task:2651 peak rt jitter 5146[ns], tsc delta 658090
thread_task:2651 peak rt jitter -5558[ns], tsc delta 675930
thread_task:2651 peak rt jitter 5626[ns], tsc delta 657290
thread_task:2651 peak rt jitter -5828[ns], tsc delta 676380
thread_task:2651 peak rt jitter 7264[ns], tsc delta 654560
thread_task:2651 peak rt jitter -7742[ns], tsc delta 679570
thread_task:2651 peak rt jitter -9626[ns], tsc delta 682710
thread_task:2651 peak rt jitter 10156[ns], tsc delta 649740
thread_task:2651 peak rt jitter -16262[ns], tsc delta 693770
SGEN-lpc [0] Fmax set to 285714Hz (180000)
SGEN-lpc [1] Fmax set to 285714Hz (180000)
SGEN-lpc [2] Fmax set to 285714Hz (150000)
thread_task:2651 peak rt jitter -18470[ns], tsc delta 697450


I must say it is 4 - 5 times worse if compared to rtai 3.7 / 2.6.27.19
UP.

I use now xenomai 2.5.4 with adeos 2.2-06 patch for same 2.6.27 kernel
to make these comparisons more reliable.


Can i do something with this ?

Regards,


-- 
Krzysztof Blaszkowski


