Message-ID: <45549067.1070003@domain.hid>
Date: Fri, 10 Nov 2006 15:44:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] troubles deleting tasks
References: <45547BD3.6070500@domain.hid> <455480F1.5020504@domain.hid>
	<4554875A.9060401@domain.hid>
In-Reply-To: <4554875A.9060401@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig397A961AB55B34BAA464D7D6"
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
To: Philipp Keller <philipp.keller@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig397A961AB55B34BAA464D7D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philipp Keller wrote:
> Thank you Jan.
>=20
> As to your answer:
> That must be a different issue. Check /proc/xenomai/rtdm/open_fildes fo=
r
> any leftover (CAN) file descriptor. Note that rt_dev_close() can fail i=
f
> the descriptor is busy. And such thing can happen if you simply kill th=
e
> task that currently blocks on a CAN device e.g.
>=20
> The correct ordering is therefore: close the sockets, catch the failure=

> in the blocking threads, and make them self-terminate. Granted, note th=
e
> most comfortable situation, but I'm sure we can improve it in the futur=
e
> (e.g. via auto-cleanup also for RTDM file descriptors).
>=20
> I am actually doing that quite defensively I think, as you see in the
> code snippet:
[...]

That code looks sane (for UP systems), and you are dumping all errors so
that I can assume a non-closed socket would have been detected.

So we now need more information on your precise issues, which are still
two as I see it: rt_task_delete(&main) (actually a non-issue as I
explained) and the failing re-opening of the CAN device.

What error codes do you get? Can you derive a simple demo program that
exposes the error and can be analysed by us?

Jan


PS: Yet another lacking reply-to-all...


--------------enig397A961AB55B34BAA464D7D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVJBnniDOoMHTA+kRAqleAJ0eUtLjCmdl+iGfW8nUYP+IPFvrYACfS0Z1
1lpZQyS0WFX/vSl7P9Dgk8A=
=vsIa
-----END PGP SIGNATURE-----

--------------enig397A961AB55B34BAA464D7D6--

