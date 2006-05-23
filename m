Message-ID: <4472D22B.5040703@domain.hid>
Date: Tue, 23 May 2006 11:13:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: RTDM driver questions
References: <050720061514.21865.445E0ED2000D33230000556922058863609C0E0301089BD2040A969B0799@domain.hid>	<200605072202.22555.witzel.thomas@domain.hid>	<if82j3-9ug.ln1@domain.hid>
	<200605212119.53330.witzel.thomas@domain.hid>
In-Reply-To: <200605212119.53330.witzel.thomas@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFDE254CF587FB25331081D3F"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: witzel.thomas@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDE254CF587FB25331081D3F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas Witzel wrote:
> I have that now, but I'm not really sure how to synchronize the user sp=
ace=20
> application with the driver, since the driver has of course only a limi=
ted=20
> buffer. Practically now I have a 512 sample buffer in the driver that I=
 use=20
> as a double buffer and I copy blocks of 256 to the user on read.=20
> Isn't there a way to have a FIFO between driver and user application an=
d is=20
> there an example somewhere, where I can see how this is done properly ?=


Why not extending your sample buffer to some FIFO by providing more space=
?

>=20
> Independently of that, if the user space application dies, how can I re=
move=20
> the driver then ?

As long as we have no auto-cleanup on termination (WIP), you can
forcibly close a RTDM file descriptor via "echo FD >
/proc/xenomai/rtdm/open_fildes" (FD =3D descriptor number, see "cat
/proc/xenomai/rtdm/open_fildes" for candidates). Once all descriptors of
a device are closed, you can remove the driver again.

Jan


--------------enigFDE254CF587FB25331081D3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEctIsniDOoMHTA+kRApB1AJ0Z4zLbThX1EN3ADiUkoXwIrEsOHgCfS1P3
SoV6fH6ZCR8gFfamRRly5dE=
=6/zv
-----END PGP SIGNATURE-----

--------------enigFDE254CF587FB25331081D3F--

