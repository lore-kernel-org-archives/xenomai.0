Message-ID: <49097E14.8050708@domain.hid>
Date: Thu, 30 Oct 2008 10:27:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b054e88e0810291200l51eb2c84g2c3a6277d35e0344@domain.hid>
In-Reply-To: <b054e88e0810291200l51eb2c84g2c3a6277d35e0344@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] testsuite/clocktest hangs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Giammarco Zacheo wrote:
> Hi all,
>   I am running some tests on my mpc5200b board running Xenomai 2.4.5 with
> kernel DENX-2.6.25. When I run the clocktest program, it hangs after a
> variable period of time. Xenomai's watchdog recognizes it as a runaway task,
> and gdb tells that thread 1 is hanging at nanosleep(). Same behaviour with
> DENX-2.6.26
> 
> Here's the output of gdb:
> 
> Program received signal SIGINT, Interrupt.
> [Switching to Thread 0x48024d90 (LWP 352)]
> 0x0fe1ebb8 in nanosleep () from /lib/libc.so.6
> (gdb) thread 1
> [Switching to thread 1 (Thread 0x48024d90 (LWP 352))]#0  0x0fe1ebb8 in
> nanosleep () from /lib/libc.so.6
> (gdb) bt
> #0  0x0fe1ebb8 in nanosleep () from /lib/libc.so.6
> #1  0x0fe4bea0 in usleep () from /lib/libc.so.6
> #2  0x1000259c in main (argc=1, argv=0xbfa6eb84) at clocktest.c:243
> (gdb)

Could you try latest clocktest.c from SVN (2.4.x or trunk)? I fixed a
very similar issue recently, but I'm not sure if it applies to your
scenario.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

