Message-ID: <4A842D6C.5000106@domain.hid>
Date: Thu, 13 Aug 2009 17:12:44 +0200
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
	<4A841260.1010501@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060F03FB23@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20060F03FB23@domain.hid>
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
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
> > Sent: Thursday, August 13, 2009 9:17 AM
> > To: Charlton, John
> > Cc: xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
> >> These are the flags passed for "FULL_OPTIMAZATION". Obviously, one of 
> >> these optimizations messes up xenomai. In fact, if you look at the 
> >> Makefile, -O2 is used for the user programs, but not for the skins 
> >> libraries.
> >>
> >> The bitbake recipe now includes the following lines:
> >> # set CFLAGS and CXXFLAGS to ${CPPFLAGS} so that they just have the 
> >> appropirate -isystem flag, but no of the other -f flags, as they break 
> >> the posix skin library build export CFLAGS="${CPPFLAGS}"
> >> export CXXFLAGS="${CPPFLAGS}"
> >> export TARGET_CFLAGS="${CFLAGS}"
> >> export TARGET_CXXFLAGS="${CXXFLAGS}"
> >> ./configure --build=i686-angstrom-linux
> > 
> > This is wrong. Passing the flags to configure using environment variable is deprecated since even before the birth of the Xenomai project.
> > TARGET_CFLAGS and TARGET_CXXFLAGS are not used anywhere by Xenomai build system.

Please stop answering below the '-- ' token, as this token is used to
separate the mail body from the signature, and since you post below it,
my mail client considers (rightly) your answer as a signature and strips
it when I try replying to you. So, I have to spend some time manually
reformatting your answer as you should have formatted it in the first place.

>
> How does the xenomai configure script get the correct cross compiler
> settings?  Is it just a matter of using --host to specify the target
> cross compiler?
> ./configure --host=i686-angstrom-linux
>
> I had some problems early on when the xenomai configure script would
> use the build system compiler rather than the cross compiler.
> Obviously the cross compiler has to be in the build environment path
> environment.  Is it best to leave all other compiler flags unset when
> running configure?

You can pass arguments to configure, but on its command line, not using
environment variables. For instance:

./configure --host=i686-angstrom-linux CPPFLAGS=${CPPFLAGS}

And yes, the toolchain executables names are deduced from the value
passed to the --host flag. But you can override them on configure
command line too:

./configure --host=i686 CC=i686-angstrom-linux-gcc

etc...

-- 
                                          Gilles


