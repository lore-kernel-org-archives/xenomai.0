Message-ID: <43FA139D.9020906@domain.hid>
Date: Mon, 20 Feb 2006 20:08:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.1-rc3
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


Here is -rc3, the dust is settling down now. For this release, we
have been working on the following issues:

o Generic 64-bit arithmetic support [Gilles]
o More powerpc 32/64 merging [Heikki]
o Native API updates [Jan, Gilles, me]
o POSIX API updates [Gilles]
o RTDM updates [Jan]
o Blackfin port upgraded to uClinux 2005R4-RC2 [me]
o 2.4 fixes for both ppc and x86 [Wolfgang, me]
o Adeos updates for x86, ia64 and ARM

See the ChangeLog for details as usual.

Two patches remain to be merged before -final, namely:

o Dmitry's shared IRQ support.
o Gilles's scalable timers extension.

After that, and the usual set of last minute "can't live without this
one" fixes, v2.1 should be ready for prime time.

http://download.gna.org/xenomai/testing/xenomai-2.1-rc3.tar.bz2

-- 

Philippe.

