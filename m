Message-ID: <b054e88e0810291200l51eb2c84g2c3a6277d35e0344@domain.hid>
Date: Wed, 29 Oct 2008 20:00:43 +0100
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15263_31306338.1225306843224"
Subject: [Xenomai-help] testsuite/clocktest hangs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_15263_31306338.1225306843224
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
  I am running some tests on my mpc5200b board running Xenomai 2.4.5 with
kernel DENX-2.6.25. When I run the clocktest program, it hangs after a
variable period of time. Xenomai's watchdog recognizes it as a runaway task,
and gdb tells that thread 1 is hanging at nanosleep(). Same behaviour with
DENX-2.6.26

Here's the output of gdb:

Program received signal SIGINT, Interrupt.
[Switching to Thread 0x48024d90 (LWP 352)]
0x0fe1ebb8 in nanosleep () from /lib/libc.so.6
(gdb) thread 1
[Switching to thread 1 (Thread 0x48024d90 (LWP 352))]#0  0x0fe1ebb8 in
nanosleep () from /lib/libc.so.6
(gdb) bt
#0  0x0fe1ebb8 in nanosleep () from /lib/libc.so.6
#1  0x0fe4bea0 in usleep () from /lib/libc.so.6
#2  0x1000259c in main (argc=1, argv=0xbfa6eb84) at clocktest.c:243
(gdb)

Thank you

Giammarco

------=_Part_15263_31306338.1225306843224
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all,<br>&nbsp; I am running some tests on my mpc5200b board running Xenomai 2.4.5 with kernel DENX-2.6.25. When I run the clocktest program, it hangs after a variable period of time. Xenomai&#39;s watchdog recognizes it as a runaway task, and gdb tells that thread 1 is hanging at nanosleep(). Same behaviour with DENX-2.6.26<br>


<br>Here&#39;s the output of gdb:<br><br>Program received signal SIGINT, Interrupt.<br>[Switching to Thread 0x48024d90 (LWP 352)]<br>0x0fe1ebb8 in nanosleep () from /lib/libc.so.6<br>(gdb) thread 1<br>[Switching to thread 1 (Thread 0x48024d90 (LWP 352))]#0&nbsp; 0x0fe1ebb8 in nanosleep () from /lib/libc.so.6<br>


(gdb) bt<br>#0&nbsp; 0x0fe1ebb8 in nanosleep () from /lib/libc.so.6<br>#1&nbsp; 0x0fe4bea0 in usleep () from /lib/libc.so.6<br>#2&nbsp; 0x1000259c in main (argc=1, argv=0xbfa6eb84) at clocktest.c:243<br>(gdb) <br><br>Thank you<br><br>Giammarco<br>
</div>

------=_Part_15263_31306338.1225306843224--

