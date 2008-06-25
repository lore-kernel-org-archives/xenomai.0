From: Leopold Palomo Avellaneda <leo@domain.hid>
Date: Thu, 26 Jun 2008 00:52:22 +0200
References: <1214406057.48625da9bf316@domain.hid>
	<200806260033.15193.berlemont.hauw@domain.hid>
In-Reply-To: <200806260033.15193.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4311680.cLQvPongVZ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200806260052.22619.leo@domain.hid>
Subject: Re: [Xenomai-help] Comedi over RTDM
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

--nextPart4311680.cLQvPongVZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A Dijous 26 Juny 2008, Alexis Berlemont va escriure:
> Hi,
>
> > Alex told me that a Comedi port to RTDM exists.
> >
> > What does this mean ? If i'm able to write a driver for Comedi, this one
> > will work with RTDM and thus with Xenomai ?
> >
> > I can't see where is the link between both and can't neither find
> > information on that port.
> >
> > does anybody have recent examples of driver working with Comedi/RTDM ?
>
> Originally, Comedi is a framework for acquisition drivers which can be us=
ed
> in a common Linux system and in some specific real-time context.
>
> This project was initiated by David Schleed. Have a look at the Comedi
> website: www.comedi.org. Many documents detail the main ideas.
>
> A little while after the development of RTDM by Jan Kiszka, I started to
> work on a literal porting of Comedi over RTDM during my free time. I faced
> no specific issues for the porting of the kernel side of Comedi. But, on
> the user side, as far as I remember, things were different. I had some
> difficulties to ensure the real-time context considering the use of common
> Linux API in the Comedi library (malloc).
>
> So I sent a mail to the Comedi mailing-list to tell that I was interested
> in writing a reviewed Comedi port for RTDM (here is a link
> http://osdir.com/ml/comedi/2006-04/msg00017.html).
>
> This task took a long time as I can only work on it during my spare-time
> (roughly one or two hours per day; my job is not related with Comedi).
>
> Eventually (at last), the "comedi-rtdm-dev" branch reached a stable state
> (a few weeks ago). The "comedi-rtdm-dev" consists of a kernel framework a=
nd
> a user-space library. Right now, the critical issue is the recovery of the
> original Comedi drivers. And, more critically, the integration of new
> drivers for new devices.
>
> On that last point, I hope some external contributions will help the
> Comedi4RTDM drivers set to grow as I have no acquisition cards and no way
> to get some.
>
> By the way, if anyone is interested in Comedi, feel free to help me and /
> or criticize / improve the code I wrote.

Alexis,

I would like to help, specially with the jr3 sensor, but I have to admit th=
at=20
you need a level of kernel programing, or comedi or xenomai that I don't=20
have, and it's very frustrate.

I don't understand "exactly" what is comedi-rtdm-dev. You are saying that i=
t's=20
a:
> The "comedi-rtdm-dev" consists of a kernel framework=20

and this is a?

some kernel modules?=20
some templates to generate a kernel module with xenomai?
some code to develop a bridge betwend xenomai and the comedi driver?
a wrapper to encapsulate the comedi driver into a xenomai kernel module?
=2E..
> and=20
> a user-space library.

some .h and a .so that let you work with  the modules with xenomai and come=
di?

Regards,

Leo


=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart4311680.cLQvPongVZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYswmaC7AnPlEgH4RAi7CAJ90VFFr6vLJggS8Jn5d0qVAZaoqAQCgg+9b
wMVuybzOrHgKXjd5TI+u4pI=
=MFZh
-----END PGP SIGNATURE-----

--nextPart4311680.cLQvPongVZ--

