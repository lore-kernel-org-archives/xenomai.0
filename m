From: "Charlton, John" <john.charlton@domain.hid>
Date: Thu, 13 Aug 2009 11:04:32 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060F03FB23@domain.hid>
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
	<4A841260.1010501@domain.hid>
In-Reply-To: <4A841260.1010501@domain.hid>
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
Sent: Thursday, August 13, 2009 9:17 AM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
>
> These are the flags passed for "FULL_OPTIMAZATION". Obviously, one of=20
> these optimizations messes up xenomai. In fact, if you look at the=20
> Makefile, -O2 is used for the user programs, but not for the skins=20
> libraries.
>
> The bitbake recipe now includes the following lines:
> # set CFLAGS and CXXFLAGS to ${CPPFLAGS} so that they just have the=20
> appropirate -isystem flag, but no of the other -f flags, as they break=20
> the posix skin library build export CFLAGS=3D"${CPPFLAGS}"
> export CXXFLAGS=3D"${CPPFLAGS}"
> export TARGET_CFLAGS=3D"${CFLAGS}"
> export TARGET_CXXFLAGS=3D"${CXXFLAGS}"
> ./configure --build=3Di686-angstrom-linux

This is wrong. Passing the flags to configure using environment variable is=
 deprecated since even before the birth of the Xenomai project.
TARGET_CFLAGS and TARGET_CXXFLAGS are not used anywhere by Xenomai build sy=
stem.
--=20
                                          Gilles


How does the xenomai configure script get the correct cross compiler settin=
gs?  Is it just a matter of using --host to specify the target cross compil=
er?
./configure --host=3Di686-angstrom-linux=20

I had some problems early on when the xenomai configure script would use th=
e build system compiler rather than the cross compiler. Obviously the cross=
 compiler has to be in the build environment path environment.  Is it best =
to leave all other compiler flags unset when running configure?

--John=

