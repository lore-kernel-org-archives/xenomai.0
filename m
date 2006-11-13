From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 13 Nov 2006 08:08:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611130808.37195.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Cannot compile sim with "make --jobs=4"
Reply-To: niklaus.giger@domain.hid
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

Hi Gilles

I just noticied that compiling the simulator with "make --jobs=4 clean all 
check" led errors like:

/bin/sh ../libtool --tag=CXX --mode=link g++  -O2   -o 
libmvmutils.la -rpath /usr/xenomai/lib -version-info 1:0:0 
libmvmutils_la-clock.lo libmvmutils_la-elf.lo libmvmutils_la-hash++.lo 
libmvmutils_la-interface.lo libmvmutils_la-list++.lo libmvmutils_la-object.lo 
libmvmutils_la-statobj.lo libmvmutils_la-string++.lo 
libmvmutils_la-tclist++.lo libmvmutils_la-utils.lo
libtool: link: `libmvmutils_la-clock.lo' is not a valid libtool object

No big deal, I just reverted to the default make --jobs=1, but just wanted you 
let it know.

BTW. I still get the errors:
Some problems were reported in:
vxworks/testsuite/t010823-2.c:163: Expected sequence: SEQ("Test2",2004); got 
SEQ("Test2",1999)
vxworks/testsuite/t010823-2.c:166, test finished: 1 failures/ 33 tests

Best regards

-- 
Niklaus Giger

