Message-ID: <4A841260.1010501@domain.hid>
Date: Thu, 13 Aug 2009 15:17:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid> <4A81CE4F.9060301@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
	<4A82DC78.9060408@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4EE1@domain.hid>
	<4A83108E.10309@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4F19@domain.hid>
	<4A8314D1.9060702@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060F03FA83@domain.hid>
	<4A83F99B.9070703@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060F03FAAD@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20060F03FAAD@us194mx002.tycoelectronics.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> > 
> > 
> > -----Original Message----- From: Gilles Chanteperdrix
> > [mailto:gilles.chanteperdrix@xenomai.org] Sent: Thursday, August 13,
> > 2009 7:32 AM To: Charlton, John Cc: xenomai@xenomai.org Subject: Re:
> > [Xenomai-help] pthread_setschedparam: Function not implemented
> 
> > Ah. So, it is a build issue. Show us the flags with which Xenomai is
> > configured by this build tool? Note however that since latency is not
> > linked with libpthread_rt.so.1.0.0 I do not see how overwriting
> > libpthread_rt.so can make latency -t 1 or latency -t 2 run.
> 
>
> This issue is now resolved.  Thank you for the help.  Sorry I didn't
> make it clear that it was a build issue.  This is what Jay determined
> is the problem:
>
> The problem was one (or more) of the following compiler flags, which
>  are added as part of the defaults for OE/Angstrom:
> -fexpensive-optimizations -fomit-frame-pointer -frename-registers -O2

Ok. I am a bit surprised, but I do not know the x86 syscall macros well
enough to know whether compiling them with -O2 may break them. So, maybe
that is what happens. If that is the case, I think we should fix it (and
maybe Jan latest work on the syscall macros fixes it).

>
> These are the flags passed for "FULL_OPTIMAZATION". Obviously, one of
> these optimizations messes up xenomai. In fact, if you look at the
> Makefile, -O2 is used for the user programs, but not for the skins
> libraries.
>
> The bitbake recipe now includes the following lines:
> # set CFLAGS and CXXFLAGS to ${CPPFLAGS} so that they just have the
> appropirate -isystem flag, but no of the other -f flags, as they break
> the posix skin library build
> export CFLAGS="${CPPFLAGS}"
> export CXXFLAGS="${CPPFLAGS}"
> export TARGET_CFLAGS="${CFLAGS}"
> export TARGET_CXXFLAGS="${CXXFLAGS}"
> ./configure --build=i686-angstrom-linux

This is wrong. Passing the flags to configure using environment variable
is deprecated since even before the birth of the Xenomai project.
TARGET_CFLAGS and TARGET_CXXFLAGS are not used anywhere by Xenomai build
system.

> The CPPFLAGS variable doesn't get the optimization flags, but does get
> the required -isystem flag, so we'll use that for our CFLAGS and
> CXXFLAGS.
>
> I've run into code in the past that was broken by compiler
> optimizations, this is just another case.


-- 
                                          Gilles


