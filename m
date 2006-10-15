From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 23:32:19 +0200
Message-Id: <1160947939.4962.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2.4
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


Here is the fourth maintenance release for the v2.2.x branch.  Short
log follows:

	[nucleus]

	* Raise XNBREAK as required when resuming a forcibly suspended
	shadow thread upon Linux signal receipt.

	* Rework the watchdog implementation, so that it does not
	depend on the Linux tick to be relayed through the nucleus
	(e.g. CONFIG_X86_LOCAL_APIC). Export the watchdog status
	to /proc/xenomai/timer.

	* Fix __xn_copy_from/to_user() so that none of their arguments
	could be shadowed by the internal variable used to hold the
	return value. This issue affects _all_ architectures.

	* x86: partially revert commit #1595 to fix FPU
	management regression issues that surfaced in 2.2.3.
	Fix CONFIG_PCI_MSI issue by upgrading to Adeos
	2.6.17-1.5-00.

	* blackfin: Sync with Blackfin's CVS head as of 2006-10-08.

	[hal]

	* powerpc: Fix computation of periodic tick value to prevent
	32bit arithmetic overflow. Add Adeos support for Linux 2.6.18.

	* blackfin: Upgrade generic Adeos support to the latest
	release.

	* arm: Fix syscall propagation issue with previous Adeos
	1.5-00 release.

	[uvm]

	* Iron context switch emulation to prevent spurious wakeups
	upon Linux signal receipts.

	[posix]

	* Add missing wrapper to __real_pthread_getschedparam().

	[rtdm]

	* Fix return value from copy_to/from_user().

	[psos]

	* Fix size information passed to internal msgQLib
	routines.

	* Reschedule after task mode change (t_mode).


As a sidenote, you will notice that the latest Adeos patches for i386,
powerpc and Blackfin are bigger than they used to; this is due to the
integration of the I-pipe tracer feature into the standard Adeos
support, that used to live in a separate patch up to now. This feature
is currently forcibly disabled for the Blackfin architecture though,
since it is not fully functional yet, but this should improve with the
next releases.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.2.4.tar.bz2

-- 
Philippe.



