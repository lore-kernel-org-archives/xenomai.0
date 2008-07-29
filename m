From: Leopold Palomo Avellaneda <leo@domain.hid>
Date: Wed, 30 Jul 2008 00:08:48 +0200
References: <200807152346.21863.leo@domain.hid>
	<488D9A75.1040705@domain.hid>
In-Reply-To: <488D9A75.1040705@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4893393.oprqVJ1GK7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200807300008.48525.leo@domain.hid>
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

--nextPart4893393.oprqVJ1GK7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A Dilluns 28 Juliol 2008, Gilles Chanteperdrix va escriure:
> Leopold Palomo Avellaneda wrote:
> > The sensable people claims that their driver works with some versions of
> > Linux (till fedora 4 and some suse) but I'm not be able to run it in a
> > debian etch. I don't know if the distros provide a kernel with some kind
> > of modifications that solve it, but I don't think so.
> >
> >
> > Well, thanks in advance and I'm sorry for the noise. Really, the realti=
me
> > stuff is something not obvious...

=46irst of all thanks for the answer.=20

> The first thing to do is to get statistics about the scheduling latency
> of your driver. This means measuring the difference between the date
> when the driver (kernel-code) wakes up the task and the date when the
> task effectively runs. The bad news is that it will be hard with a
> binary-only driver. If the driver has some compilable glue, then you can
> hook into this glue, otherwise, you will have to resort to ugly hacks in
> the kernel code.

Well, I cannot (or it's too difficult to do it with a _only_ binary driver.=
=20
This driver is a lib (.so) and the user use some functions of that lib.=20

> If this latency is really the problem, then before resorting to xenomai,
> you have linux-only solutions, like using a real-time priority for the
> task using the driver.

Well, I guess that it's the latency. They have a loop that control each=20
engine, and if the driver doesn't receive any signal in some time, it=20
disconnects the engine (some rele acts) . They works well with devices with=
 3=20
motors but the 6DOF model fails.

I have to think how to solve it ...

Regards,

Leo


=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart4893393.oprqVJ1GK7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiPlPAACgkQaC7AnPlEgH6XvgCeMgLOjRLXsYr2UmTYicJ5S/CS
jlIAn0NPcbmpQ7njooXo6Z6qMO6EXT1R
=AMJl
-----END PGP SIGNATURE-----

--nextPart4893393.oprqVJ1GK7--

