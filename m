From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 10:50:31 +0200
Message-Id: <1192524631.6045.23.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4-rc4
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


Here is the fourth candidate release for the v2.4.x branch. With the
v2.3.x maintenance cycle soon coming to an end after nearly a year since
it has started, v2.4 is going to be our next stable branch for quite
some time, so I would suggest that you make sure it can run your
favourite board(s) _now_.

	[nucleus]

	* Fix /proc support for timebases.

	[posix]

	* Fix random hang in per-process cleanup code.

	[native]

	* Fix double free issue upon failure to create a new task.

	[vxworks]

	* Fix implementation of watchdog support in user-space.
	* Fix double free issue upon failure to create a new task.

	[vrtx]

	* Fix double free issue upon failure to create a new task.

	[rtdm]

	* Add private data pointer to the rtdm_device structure.

	[can]

	* Support new resource management of arch/powerpc tree properly.
	* Fix handling of the "port" module parameter.

	[testsuite]

	* Prevent overflow in timer handler test.
	* Close race window in timer setup code.

	[powerpc]

	* Update Adeos support for 2.6.20.
	* Upgrade Adeos support to 2.6.23.

	[i386]

	* SMI: Detect ICH-4 chipsets.
	* Sanitize calibration code.
	* Fix timer setup code (mostly for GENERIC_CLOCKEVENTS, but not only).
 	* Upgrade Adeos support to 2.6.23.

	[x86_64]

	* SMI: Detect ICH-4 chipsets.
	* Sanitize calibration code.
 	* Upgrade Adeos support to 2.6.23.

http://download.gna.org/xenomai/testing/xenomai-2.4-rc4.tar.bz2

-- 
Philippe.



