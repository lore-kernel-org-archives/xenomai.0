From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 17 Dec 2006 17:38:30 +0100
Message-Id: <1166373510.7818.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.3-rc3
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


Here is the third candidate release for the v2.3.x branch. This is
intended to be last release candidate before final, so make sure to
have a look to the platform/architecture/feature you are interested
in.

Short log follows:

	[nucleus]

	* Decouple lock debugging from runtime stats activation.

	* Enhance granularity of debug options. Generalize the use of
	debug assertions.

	* Add memory barriers to shared IRQ support code manipulating
	reference counts.

	* Reinstate i/o permissions when transitioning from secondary
	to primary mode (x86).

	* Prevent non-mapped threads for running xnshadow_unmap.

	[vxworks, vrtx, rtai] Add missing checks for the XNBREAK
	condition.

	[vxworks] Fix arg passing at (user-space) task creation.

	[vrtx] Free heap control block memory when released.

	[psos] Implement direct syscall interface.

	[posix]

	* Fix random fault in user-space at thread creation.

	* Fix return value of sem_timed_wait.

	* Generalize the use of debug assertions.

	[native]

	* Add rt_mutex_lock/rt_mutex_unlock wrappers.

	* Make rt_queue_inquire return the amount of pool memory used.

	[drivers/can]

	* core: Various updates. Add TX loopback support to local
	sockets. Add empty filter support through setsockopt.

	* sja1000: Add support for IXXAT PCI cards.

	[rtdm] Minor updates.

----

See the ChangeLog for details.

http://download.gna.org/xenomai/testing/xenomai-2.3-rc3.tar.bz2

-- 
Philippe.



