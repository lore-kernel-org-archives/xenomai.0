From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 16 Sep 2007 18:52:14 +0200
Message-Id: <1189961534.25006.205.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.3.4
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


Here is the latest release from the stable tree.  Several Adeos
patches have been updated due to a nasty bug that may lock out hw
interrupts unexpectedly when dumping the pipeline trace buffers
(CONFIG_IPIPE_TRACE=y) using the /proc interface; update is strongly
recommended if you rely on the tracer for debugging. Short log
follows:

	[nucleus]

	* Make the watchdog timeout value configurable
	* Fix build with CONFIG_XENO_OPT_RPIDISABLED=n
	* Fix shared interrupt handling.

	[native, vxworks, vrtx]

	* Fix double TCB memory release upon task mapping error.

	[can]

	* Fix race upon socket list update.

	[powerpc]

	* Make sure rthal_thread_switch() is properly paired with
	  Linux's switch_to() (return value fix for ppc64).
	* Adeos update (I-pipe 2.6.20-1.6-04, 2.6.21-1.6-04)

	[arm]

	* Adeos update (I-pipe 2.6.20-1.7-06).

	[i386]

	* Adeos update (I-pipe 2.6.20-1.8-08).

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.3.4.tar.bz2

-- 
Philippe.



