Message-ID: <47B03453.4030205@domain.hid>
Date: Mon, 11 Feb 2008 12:41:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4.2
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


Here is the second maintenance release for the v2.4.x branch.  Short
log follows:

	[x86]

	* Fix tick interrupt setup and related accounting when
          CONFIG_GENERIC_CLOCKEVENTS is disabled.

	* Fix race when releasing the timer.

	* Update Adeos support for 2.6.20.21/i386, 2.6.23/i386 and
          2.6.23/x86_64.
	* Upgrade Adeos support to 2.6.24/x86 final.

	[powerpc]

	* Update Adeos support for 2.6.20/powerpc and 2.6.23/powerpc.
	* Upgrade Adeos support to 2.6.24/powerpc over
          DENX-v2.6.24-stable (all-in-one patch also supporting the
          legacy ppc32 arch).

	[16550]

	* Set correct bit in IER to enable modem status IRQs.

	[clocktest]

	* Fix soft-lockups due to randomization of measurement thread
          delays.
	* Avoid	races when storing time warps.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.2.tar.bz2

-- 
Philippe.

