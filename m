From: Leopold Palomo Avellaneda <leo@domain.hid>
Date: Wed, 30 Jul 2008 00:39:36 +0200
References: <200807152346.21863.leo@domain.hid>
	<200807300008.48525.leo@domain.hid>
	<488F9869.4040003@domain.hid>
In-Reply-To: <488F9869.4040003@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1551210.GshxI8m0bI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200807300039.36610.leo@domain.hid>
Subject: Re: [Xenomai-help] OT. A question about constraints in realtime
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
Cc: xenomai@xenomai.org

--nextPart1551210.GshxI8m0bI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A Dimecres 30 Juliol 2008, Gilles Chanteperdrix va escriure:
> Leopold Palomo Avellaneda wrote:
> > A Dilluns 28 Juliol 2008, Gilles Chanteperdrix va escriure:
> >> Leopold Palomo Avellaneda wrote:
> >>> The sensable people claims that their driver works with some versions
> >>> of Linux (till fedora 4 and some suse) but I'm not be able to run it =
in
> >>> a debian etch. I don't know if the distros provide a kernel with some
> >>> kind of modifications that solve it, but I don't think so.
> >>>
> >>>
> >>> Well, thanks in advance and I'm sorry for the noise. Really, the
> >>> realtime stuff is something not obvious...
> >
> > First of all thanks for the answer.
> >
> >> The first thing to do is to get statistics about the scheduling latency
> >> of your driver. This means measuring the difference between the date
> >> when the driver (kernel-code) wakes up the task and the date when the
> >> task effectively runs. The bad news is that it will be hard with a
> >> binary-only driver. If the driver has some compilable glue, then you c=
an
> >> hook into this glue, otherwise, you will have to resort to ugly hacks =
in
> >> the kernel code.
> >
> > Well, I cannot (or it's too difficult to do it with a _only_ binary
> > driver. This driver is a lib (.so) and the user use some functions of
> > that lib.
>
> It is hard, but not impossible.=20

Sure, but the afford and the skill are not insignificant.

> You can hook into the sys_open function,=20
> detect that you are opening the driver (using either the device path, or
>  current->comm), and in this case, replace the file operation pointer in
> the file descriptor with your own file operations pointers which does
> some tracing then calls the original file operation pointer. So, it is
> not impossible.

Well, the driver is for a device that uses the parallel port. It's a librar=
y=20
that has implemented some kind of loop function and make the transformation=
=20
from the values to send to the device and read the device.=20

I guess that they have a very bad implementation in linux. But, really to m=
e=20
the question that intrigue me is why it works well in Windows and not in=20
linux.

Leo



=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart1551210.GshxI8m0bI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiPnCgACgkQaC7AnPlEgH60ugCfb6QmHBAR49WEYjDngeh5gvE6
kfoAoI0lqr8Vrkl0TO1nbtLIoHynjPxu
=PuW3
-----END PGP SIGNATURE-----

--nextPart1551210.GshxI8m0bI--

