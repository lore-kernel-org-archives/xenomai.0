From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 29 Jul 2007 16:20:09 +0200
Message-Id: <1185718809.11350.110.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4-rc1
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


Here is the first candidate release for the v2.4.x branch, on the road
to 2.4 final.  The following short log only lists the most significant
evolutions; a slew of optimizations, cleanups and bug fixes all over the
place come with this release as well:

	[nucleus]

	* Introduction of timebases, by which software timers that
	  belong to different skins may be clocked separately
	  according to distinct frequencies, or aperiodically.
	  Practically, this means that it is now possible to run all
	  skins concurrently, regardless of their internal timing mode.
	  Adds /proc/xenomai/timebases, /proc/xenomai/timerstat.
	* Make all skins runnable over a central core pod.
	* Support RT capability group for controlling access to Xenomai
	  services.
	* Support aperiodic Linux host tick (clock_event) and tickless
	  kernels (the nucleus host timer is now a per-cpu object).
	* Refactor timer modes.
	* Sync absolute timers when updating the epoch (POSIX conformance).
	* Fix deadlock and task migration issues in RPI support.
	* Sanitize deletion path of shadow threads.
	* Sanitize SMP locking in interrupt management.
	* Flatten the interrupt handling path.
	* Support O_SYNC open mode with message pipes, for guaranteed
	  synchronous writes from a secondary mode sender to a primary
	  mode receiver.
	* Optimize arch-specific arithmetics.
	* Provide for a global CPU affinity mask applicable to all
	  Xenomai threads. Adds /proc/xenomai/affinity.

	[posix]

	* Various fixes and updates. Latency optimizations.

	[native]

	* Add auto-cleanup support (automatic orphan resource/object
	  reclaiming upon task/module exit).
	* Allow cross-API calls to blocking services.

	[psos]

	* Emulate timer-related syscalls (tm_*).
	* Extend as_send() call to user-space receivers (emits
	  SIGRTxx).
	* Extend t_mode() call to support Xenomai modes (i-shield,
	  warn-switch, rpi-state).
	* Add auto-cleanup support.
	* Allow long names in object creation routines.

	[vrtx]

	* Deep refactoring.

	[uitron]

	* Even more deep refactoring. Add user-space support.

	[rtai]

	* Emulate rt_heap calls.

	[rtdm]

	* Various fixes and updates.

	[rtdk]

	* Introduce a collection of utilities aimed at forming a
	  Real-Time Development Kit for userland usage. Starts with
	  a set of non-intrusive (latency-wise) *printf() services.

	[16550]

	* Allow memory-mapped hardware access.

	[can]

	* Better support for bus error processing at user level.
	* Allow for inverted CAN filter setup (CAN_INV_FILTER).
	* Various fixes and updates.

	[arm]

	* Add support for AT91 platforms. 
	* Add EABI support.
	* Provide for TSC reading from user-space.

	[powerpc]

	* Upgrade support to 2.6.20, powerpc tree/.

	[i386]

	* Upgrade support to 2.6.22.
	* Sanitize LAPIC handling.

	[Blackfin]

	* Upgrade support to 2.6.19.

	[x86_64]

	* New architecture support.

	[testsuite]

	* New test measuring clock drift and inter-CPU time consistency.

As a sidenote, please note that this branch will be the first one to
support the latest Linux kernels (>= 2.6.22).

See the ChangeLog for details.

http://download.gna.org/xenomai/testing/xenomai-2.4-rc1.tar.bz2

-- 
Philippe.



