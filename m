Message-ID: <455835FF.7000003@domain.hid>
Date: Mon, 13 Nov 2006 10:08:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Cannot compile sim with "make --jobs=4"
References: <200611130808.37195.niklaus.giger@domain.hid>
In-Reply-To: <200611130808.37195.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi Gilles
> 
> I just noticied that compiling the simulator with "make --jobs=4 clean all 
> check" led errors like:
> 
> /bin/sh ../libtool --tag=CXX --mode=link g++  -O2   -o 
> libmvmutils.la -rpath /usr/xenomai/lib -version-info 1:0:0 
> libmvmutils_la-clock.lo libmvmutils_la-elf.lo libmvmutils_la-hash++.lo 
> libmvmutils_la-interface.lo libmvmutils_la-list++.lo libmvmutils_la-object.lo 
> libmvmutils_la-statobj.lo libmvmutils_la-string++.lo 
> libmvmutils_la-tclist++.lo libmvmutils_la-utils.lo
> libtool: link: `libmvmutils_la-clock.lo' is not a valid libtool object
> 
> No big deal, I just reverted to the default make --jobs=1, but just wanted you 
> let it know.

Maybe the simulator is configured by default with --disable-libtool-lock  ?

> 
> BTW. I still get the errors:
> Some problems were reported in:
> vxworks/testsuite/t010823-2.c:163: Expected sequence: SEQ("Test2",2004); got 
> SEQ("Test2",1999)
> vxworks/testsuite/t010823-2.c:166, test finished: 1 failures/ 33 tests

Ok, I think I will remove this test.

-- 
                                                 Gilles Chanteperdrix

