Message-ID: <4AFE90A8.7090403@domain.hid>
Date: Sat, 14 Nov 2009 12:12:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid> <4AFD4C7F.1000106@domain.hid>
	<4AFD6013.9020608@domain.hid>
In-Reply-To: <4AFD6013.9020608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2C8D73E92EFD009AAF80A86"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] What has highest priority RTcap or
	TDMA-synchronization reception?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2C8D73E92EFD009AAF80A86
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Benjamin Biegel wrote:
> Thanks Jan
>=20
> We use this setup: Two computers are RTnet-slaves synchronized to provi=
de them common time. These two computers also have a second NIC which tap=
 a target Ethernet network using RTcap. In this way we can measure Ethern=
et travel times on the target network.
>=20
> This works well. The only problem is that we don't know exactly how to =
handle if a TDMA sync arrives at the same time as RTcap captures a frame =
on the target network.
>=20
> We ran a test where we only read the system time from kernel space usin=
g rt_timer_read(). This reading and saving to a file takes approximately =
1 us. However this time increases to approx 16 us when the reading is mad=
e when a synchronization TDMA packet is being handled.
>=20
> We would like to detect when this happens so we can discard the frame t=
ravel times that collide with the TDMA sync.
>=20
> I hope this makes sense

Note that the synchronization accuracy via TDMA is not in the order of a
few microseconds, rather a few 10 us. That's because no clever approach
to compensate jitters of the reception interrupt is applied. So your
worrying about the jitter caused by the second NIC actually has to be
extended by worries about jitter of other host interrupts. They might be
smaller as I-pipe will suppress non-RT IRQs far more quickly, but they
are more and can line up and cause larger jitters as well.

If you want to get rid of most of them: use a multicore box and isolate
the RTnet NIC IRQ on a dedicated core. All Linux IRQs except for the
timer IRQ can then be avoided.

And I still see no point in using a second NIC if the first one is only
_receiving_ TDMA sync frames. It's true that timestamps taken by RTcap
on outgoing frames will naturally slightly differ from those taken by a
listen-only observer - but to my understanding this scenarios does not
apply to you case. So RTcap will work just fine when attached already to
the first NIC.

Jan


--------------enigA2C8D73E92EFD009AAF80A86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr+kK4ACgkQitSsb3rl5xQwbwCgiWDwmVIFZ9hXlnC9L0jw0QPz
/4YAnAvAKcPtYgeYpLn+4X4qNK0LbDXM
=ysr4
-----END PGP SIGNATURE-----

--------------enigA2C8D73E92EFD009AAF80A86--

