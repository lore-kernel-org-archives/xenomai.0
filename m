Message-ID: <463457A0.7030008@domain.hid>
Date: Sun, 29 Apr 2007 10:30:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f10l2a$rdk$1@domain.hid>
In-Reply-To: <f10l2a$rdk$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFBC6C613F1F833FDDC79221D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] very simple example for rtdm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFBC6C613F1F833FDDC79221D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

trem wrote:
> Hi
>=20
> I've written a very simple example for rtdm. And I would be pleased to
> get a feedback about it. You can found it here :
>=20
> http://zarb.org/users/svn/trem/trem/kernel/xenomai/rtdm/
>=20

Looks good and (almost) clean. A few remarks and some suggestion:

 o Use kernel coding style for the driver (linux/scripts/Lindent +
   manual tweaking)

 o Put your driver under RTDM_CLASS_EXPERIMENTAL, TESTING is for
   benchmarks and regression test drivers. And you don't need
   rttesting.h.


 o As RTDM is mainly about "RT", why not switching to .read_rt and
   .write_rt? That means of course creating a shadow thread in
   read_simple_rtdm.

 o Once you are real-time with read/write, you could demonstrate
   synchronisation. One FAQ is "How do I wait with my application on
   something inside a driver?" You could do rtdm_sem_up on write and
   rtdm_sem_[timed]down on read.

Alternatively:

 o What about creating a small series of RTDM examples, consisting of
   two demos so far: the first one a reduced version of you current
   code, just showing device registration and handler invocation, the
   second one about read/write and synchronisation. And if you feel like
   doing more, one could certainly continue this series with further
   aspects...

Are you interested that we merge your example(s) into the Xenomai repos
(examples/rtdm/driver-api)? I would welcome this and support your effort!=


Jan


--------------enigFBC6C613F1F833FDDC79221D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNFekniDOoMHTA+kRAq0VAJ9unLUz5ebHtLaeK/OUu8qKxPDIOACfZ7uf
N9mkWjbG6TNi/I3GQi3alzc=
=KCIN
-----END PGP SIGNATURE-----

--------------enigFBC6C613F1F833FDDC79221D--

