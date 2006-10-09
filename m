Message-ID: <452A8C0F.2010001@domain.hid>
Date: Mon, 09 Oct 2006 19:51:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] 3rd party task mode switches and inquiries
References: <1160411937.6268.14.camel@domain.hid>
In-Reply-To: <1160411937.6268.14.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig226C2EB5A963E2155C15AC56"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig226C2EB5A963E2155C15AC56
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> I have a need for task t1 to switch task t2 to and from primary mode,
> using the native API.  The rt_task_set_mode() API does not have an
> argument for the target task, and assumes the current task.  How can I
> initiate a 3rd party task mode switch?

Umm, could you explain why you need this? Sounds a bit weird to me.

We basically have this feature to support RTDM drivers that provide
mode-dependent (overloaded) services like resource allocation from Linux
vs. real-time pools. Normally, you should not need to touch the mode
explicitly, Xenomai will switch for you when required and feasible.

>=20
> On a related note, the task info returned from rt_task_inquire() does
> not indicate task mode switches in the corresponding T_PRIMARY (0x200)
> bit, which is the bit used to command the mode switch.  However, a mode=

> switch can be seen in the 0x100 status bit, which corresponds to the
> XNRELAX bit, (not in the public native/task.h API).  What's the best wa=
y
> to inquire if an arbitrary task is in primary or secondary mode?

I would say there is no official way yet, but I think we should create
one, likely by translating XNRELAX to the native-specific T_PRIMARY
flag. Should be trivial.

>=20
> I am using Xenomai-2.2.0.
>=20
> thanks,
> 	Jeff Weber
>=20

Jan


--------------enig226C2EB5A963E2155C15AC56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKowPniDOoMHTA+kRAoIWAJ4uwuSmgItT+8GBS/ITAfeb356C3ACfcR0F
aP6EtLM4qvScpYw+qhgbr6Q=
=d3S8
-----END PGP SIGNATURE-----

--------------enig226C2EB5A963E2155C15AC56--

