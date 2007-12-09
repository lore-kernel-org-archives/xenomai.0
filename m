Message-ID: <475BD389.5040909@domain.hid>
Date: Sun, 09 Dec 2007 12:37:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.3.5
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
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


Here is the latest release from the v2.3.x branch. Short log follows:

	[nucleus]

	* Fix broken select() on a message pipe.
	* Fix computation of overhead due to heap meta-data.
	* Properly recycle empty bucketed pages to the free list.
	* Sanitize heap size rounding at call sites.

	[posix]

	* Fix pthread_cond_wait().

	[native]

	* Fix rt_queue_read() error path causing unexpected message
          deletion.

	[can]

	* Support CONFIG_PPC_MERGE for resource management.

	[powerpc]

	* Integrated 32/64bit I-pipe support against 2.6.23/powerpc
          (i.e. CONFIG_PPC_MERGE).
        * Backported 32bit I-pipe support against 2.6.23/ppc.
	* Add a set of EVB-specific calibration values.

	[arm]

	* Upgrade to I-pipe 2.6.20/1.8 series.

	[i386]

	* Upgrade to I-pipe 2.6.20.21/1.11 series.

	[blackfin]

	* Combined bf5xx support (bf533, bf537, bf561) against 2.6.23.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.3.5.tar.bz2

-- 
Philippe.

