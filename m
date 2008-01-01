Message-ID: <477A7E66.90903@domain.hid>
Date: Tue, 01 Jan 2008 18:54:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4.1
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


Here is the first maintenance release for the v2.4.x branch.  Short
log follows:

	[nucleus]

	* Close SMP race window in message pipe's read-side.
	* Prevent the task startup completion code to hold the nucleus
          lock.

	[psos]

	* Fix t_mode().

	[native]

	* Fix auto-cleanup issue of I/O regions in non-pervasive mode.

	[can]

	* Fix device deregistration when refcounting is disabled.
	* Fix build issue with shared interrupt support.

	[powerpc]

	* Update Adeos support for 2.6.20/powerpc and 2.6.23/powerpc.

	[x86]

	* Update Adeos support for 2.6.20/i386, 2.6.23/i386 and
          2.6.23/x86_64.
	* Upgrade Adeos support to 2.6.24-rc6 (I-pipe 2.0/x86 series
          with combined i386+x86_64 support).

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.1.tar.bz2

Best wishes to everyone for 2008.

-- 
Philippe.

