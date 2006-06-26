From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 11:34:22 +0200
Message-Id: <1151314462.6626.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2-rc3
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


Ok, five weeks is far too long between release candidates and we'll
try to shorten that, but still, the number of issues closed by -rc3 is
worth the delay. Significant POSIX skin updates, KGDB support merged
for x86, and another ARM port, this one over the iMX21, are among the
goodies. Here is the short log:

Dmitry Adamushko:

	* nucleus: Fix synch. object ownership stealing.

Alexis Berlemont:

	* rtdm: Add support for	mapping vmalloc'ed memory.

Gilles Chanteperdrix:

	* HAL/i386: Fix alignment issue of NMI support with GCC 4.1.

	* nucleus: Properly handle module locking/unlocking to prevent
	unsafe unloads. Add a regular syscall table for handling
	internal nucleus syscalls. Add per-process cleanup handlers.

	* vxworks: Conformance fixes.

	* posix: Close race window in several syscall wrappers.
	Add support for user-space mutex and condition variable
	attributes. Cleanup per-process objects on process
	termination. Add support for the SCHED_NORMAL policy.
	Rework allocation in shared memory support.

	* testsuite: Add context switch unit test.

Jim Cromie:

	* scripts: Various cleanups and improvements.

Niklaus Giger:

	* scripts: Better busybox support. Provide test script to
	maintainers.

Jan Kiszka:

	* HAL/ia64: Leverage pipeline head optimization.

	* HAL/i386: Enable KGDB support.

	* nucleus: Allow creation of non real-time Xenomai-enabled
	threads. Improve binary heap management for timers.

Heikki Lindholm:
	
	* testsuite: implement Power PC FPU testing routines.

Daniel Rossier:

	* Adeos/arm: Add support for the Freescale iMX21/csb535fs board.

Philippe Gerum:

	* Adeos/blackfin: Upgrade to R06R1RC2 and CVS-20060625.

	* Adeos/i386: Fix 2.4 compilation w/ GCC 3.4. Upgrade 2.6
	support.

	* nucleus: Add XNPIPEIOC_SETSIG.

	* vrtx: Extend user-space support.

	* testsuite: Fix sched_setaffinity() issue.

-----

See the ChangeLog for details.

http://download.gna.org/xenomai/testing/xenomai-2.2-rc3.tar.bz2

-- 
Philippe.



