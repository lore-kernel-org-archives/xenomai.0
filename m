Message-ID: <4A9BABC9.1030506@domain.hid>
Date: Mon, 31 Aug 2009 12:54:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>	<4A979E12.6070508@domain.hid>	<EB48F2CADC239E44A8598CC0B0571102E4A9CE@XVS-DCFR-21.europe.corp.altran.com>	<4A9B8EF4.9050607@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9D0@domain.hid>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9D0@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE : RE : Error compiling Xenomai 2.4.8 with
 I-pipe tracer
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
> I downloaded the toolchain from:
> http://www.codesourcery.com/sgpp/lite/arm/portal/release316
>=20
> It's the free version but it's supposed to have a Newlib library. Why
> can't I
> find any *.so? I only have *.a files. Must I only statically compile my
> software?

No. This version is the free-standing version, made to compile code
without an OS. This is sufficient for compiling the Linux kernel, not
for compiling any Linux user-space applications. What you should
download is:

http://www.codesourcery.com/sgpp/lite/arm/portal/release313

--=20
                                          Gilles


