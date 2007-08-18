From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sat, 18 Aug 2007 12:17:33 +0200
Message-Id: <1187432253.5977.56.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4-rc2
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


Here is the second candidate release for the v2.4.x branch. Short log
follows:

	[nucleus]

	* Fix shared interrupt support.
	* Fix RPI-disabled build.
	* IPI annotation in /proc/xenomai/irq.

	[native]

	* Add task exectime, context and mode switches as well as a
	  count of page faults to RT_TASK_INFO.

	[rtdm]

	* Fix up asymmetric close() invocations silently by switching
	  to non-RT mode.
	* Run sparse: several pacifications.

	[can]

	* Remove config	options XENO_DRIVERS_CAN_SJA1000_*_MAX_DEV.

	[16550A]

	* Fix potential race in rt_16550_close().

	[posix]

	* Forbid use of non process-shared objects outside of the
	  process to which they belong.

	* Only enable process check for performance critical functions
	  if debugging is enabled.

	[powerpc32]

	* Update Adeos support for 2.6.20.
	* Upgrade Adeos support to 2.6.21, powerpc/ tree.

	[powerpc64]

	* Add support for PASEMI's PA6T dual core platform.
	* Upgrade Adeos support to 2.6.22-rc5, powerpc/ tree.

	[i386]

	* Update Adeos support for both 2.6.20 and 2.6.22.
	* Upgrade Adeos support to 2.6.23-rc2.

	[x86_64]

	* Update Adeos support for 2.6.22.

	[arm]

	* Rework user-space access to TSC emulation.
	* Update Adeos support for 2.6.20.

In addition, library revision numbers for the posix, rtdm and native
skins have been increased.

http://download.gna.org/xenomai/testing/xenomai-2.4-rc2.tar.bz2

PS: I'm going to be off-line for a week.

-- 
Philippe.



