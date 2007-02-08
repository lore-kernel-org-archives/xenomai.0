Message-ID: <45CB1765.1080109@domain.hid>
Date: Thu, 08 Feb 2007 13:28:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Linux lock-up with rtcanrecv
References: <45CA5AFD.9020805@domain.hid> <45CAE367.5040803@domain.hid>
	<45CAE2C5.1070108@domain.hid>
In-Reply-To: <45CAE2C5.1070108@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD34D5F9BBF37D1ED0BCDE864"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD34D5F9BBF37D1ED0BCDE864
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hi Jan,
>>
>> Jan Kiszka wrote:
>>> Hi all,
>>>
>>> fiddling with latest Xenomai trunk and 2.3.x on one of our robots (th=
ere
>>> is still a bug in trunk /wrt broken timeouts of rt_dev_read on
>>> xeno_16550A - different issue...), I ran into a weird behaviour of
>>> rtcanrecv:
>>>
>>> I have a continuous stream of a few thousand packets/s towards the
>>> robot. When I start up two "rtcanrecv rtcan0 -p1000" instances (or on=
e +
>>> our own receiver application), the second one causes a Linux lock-up.=

>>> Sometimes this happens during startup of the second rtcanrecv, but at=

>>> latest on its termination. Other RT tasks are still running. I can
>>> resolve the lock-up by pulling the CAN cable, everyone is fine
>>> afterwards and can be cleaned up. I played with quite a few combinati=
ons
>>> of recent ipipe patches and Xenomai revisions (even back to #1084 in
>>> v2.3.x), no noticeable difference.
>>>
>>> Seems like I have to take a closer look - once time permits and the
>>> robot is available. So any ideas or attempts to reproduce this are
>>> welcome, current .config attached (no magic knob found there yet).
>> I will try to reporduce the problem a.s.a.p.
>=20
> TiA.

Grmbl. You can forget about it, I found the magic knob.

Normally I don't even notice that the tracer is running in background.
This time I did notice it, but didn't realised that it was the reason.
Already disabling it during runtime "solves" my problem. It looks like
its overhead combined with a few more debug options of Linux, the high
IRQ load, and a low-end board drove the otherwise only moderately loaded
box into starvation.

Sorry for making noise, let's go back to business.

Jan


--------------enigD34D5F9BBF37D1ED0BCDE864
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFyxdmniDOoMHTA+kRAjnnAJ9/lW7tZ/H5rCzpbBoew3pR7Fo5hQCfZ7g2
O9chkv4l++TDgGl+llL+86s=
=QNab
-----END PGP SIGNATURE-----

--------------enigD34D5F9BBF37D1ED0BCDE864--

