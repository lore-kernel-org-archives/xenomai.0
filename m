From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 09 Sep 2007 23:22:17 +0200
Message-Id: <1189372937.6013.48.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4-rc3
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


Here is the third candidate release for the v2.4.x branch. Most of the
work since -rc2 was aimed at optimizing the interrupt pipeline, and
first and foremost at reducing its cache footprints, initially for the
powerpc and x86 ports. Other archs will be upgraded next. The powerpc
arch also gains a combined 32/64bit support starting with 2.6.22. Short
log follows:

	[nucleus]

	* Make the watchdog timeout value configurable.
	* Remove preprocessor warnings from 2.4 builds.
	* Always get references to per-cpu sched struct within
	  migration-free sections.

	[rtdm]

	* Round up timeouts and delays when nanoseconds are to be
	  converted to ticks (periodic timebase only).

	[can]

	* Fix race upon socket list update.
	* RT-Socket-CAN SJA1000 driver for the EMS CPC PCI card
	  (http://www.ems-wuensche.de).

	[powerpc]

	* Merge 32/64bit arch support into a single Adeos patch for 2.6.22
	  (I-pipe 2.0 series, DENX tree: DENX-2007-08-30-1748).
	* Upgrade combined Adeos support to 2.6.23-rc5 (DENX tree, git
	  HEAD).
	* PA-Semi (powerpc64) updates.
	* Update Adeos/powerpc32 support for 2.6.20; forward port to
	  2.6.21.

	[i386]

	* Release tick device in the non-LAPIC case (kernel >= 2.6.22).
	* Upgrade Adeos support for 2.6.22 (I-pipe 1.10 series).

We still have a few reported bugs pending and some I-pipe updates for
the Blackfin, ARM and x86_64 ports to come too, so we will need -rc4.

http://download.gna.org/xenomai/testing/xenomai-2.4-rc3.tar.bz2

-- 
Philippe.



