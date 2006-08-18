From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.50472.580142.331066@domain.hid>
Date: Fri, 18 Aug 2006 15:48:24 +0200
Subject: Re: [Xenomai-core] [PATCH] speed up building of posix apps
In-Reply-To: <44E5ACFA.50905@domain.hid>
References: <44E5ACFA.50905@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi,
 > 
 > with the growing number of wrapped posix applications also their fairly
 > slow build process became visible. It somehow scaled badly.
 > 
 > I had the idea to pass all wrapping commands to the linker via a file
 > for quite some time. Now I tried it and it gives a nice speedup of
 > roughly 400% for me when building typical single-file apps (mileage may
 > vary, I'm building on vmware box...). Moreover, it beautifies the
 > compiler output.
 > 
 > Tested on various setups, no regressions known so far.
 > 
 > Jan
 > 
 > 
 > PS: What about the silence-libtool patch? I've heard neither ack nor
 > nack so far.
 > Index: configure.in
 > ===================================================================
 > --- configure.in	(revision 1453)
 > +++ configure.in	(working copy)
 > @@ -525,8 +525,7 @@ XENO_USER_APP_CFLAGS=$XENO_USER_CFLAGS
 >  XENO_USER_CFLAGS="$XENO_USER_CFLAGS -D__IN_XENO__ -Wstrict-prototypes"
 >  XENO_USER_APP_LDFLAGS=$XENO_USER_LDFLAGS
 >  
 > -XENO_POSIX_WRAPPERS=`while read symbol; do echo -n "-Wl,--wrap,$symbol "; done \
 > -        < $srcdir/src/skins/posix/posix.wrappers`
 > +XENO_POSIX_WRAPPERS="-Wl,@`cd $srcdir && pwd`/src/skins/posix/posix.wrappers"

Does not work here: the @ is passed to ld which does not know how to
handle it.


-- 


					    Gilles Chanteperdrix.

