Message-ID: <472369C3.1020605@domain.hid>
Date: Sat, 27 Oct 2007 18:39:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4-rc5
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
To: xenomai-core <xenomai@xenomai.org>, xenomai@xenomai.org


Here is the fifth candidate release for the v2.4.x branch.

	[nucleus]

	* Enforce CPU affinity unconditionally.
	* Allow for daisy chains of periodic tick handlers.
	* Fix rounding and minimum value of mappable heap size.

	[blackfin]

	* Upgrade Adeos support to 2.6.23.
	* Add support for the bf561.

	[powerpc]

	* Update Adeos support for 2.6.20 and 2.6.23.

	[i386]

 	* Update Adeos support for 2.6.20, 2.6.22 and 2.6.23.

	[x86_64]

	* Fix the interrupt filter when the shield is in effect.
 	* Update Adeos support for 2.6.22 and 2.6.23.

	[testsuite]

	* Freeze the current trace path upon receipt of a fault
          signal.

http://download.gna.org/xenomai/testing/xenomai-2.4-rc5.tar.bz2

-- 
Philippe.

