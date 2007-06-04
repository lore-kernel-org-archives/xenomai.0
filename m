From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <46644E53.9000204@domain.hid>
References: <46644E53.9000204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 04 Jun 2007 22:31:29 +0200
Message-Id: <1180989089.21578.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] New I-pipe patch for ARM needs testing.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Le lundi 04 juin 2007 =E0 19:39 +0200, Gilles Chanteperdrix a =E9crit :
> Hi,
>=20
> in Xenomai repository (trunk and v2.3.x branch), you will find
> adeos-ipipe-2.6.20-arm-1.7-03.patch, the latest version of the I-pipe
> patch for ARM.

Great job !

[...]

> As for tsc emulation in user-space, I only implemented it for machines
> with a free-running counter, hoping that someone (maybe Sebastian or
> Stelian ?) with hardware whose tsc is based on a decrementer could do
> the work.

I'd take a look, but I lack the hardware right now. I'll probably have
access to the ARM Integrator board in a few weeks, at some time before
the end of July. Unless someone else implements it sooner than that...

Stelian.

--=20
Stelian Pop <stelian@domain.hid>


