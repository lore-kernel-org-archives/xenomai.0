Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <490482DC.5040402@domain.hid>
Message-Id: <20081026144351.950914436@domain.hid>
Date: Sun, 26 Oct 2008 15:43:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/3] x86: Fix & update NMI watchdog
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This series reanimates the NMI watchdog support for current x86 CPUs.
It adds the required bits for Intel Core2 (and probably later)
performance counters, fixes an overflow condition for P6 perf-counters,
adds x86-64 support, and comes with a more robust NMI reason detection +
pass-through for other events. The latter allows to use the NMI watchdog
together with KGDB.

As usual, the series /may/ cause build (or even runtime) regressions for
untested platforms. These are: kernel 2.4, x86-32. Feedback and/or
corrections appreciated!

Jan


