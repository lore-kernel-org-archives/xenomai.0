From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17235.63032.536602.249924@domain.hid>
Date: Mon, 17 Oct 2005 21:06:32 +0200
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
In-Reply-To: <200510180217.41806.rlenglet@domain.hid>
References: <200510170157.58507.rlenglet@domain.hid>
	<4353D250.9050807@domain.hid>
	<200510180217.41806.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
 > > if you see an error, please provide a proper patch.
 > 
 > Here is a patch that includes the correction of xeno-config.in 
 > and the manpage. If someone wants to add it to the patch tracker 
 > on the Gna! project page, please do it.
 > 
 > > I cannot see the error youve 'corrected' below..
 > 
 > You will see in the patch. ;)
 > The usage mentionned --module-cxxflags and --kernel-cxxflags that 
 > are not allowed, and the actual set of accepted options is 
 > larger than previously displayed in the usage.
 > 
 > > In fact, youve added one;  -v doesnt work,  --v does.
 > 
 > Thanks, corrected in this patch.

Thanks a lot, will apply. I would move the man directory under the doc
directory though.

 > If someone applies the patch to the repository, it will be 
 > necessary to run autoreconf once (to regenerate configure and 
 > man/GNUmakefile.in). It does not work on my system, apparently 
 > because my versions of automake and autoconf are too recent, and 
 > some rule files seem to not be included in the repository.

The necessary versions of the autotools are the one in Debian Sarge, and
their version is given in README.INSTALL:
o autoconf 2.59
o automake 1.9.5
o aclocal 1.9.5
o libtool 1.5.6

If you want to regenerate the autotools files, you may enable the
"maintainer mode" in Xenomai configuration or run 
script/bootstrap (you have to run it under the sim directory too).

autoreconf does not work because it greps the flags to be passed to
aclocal by looking for the ACLOCAL_AMFLAGS variable definition in the
top Makefile, but there is no top Makefile in Xenomai, only a top
GNUmakefile. I tracked down this issue and changed my autoreconf
script a long time ago but am using the bootstrap script now... Automake
maintainer mode, on the other hand, works fine with makefiles called
GNUmakefile.


-- 


					    Gilles Chanteperdrix.

