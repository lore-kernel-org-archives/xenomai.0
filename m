Message-ID: <45DA3475.5050500@domain.hid>
Date: Tue, 20 Feb 2007 00:36:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-Socket-CAN versioning
References: <45D9DF65.9000300@domain.hid>	<45D9E59B.8040002@domain.hid>
	<17882.10993.117100.127933@domain.hid>
In-Reply-To: <17882.10993.117100.127933@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig00082A03E75F39D9A2B7DC31"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00082A03E75F39D9A2B7DC31
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Wolfgang Grandegger wrote:
>  > > Hi Jan,
>  > >=20
>  > > currently the RT-Socket-CAN drivers maintains it's own version or
>  > > release number. As RT-Socket-CAN is part of Xenomai, I do not see =
the
>  > > need for it (and so far I did not update it). What is the intended=
 use
>  > > of "driver_version" in "struct rtdm_device"?
>  >=20
>  > Actually, I was thinking about this too yesterday. The idea of the
>  > separate versioning for RTDM drivers is to signal the users if somet=
hing
>  > in the driver really changed. It's fairly obvious what to do with it=
 for
>  > out-of-tree drivers, but for in-tree it might be worth considering t=
he
>  > policy.
>  >=20
>  > The current model, maintained more or less properly for the existing=

>  > drivers, is to increment independently of Xenomai according to major=
 or
>  > minor changes. One may ease this burden for the driver developer by
>  > simply filling in Xenomai's version here. That would just let the
>  > revisions increase on every Xenomai release, even if the driver rema=
ined
>  > untouched. The tag would still have a meaning for out-of-tree driver=
s,
>  > but for in-tree it would be fairly meaningless.
>  >=20
>  > Well, whatever is commonly preferred, it should then be applied
>  > consistently on all RTDM drivers in Xenomai. What are the opinions o=
n
>  > this list (I will comment afterwards)?
>  >=20
>  > > Furthermore, there is also
>  > > "profile_version" (which does not show up n the Doxygen docu for s=
ome
>  > > strange reason).
>  >=20
>  > The automatic update from the latest SVN must be broken on
>  > www.xenomai.org, there is more stuff missing.
>=20
> The automatic update only updates the web site from the contents of the=

> "generated" directory. In order to update this directory, go to the
> "doc" subdirectory of the build tree and type "make generate-doc", then=

> run svn commit in the "generated" directory. I will install the proper
> version of doxygen and regenerate the documentation.
>=20

Ah, thanks.

Jan


--------------enig00082A03E75F39D9A2B7DC31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2jR1niDOoMHTA+kRArmmAJ44CbkA1Ntc6cs2EMrnxqwlvoFTHgCffO+t
LOHw8ciXwhHpiEUfBzh8BBM=
=GjoL
-----END PGP SIGNATURE-----

--------------enig00082A03E75F39D9A2B7DC31--

