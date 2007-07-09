From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Mon, 09 Jul 2007 19:30:52 +0200
Message-Id: <1184002252.6014.116.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.3.2
Reply-To: rpm@xenomai.org
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

Here is the latest maintenance release for the v2.3.x branch.  Short
log follows:

	[nucleus]
	* Always defer release of TCB memory.
	* Sanitize support for machine-dependent arithmetics.
	* Fix root priority boosting with XENO_OPT_SCALABLE_SCHED.
	* Fix /proc/xenomai/{sched, stat} locking in output loop.
	* Fix lethal bug in SIGIO processing (SMP).
	* Yet another interrupt locking fix.
	* Handle RT capability group.
	* Fix CPU affinity tracking (SMP).
	* Fix 64bit portability issue.

	[psos]
	* Fix potentially unsafe dereference of task args in
	  t_create() (user-space).
	* Conformance fix for ERR_TATRNDEL and ERR_TATSDEL error
	  conditions.

	[native]
	* Reschedule upon alarm deletion.
	* Force T_PRIMARY into the mask returned by rt_task_set_mode().

	[posix]
	* mq: copy the priority of received messages back to
	  user-space.
	* clock: access TSC directly from user-space when support
	  is available.

	[rtai]
	* Add support for rt_heap_open() and rt_heap_close().

	[vrtx]
	* Fix 64bit portability issue.

	[can]
	* Assorted fixes (e.g. PEAK PCI).

	[16550A]
	* Catch spurious baud rate.

	[arm]
	* Upgrade to kernel 2.6.20.
	* Various updates for at91.

	[blackfin]
	* Upgrade to bf53x-R0701RC3-1.6-01 (2.6.19).
	* Work around toolchain bug while reading TSC from user-space.

	[powerpc]
	* Sync with DENX's CVS for 2.4.25-ppc.

	[i386]
	* Upgrade I-pipe support (2.6.20-1.8 series).


See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.3.2.tar.bz2

-- 
Philippe.



