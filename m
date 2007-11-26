Message-ID: <474ADEDB.3040700@domain.hid>
Date: Mon, 26 Nov 2007 15:57:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4-rc7
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
To: xenomai-core <xenomai@xenomai.org>, xenomai-help <xenomai@xenomai.org>


Here is the seventh candidate release for the v2.4.x branch. This
should be the last one before 2.4.0.

	[nucleus]

	* Clear wchan when failing to suspend a thread due to
          preposterous timeout value.
	* Report configured timer and clock device.
	* Recycle empty bucketed pages to the global free page list.

	[powerpc]

	Update Adeos support for 2.6.20.

	[arm]

	Upgrade Adeos support to the 1.8 series.

	[x86]

	Rebase Adeos/2.6.20 support on the stable series (2.6.20.21).
	Upgrade Adeos/i386 support for 2.6.20.x and 2.6.23.
	Upgrade Adeos/x86_64 support for 2.6.23.

	[posix]

	* Fix mq_timedsend() in case no receiver is present.
	* Fix error paths upon failure to init skin.

	[debian]

	* Adapt to x86* merge.

http://download.gna.org/xenomai/testing/xenomai-2.4-rc7.tar.bz2

-- 
Philippe.

