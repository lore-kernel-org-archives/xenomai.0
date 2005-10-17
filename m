From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17236.13453.672147.550393@domain.hid>
Date: Tue, 18 Oct 2005 01:32:29 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <435402B4.5060004@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > Jan Kiszka kirjoitti:
 > > Heikki Lindholm wrote:
 > > 
 > >>Jan Kiszka kirjoitti:
 > >>
 > >>
 > >>>Hi,
 > >>>
 > >>>I'm dumb x86 user who unfortunately just seem to have tumbled in the
 > >>>cross-compilation trap: I'm trying to generate i586 code on a fancy new
 > >>>and fast x86_64 compilation host. I got the kernel compiled with
 > >>>ARCH=i386, using only the pre-installed compiler (i.e. no dedicated
 > >>>cross tool chain), but I failed to compile xenomai against that kernel
 > >>>in the following. Which magic switch do I have to apply and where?
 > >>
 > >>
 > >>As dumb a guess: -m32 compiler switch?
 > >>
 > > 
 > > 
 > > Yes, I know, that would help. But where to feed this argument into the
 > > build system?
 > 
 > I would try makefile (and perhaps config/kconfig/Makefile*) and command 
 > line 'CC="gcc -m32" CXX="gcc -m32" make menuconfig/install' to be sure.

When using autoconf, you are not supposed to pass compiler flags in
CC, CFLAGS and CXXFLAGS are made for that... and the build system is
supposed to only touch AM_CFLAGS, so that CFLAGS is let for users, but I
am pretty sure this does not work with Xenomai, since we never tried :-)

As for the compilation for pentium on an x86_64, isn't there any
i686-linux-gcc that directly cross compiles for ia32 ?

If not, would not the following wrapper do the trick ?

#! /bin/sh
exec `expr "$0" : 'i686-linux-\(.*\)'` -m32r ${1+"$@"}

It should work with most build systems...


-- 


					    Gilles Chanteperdrix.

