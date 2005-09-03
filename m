Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to	2.6.13
From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <431946EC.4090804@domain.hid>
References: <1125495609.4643.16.camel@domain.hid>
	<20050831193733.w5f2d662w0gswwkg@domain.hid>
	<20050831211425.GA32230@domain.hid>
	<20050901104750.c0mpu3q4pkc088wg@domain.hid>
	<1125577206.4641.8.camel@domain.hid>
	<1125579791.4685.2.camel@domain.hid>
	<4316FD8F.30203@domain.hid>
	<1125581425.4639.3.camel@domain.hid>
	<20050901155220.ifckrl94w00gksg8@domain.hid>
	<1125583963.4635.0.camel@domain.hid>
	<20050901164619.pn5h4cg34s0w4gok@domain.hid>
	<1125586184.4633.3.camel@domain.hid>
	<431946EC.4090804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 03 Sep 2005 23:09:03 +0200
Message-Id: <1125781743.27528.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: adeos-main@gna.org, Philippe Gerum <philippe.gerum@domain.hid>

Le samedi 03 septembre 2005 =E0 09:47 +0300, Heikki Lindholm a =E9crit :
> Stelian Pop kirjoitti:
> > Le jeudi 01 septembre 2005 =E0 16:46 +0200, Philippe Gerum a =E9crit =
:
> >=20
> >=20
> >>Of, so if Heikki confirms that this patch works on ppc64, I guess tha=
t=20
> >>we have a
> >>brand new shiny bug to chase, with lots of headbanging sessions ahead=
. And I'm
> >>not talking about dance style here...
> >=20
> >=20
> > :)
> >=20
> >=20
> >>Ok, question #1: does this lockup only happen with latency, or is it =
also
> >>experienced with klatency?
> >=20
> >=20
> > I think I saw it only with latency.
>=20
> Did this happen mid-way while executing or only at the end, eg. modules=
=20
> unload phase?=20

I'd say yes, it only happens at the end of the execution of latency.

However, having already thought of such an issue I also tried preloading
the modules (thus making rtai-load not remove the modules at the end of
its run). And it made no difference.

Stelian.
--=20
Stelian Pop <stelian@domain.hid>


