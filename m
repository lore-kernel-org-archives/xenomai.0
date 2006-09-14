Message-ID: <4509239F.8000203@domain.hid>
Date: Thu, 14 Sep 2006 11:40:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] driver migration
References: <9D98C51005D80D43A19A3DF329A61D69515624@domain.hid>
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D69515624@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3F5070498335E9A074B99823"
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
To: Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F5070498335E9A074B99823
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nilanjan Roychowdhury wrote:
>> Performance will remain a reason to go to kernel-space, specifically i=
f
>> you either share your device between multiple processes (having a
> driver
>> in a separate process comes at a price...) or if you need low latency
> on
>> IRQ handling. But there are also reasons to go to user-space, e.g.
>> license issues. We are trying to address both.
>=20
> Nilanjan :- Can I assume you are saying the latency is less when I run
> my interrupt processing code as an real time ISR rather than a user -
> space=20
> Thread ?

Yes, of course. Check the irqbench test for real numbers on your target
system.

> In that case I can run the ISR in kernel mode and signal the user space=

> RT task by a semaphore ( the user space task will bind this).

That would be the classic design if you have some simple job to do on
IRQ delivery (some direct fiddling with the hardware e.g.) + you want to
wakeup a thread waiting on the event. In this case you can use RTDM for
the in-kernel part and attach your application to the RTDM device your
driver will then export.

Jan


--------------enig3F5070498335E9A074B99823
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFCSOfniDOoMHTA+kRAubwAJwKKXKmTo57DsuymXU2k/MZ5VllTgCbBG8v
0OAGlic9hF5ss6oN6B8jDr0=
=GPgb
-----END PGP SIGNATURE-----

--------------enig3F5070498335E9A074B99823--

