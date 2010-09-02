Message-ID: <20100902053457.20090@domain.hid>
Date: Thu, 02 Sep 2010 05:36:39 -0400
From: "C Robinson" <starknight__@domain.hid>
Content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-help] Validating installation of Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

To provide some further info, I tried the command make in the examples direc=
tory:

sudo make XENO=3D/home/charles/xenomai-2.5.4/

which did many things, but eventually gave the following errors:
----------------------------------------------------------------------------=
------------------------------------------------
xddp-echo.c: In function =E2=80=98realtime_thread=E2=80=99:
xddp-echo.c:115: error: =E2=80=98SOL_XDDP=E2=80=99 undeclared (first use in =
this function)
xddp-echo.c:115: error: (Each undeclared identifier is reported only once
xddp-echo.c:115: error: for each function it appears in.)
xddp-echo.c:115: error: =E2=80=98XDDP_POOLSZ=E2=80=99 undeclared (first use =
in this function)
make[1]: *** [xddp-echo] Error 1
----------------------------------------------------------------------------=
-----------------------------------------------

and shortly afterwards ended with:

make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/xenomai_egs/xenomai-head/examples/posix'


Charles

