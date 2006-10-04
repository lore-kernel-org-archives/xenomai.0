MIME-Version: 1.0
Message-ID: <OFEF08EF89.60F083EE-ONC12571FD.003F2533-C12571FD.00429C50@domain.hid>
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Date: Wed, 4 Oct 2006 14:07:33 +0200
Content-Type: text/plain; charset="US-ASCII"
Subject: [Xenomai-core] Please remove "-I." in "xeno-config --*-cflags
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

Hi,

setting "-I." in the compiler flags in scripts/xeno-config.in
messes up the include file search order of the compiler,
and i can't see any good reason for it to be there. the
other flags except the xenomai include-path and the
defines are questionable, too. At least "-Wall" and
"-pipe" should be left to the programmer of the
application.

(xenomai versions 2.2.0 + 2.2.3)


Thanks,
Thomas Wiedemann

