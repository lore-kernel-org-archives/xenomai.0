From: "Charlton, John" <john.charlton@domain.hid>
Date: Thu, 13 Aug 2009 07:26:11 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060F03FA83@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid> <4A81CE4F.9060301@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
	<4A82DC78.9060408@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4EE1@domain.hid>
	<4A83108E.10309@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4F19@domain.hid>
	<4A8314D1.9060702@domain.hid>
In-Reply-To: <4A8314D1.9060702@domain.hid>
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

Gilles,

Here is another piece of the puzzle, my colleague Jay Snyder who is working=
 on the Open Embedded bitbake build for Xenomai found this:=20

   I have narrowed the problem down to
/usr/xenomai/lib/libpthread_rt.so.1.0.0

I can install the full OE package, and then overwrite this file from the na=
tive-compiler build, and the tests run.

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Wednesday, August 12, 2009 3:15 PM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented

Charlton, John wrote:
> (snip)
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/i386 started.
> Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> Xenomai: starting RTAI emulator.
> (snip)

Damn, Xenomai seems to be started normally. It seems the skin binding succe=
eds, but not the actual system calls. If you compiled Xenomai user-space su=
pport with --enable-x86-sep, could you try to compile it with --disable-x86=
-sep ?

--=20
					    Gilles.

