From: "Charlton, John" <john.charlton@domain.hid>
Date: Thu, 13 Aug 2009 09:00:06 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060F03FAAD@us194mx002.tycoelectronics.net>
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
In-Reply-To: <4A83F99B.9070703@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=20

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Thursday, August 13, 2009 7:32 AM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented

Ah. So, it is a build issue. Show us the flags with which Xenomai is config=
ured by this build tool? Note however that since latency is not linked with=
 libpthread_rt.so.1.0.0 I do not see how overwriting libpthread_rt.so can m=
ake latency -t 1 or latency -t 2 run.

--=20
                                          Gilles

Gilles,

This issue is now resolved.  Thank you for the help.  Sorry I didn't make i=
t clear that it was a build issue.  This is what Jay determined is the prob=
lem:

The problem was one (or more) of the following compiler flags, which are ad=
ded as part of
the defaults for OE/Angstrom:
-fexpensive-optimizations -fomit-frame-pointer -frename-registers -O2

These are the flags passed for "FULL_OPTIMAZATION". Obviously, one of these
optimizations messes up xenomai. In fact, if you look at the Makefile, -O2 =
is
used for the user programs, but not for the skins libraries.

The bitbake recipe now includes the following lines:
# set CFLAGS and CXXFLAGS to ${CPPFLAGS} so that they just have the
appropirate -isystem flag, but no of the other -f flags, as they break the
posix skin library build
export CFLAGS=3D"${CPPFLAGS}"
export CXXFLAGS=3D"${CPPFLAGS}"
export TARGET_CFLAGS=3D"${CFLAGS}"
export TARGET_CXXFLAGS=3D"${CXXFLAGS}"
./configure --build=3Di686-angstrom-linux=20
The CPPFLAGS variable doesn't get the optimization flags, but does get the
required -isystem flag, so we'll use that for our CFLAGS and CXXFLAGS.

I've run into code in the past that was broken by compiler optimizations, t=
his is just another case.

