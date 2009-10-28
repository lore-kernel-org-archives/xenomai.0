MIME-Version: 1.0
Date: Wed, 28 Oct 2009 15:34:49 +0100
Message-ID: <b88603c30910280734i7a823063s75b420720fdf3707@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Read TSC results in bus error (ARM iMX25)
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

I'm trying to bringup Xenomai 2.4.9.1 on a freescale iMX25 board and
linux kernel 2.6.28. Until now all was straightforward by following
the ArmPorting page on the Xenomai website and because the iMX25 is
very similar to the already supported iMX3. The kernel boots and the
xenomai timer is running.

However the testsuite apps (latency) are not working because the
rt_timer_tsc() call results in a Bus error: 'Unhandled fault: external
abort on non-linefetch (0x008) at 0x4001f024)'.

I verified at the xeno_arm_features_check() call the physical address
of the GPT1 counter register is correct (0x53f90024 which matches the
datasheet). The mmap call succeeds and the virtual address is at
0x4001f024. However, when de-referencing that pointer in the
__xn_rdtsc() call the bus error occurs.

Anyone have an idea what I am missing?

Thanks,
Henri

