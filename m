Message-ID: <4A979E12.6070508@domain.hid>
Date: Fri, 28 Aug 2009 11:06:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Error compiling Xenomai 2.4.8 with I-pipe tracer
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Cc: xenomai@xenomai.org

Berruer S=E9bastien wrote:
> Hello,
>=20
> I'm using Linux 2.6.28 and Xenomai 2.4.8 over an PXA255 processor based
> board.
>=20
> I can't achieve the compilation process when I enable the I-pipe tracer.
> I've tried some mixed configurations but it always fails with an error.
> I use :
>=20
>  - gcc version 4.2.3 (Sourcery G++ Lite 2008q1-126)
>  - GNU C Library stable release version 2.5, by Roland McGrath et al.
>=20
> I join the .config file of the basic configuration I'd like to have
> (trying to keep no frequency scaling, no power saving mode, replace the
> standard serial driver by the RT one, no FPU support...) and a copy of
> the compile process' trace.
>=20
> I hope you'd be able to help me pointing out the error.

It is a known toolchain issue, you are using a toolchain too recent for
this kernel version. This is a mainline bug, there is a fix, but I do
not know if it has been merged yet. Though according to the fix, this
gnu_mcount stuff comes with gcc 4.4, so I am not sure you use the
compiler you think you are using.

So, either downgrade your toolchain (I bet 2007q3 works, since it is the
one I have been using for a long time), when you want to use the tracer.
Or apply the patches which have been published on the linux-arm-kernel
mailing list.

--=20
                                          Gilles


