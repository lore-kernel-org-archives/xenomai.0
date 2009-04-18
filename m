From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sat, 18 Apr 2009 19:56:35 +0200
Message-Id: <1240077395.26554.169.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.5-rc1
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


Here is the first candidate release for the v2.5.x branch.  The
following short log only lists the most significant evolutions. Lots
of optimizations, cleanups and bug fixes all over the map.

	[nucleus]

	* Introduce extensible scheduler framework based on scheduling
          classes.
	* Introduce temporal partitioning scheduling class (TP).
	* Introduce POSIX sporadic server scheduling class (PSS).
	* Refactor round-robin scheduling class (RR).
	* Allow round-robin scheduling over aperiodic timing.
	* Introduce fast synchronization object to support fast
          real-time mutexes in user-space.
	* Introduce support for unlocked context switching.
	* Introduce key-less anonymous object registration.
	* Remove interrupt shield support (former
          CONFIG_XENO_OPT_ISHIELD).
	* Introduce debug option to detect mutexes held in relaxed
	  sections (CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX).
	* Optimize time/tsc conversion (replace divisions with reciprocal
          multiplications)

	[native]

	* Introduce fast real-time mutexes in user-space.
	* Introduce FIFO monitoring (rt_pipe_monitor).
	* Extend rt_task_inquire() to return the task name.
	* Introduce a new set of services providing timeouts as
	  absolute timespecs (i.e. rt_*_until()).

	[posix]

	* Introduce fast real-time mutexes in user-space.

	[comedi]

	* Introduce RTDM-based Comedi interface support. This is work
          in progress.

	[vxworks]

	* Introduce taskInfoGet().
	* Various fixes.

	[psos]

	* Various fixes.

	[vrtx]

	* Various fixes.
	* Streamline mutex support.

	[testsuite]

	* Introduce unit tests for internals.
	* Complete coverage of switchtest.

	[generic]

	* Use new I-pipe's fast ops for IRQ propagation when present.

	[powerpc]

	* Introduce optimized arithmetics for time manipulation.
	* Introduce support for the MPC5121-ADS platform.
	* Upgrade support to 2.6.29.

	[blackfin]

	* Enable generic stack pool for kernel theads.
	* Introduce optimized arithmetics for time manipulation.
	* Upgrade support to 2.6.28.

	[arm]

	* Introduce optimized arithmetics for time manipulation.
	* Introduce VFP support.
	* Introduce support for the MXC family.
	* Upgrade support to 2.6.28.

	[x86]

	* Fix and optimize FPU handling.
	* Rework NMI support.
	* Upgrade support to 2.6.29.

	[ia64]

	* Support discontinued.

	[rtdk]

	* Various fixes and cleanups.
	* Introduce assert_context wrappers for early detection of
          Linux syscalls invoked from primary mode.

	[debian]

	* allow dpkg-cross to cross-compile binary packages.

http://download.gna.org/xenomai/testing/xenomai-2.5-rc1.tar.bz2

-- 
Philippe.



