Message-ID: <4C8605E6.4000400@domain.hid>
Date: Tue, 07 Sep 2010 02:29:10 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------090007070302070109020207"
Subject: [Xenomai-help] How do I force a core dump on a page fault event?
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

This is a multi-part message in MIME format.
--------------090007070302070109020207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  I am seeing various Oops reports referencing my rt user task, but they 
don't provide any useful information regarding my program's state at the 
time of the Oops.

The most common Oops is...
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
pgd = cf02c000
[0000000c] *pgd=8f8a5031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#2]
last sysfs file: /sys/devices/virtual/gpio/gpio7/value
Modules linked in: rtservo_driver rtasuspidvr [last unloaded: 
rtservo_driver]
CPU: 0    Tainted: G      D     (2.6.33 #10)
PC is at do_page_fault+0x40/0x26c
LR is at do_DataAbort+0x34/0x11c
pc : [<c002d9d8>]    lr : [<c002733c>]    psr: 60000113
sp : ce8620d8  ip : 00000007  fp : 00000000
r10: ce862218  r9 : 00000017  r8 : 0000000c
r7 : ce862218  r6 : 0000000c  r5 : 00000017  r4 : ffffffff
r3 : 00000000  r2 : 00000003  r1 : 00000017  r0 : c0429100
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8f02c019  DAC: 00000015
Process navigator (pid: 666, stack limit = 0xce8602e8)
Stack: (0xce8620d8 to 0xce862000)
[<c002d9d8>] (do_page_fault+0x40/0x26c) from [<c002733c>] 
(do_DataAbort+0x34/0x11c)
[<c002733c>] (do_DataAbort+0x34/0x11c) from [<c0027bec>] 
(__dabt_svc+0x4c/0x60)
Exception stack(0xce862218 to 0xce862260)
2200:                                                       c0429100 
00000017
2220: 00000003 00000000 ffffffff 00000017 0000000c ce8623a0 0000000c 
00000017
2240: ce8623a0 00000000 00000007 ce862260 c002733c c002d9d8 60000113 
ffffffff
[<c0027bec>] (__dabt_svc+0x4c/0x60) from [<c002d9d8>] 
(do_page_fault+0x40/0x26c)
[<c002d9d8>] (do_page_fault+0x40/0x26c) from [<c002733c>] 
(do_DataAbort+0x34/0x11c)
[<c002733c>] (do_DataAbort+0x34/0x11c) from [<c0027bec>] 
(__dabt_svc+0x4c/0x60)
Exception stack(0xce8623a0 to 0xce8623e8)
23a0: c0429100 00000017 00000003 00000000 ffffffff 00000017 0000000c 
ce862528
23c0: 0000000c 00000017 ce862528 00000000 00000007 ce8623e8 c002733c 
c002d9d8
23e0: 60000113 ffffffff
[<c0027bec>] (__dabt_svc+0x4c/0x60) from [<c002d9d8>] 
(do_page_fault+0x40/0x26c)
[<c002d9d8>] (do_page_fault+0x40/0x26c) from [<c002733c>] 
(do_DataAbort+0x34/0x11c)
[<c002733c>] (do_DataAbort+0x34/0x11c) from [<c0027bec>] 
(__dabt_svc+0x4c/0x60)
Exception stack(0xce862528 to 0xce862570)
2520:                   c0429100 00000017 00000003 00000000 ffffffff 
00000017
2540: 0000000c ce8626b0 0000000c 00000017 ce8626b0 00000000 00000007 
ce862570
2560: c002733c c002d9d8 60000113 ffffffff
[<c0027bec>] (__dabt_svc+0x4c/0x60) from [<c002d9d8>] 
(do_page_fault+0x40/0x26c)
[<c002d9d8>] (do_page_fault+0x40/0x26c) from [<c002733c>] 
(do_DataAbort+0x34/0x11c)
[<c002733c>] (do_DataAbort+0x34/0x11c) from [<c0027bec>] 
(__dabt_svc+0x4c/0x60)
Exception stack(0xce8626b0 to 0xce8626f8)
26a0:                                     c0429100 80000007 00000003 
00000000
26c0: ffffffff c03e3ecc 00000000 ce862838 00000000 80000007 ce862838 
00000000
26e0: 00000007 ce8626f8 c00272a4 c002d9d8 60000113 ffffffff
[<c0027bec>] (__dabt_svc+0x4c/0x60) from [<c002d9d8>] 
(do_page_fault+0x40/0x26c)
[<c002d9d8>] (do_page_fault+0x40/0x26c) from [<c00272a4>] 
(do_PrefetchAbort+0x34/0x98)
[<c00272a4>] (do_PrefetchAbort+0x34/0x98) from [<c0027d70>] 
(__pabt_svc+0x50/0xa0)
Exception stack(0xce862838 to 0xce862880)
2820:                                                       fffffff2 
fffffff2
2840: fffffff2 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
2860: 00000000 00000000 40044f74 ce862880 40038968 00000000 a0000113 
ffffffff
[<c0027d70>] (__pabt_svc+0x50/0xa0) from [<40038968>] (0x40038968)
Code: 1a000005 e3cd3d7f e3c3303f e593300c (e593300c)
---[ end trace 2f957df7c098c760 ]---

Another is...
Unable to handle kernel paging request at virtual address 70000049
pgd = cf034000
[70000049] *pgd=00000000
Internal error: Oops: 805 [#1]
last sysfs file: /sys/devices/virtual/gpio/gpio7/value
Modules linked in: rtservo_driver rtasuspidvr
CPU: 0    Not tainted  (2.6.33 #10)
PC is at 0x40038998
LR is at 0x40038984
pc : [<40038998>]    lr : [<40038984>]    psr: 60000113
sp : cf0f3ff8  ip : 00000000  fp : 00000001
r10: 40242c3c  r9 : 00000000  r8 : 40242c40
r7 : 000f0042  r6 : 40242c40  r5 : 402434b0  r4 : 00000000
r3 : 00000a64  r2 : 70000049  r1 : ffffffab  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8f034019  DAC: 00000015
Process navigator (pid: 646, stack limit = 0xcf0f22e8)
Stack: (0xcf0f3ff8 to 0xcf0f4000)
3fe0:                                                       00000000 
00000000
Code: 0affffe9 e3500000 059d3014 059d2008 (05823000)
---[ end trace 6d46aff735536a73 ]---

Both Oops reports reference paging and of course none should be 
occurring. (mlockall(MCL_CURRENT | MCL_FUTURE)); was called.

They also reference "navigator" which is the name of my rt user task 
which should be running in primary mode until it is told to terminate. 
(No explicit memory allocations are being performed.)
How can I force a core dump when the page fault occurs?
Can I configure the SIGXCPU signal (as generated from 
pthread_set_mode_np(0, PTHREAD_WARNSW); ) to core dump?

Regards,
Bob Feretich



--------------090007070302070109020207
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    I am seeing various Oops reports referencing my rt user task, but
    they don't provide any useful information regarding my program's
    state at the time of the Oops. <br>
    <br>
    The most common Oops is...<br>
    <small><tt>Unable to handle kernel NULL pointer dereference at
        virtual address 0000000c<br>
        pgd = cf02c000<br>
        [0000000c] *pgd=8f8a5031, *pte=00000000, *ppte=00000000<br>
        Internal error: Oops: 17 [#2]<br>
        last sysfs file: /sys/devices/virtual/gpio/gpio7/value<br>
        Modules linked in: rtservo_driver rtasuspidvr [last unloaded:
        rtservo_driver]<br>
        CPU: 0&nbsp;&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp;&nbsp; (2.6.33 #10)<br>
        PC is at do_page_fault+0x40/0x26c<br>
        LR is at do_DataAbort+0x34/0x11c<br>
        pc : [&lt;c002d9d8&gt;]&nbsp;&nbsp;&nbsp; lr : [&lt;c002733c&gt;]&nbsp;&nbsp;&nbsp; psr:
        60000113<br>
        sp : ce8620d8&nbsp; ip : 00000007&nbsp; fp : 00000000<br>
        r10: ce862218&nbsp; r9 : 00000017&nbsp; r8 : 0000000c<br>
        r7 : ce862218&nbsp; r6 : 0000000c&nbsp; r5 : 00000017&nbsp; r4 : ffffffff<br>
        r3 : 00000000&nbsp; r2 : 00000003&nbsp; r1 : 00000017&nbsp; r0 : c0429100<br>
        Flags: nZCv&nbsp; IRQs on&nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; ISA ARM&nbsp; Segment
        user<br>
        Control: 10c5387d&nbsp; Table: 8f02c019&nbsp; DAC: 00000015<br>
        Process navigator (pid: 666, stack limit = 0xce8602e8)<br>
        Stack: (0xce8620d8 to 0xce862000)<br>
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c) from
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c)<br>
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c) from
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60)<br>
        Exception stack(0xce862218 to 0xce862260)<br>
        2200:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        c0429100 00000017<br>
        2220: 00000003 00000000 ffffffff 00000017 0000000c ce8623a0
        0000000c 00000017<br>
        2240: ce8623a0 00000000 00000007 ce862260 c002733c c002d9d8
        60000113 ffffffff<br>
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60) from
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c)<br>
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c) from
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c)<br>
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c) from
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60)<br>
        Exception stack(0xce8623a0 to 0xce8623e8)<br>
        23a0: c0429100 00000017 00000003 00000000 ffffffff 00000017
        0000000c ce862528<br>
        23c0: 0000000c 00000017 ce862528 00000000 00000007 ce8623e8
        c002733c c002d9d8<br>
        23e0: 60000113 ffffffff<br>
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60) from
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c)<br>
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c) from
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c)<br>
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c) from
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60)<br>
        Exception stack(0xce862528 to 0xce862570)<br>
        2520:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0429100 00000017 00000003 00000000
        ffffffff 00000017<br>
        2540: 0000000c ce8626b0 0000000c 00000017 ce8626b0 00000000
        00000007 ce862570<br>
        2560: c002733c c002d9d8 60000113 ffffffff<br>
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60) from
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c)<br>
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c) from
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c)<br>
        [&lt;c002733c&gt;] (do_DataAbort+0x34/0x11c) from
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60)<br>
        Exception stack(0xce8626b0 to 0xce8626f8)<br>
        26a0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0429100 80000007
        00000003 00000000<br>
        26c0: ffffffff c03e3ecc 00000000 ce862838 00000000 80000007
        ce862838 00000000<br>
        26e0: 00000007 ce8626f8 c00272a4 c002d9d8 60000113 ffffffff<br>
        [&lt;c0027bec&gt;] (__dabt_svc+0x4c/0x60) from
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c)<br>
        [&lt;c002d9d8&gt;] (do_page_fault+0x40/0x26c) from
        [&lt;c00272a4&gt;] (do_PrefetchAbort+0x34/0x98)<br>
        [&lt;c00272a4&gt;] (do_PrefetchAbort+0x34/0x98) from
        [&lt;c0027d70&gt;] (__pabt_svc+0x50/0xa0)<br>
        Exception stack(0xce862838 to 0xce862880)<br>
        2820:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        fffffff2 fffffff2<br>
        2840: fffffff2 00000000 00000000 00000000 00000000 00000000
        00000000 00000000<br>
        2860: 00000000 00000000 40044f74 ce862880 40038968 00000000
        a0000113 ffffffff<br>
        [&lt;c0027d70&gt;] (__pabt_svc+0x50/0xa0) from
        [&lt;40038968&gt;] (0x40038968)<br>
        Code: 1a000005 e3cd3d7f e3c3303f e593300c (e593300c) <br>
        ---[ end trace 2f957df7c098c760 ]---</tt></small><br>
    <br>
    Another is...<br>
    <small><tt>Unable to handle kernel paging request at virtual address
        70000049<br>
        pgd = cf034000<br>
        [70000049] *pgd=00000000<br>
        Internal error: Oops: 805 [#1]<br>
        last sysfs file: /sys/devices/virtual/gpio/gpio7/value<br>
        Modules linked in: rtservo_driver rtasuspidvr<br>
        CPU: 0&nbsp;&nbsp;&nbsp; Not tainted&nbsp; (2.6.33 #10)<br>
        PC is at 0x40038998<br>
        LR is at 0x40038984<br>
        pc : [&lt;40038998&gt;]&nbsp;&nbsp;&nbsp; lr : [&lt;40038984&gt;]&nbsp;&nbsp;&nbsp; psr:
        60000113<br>
        sp : cf0f3ff8&nbsp; ip : 00000000&nbsp; fp : 00000001<br>
        r10: 40242c3c&nbsp; r9 : 00000000&nbsp; r8 : 40242c40<br>
        r7 : 000f0042&nbsp; r6 : 40242c40&nbsp; r5 : 402434b0&nbsp; r4 : 00000000<br>
        r3 : 00000a64&nbsp; r2 : 70000049&nbsp; r1 : ffffffab&nbsp; r0 : 00000000<br>
        Flags: nZCv&nbsp; IRQs on&nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; ISA ARM&nbsp; Segment
        user<br>
        Control: 10c5387d&nbsp; Table: 8f034019&nbsp; DAC: 00000015<br>
        Process navigator (pid: 646, stack limit = 0xcf0f22e8)<br>
        Stack: (0xcf0f3ff8 to 0xcf0f4000)<br>
        3fe0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        00000000 00000000<br>
        Code: 0affffe9 e3500000 059d3014 059d2008 (05823000) <br>
        ---[ end trace 6d46aff735536a73 ]---</tt></small><br>
    <br>
    Both Oops reports reference paging and of course none should be
    occurring. (mlockall(MCL_CURRENT | MCL_FUTURE)); was called.<br>
    <br>
    They also reference "navigator" which is the name of my rt user task
    which should be running in primary mode until it is told to
    terminate. (No explicit memory allocations are being performed.)<br>
    How can I force a core dump when the page fault occurs?<br>
    Can I configure the SIGXCPU signal (as generated from
    pthread_set_mode_np(0, PTHREAD_WARNSW); ) to core dump?<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    <br>
  </body>
</html>

--------------090007070302070109020207--

