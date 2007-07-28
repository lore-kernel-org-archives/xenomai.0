From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sat, 28 Jul 2007 19:36:45 +0200
Message-Id: <1185644205.11350.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.3.3
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


Here is the latest maintenance release for the v2.3.x branch.  Short
log follows:

	[nucleus]
	* Fix deadlock and migration issues in RPI support.
	* Sanitize deletion path of shadow threads.

	[powerpc]
	* Upgrade to kernel 2.6.20, powerpc/ tree.

	[arm]
	* Add EABI support.
	* Adeos update (I-pipe 2.6.20-1.7-04).

	[i386]
	* Adeos update (I-pipe 2.6.20-1.8-06)

	[native, psos, vxworks, vrtx, uitron]
	* Generalize use of container_of() to fix 64bit warnings.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.3.3.tar.bz2

-- 
Philippe.



