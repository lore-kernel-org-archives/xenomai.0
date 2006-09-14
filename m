Message-ID: <45092074.2070000@domain.hid>
Date: Thu, 14 Sep 2006 11:27:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] driver migration
References: <9D98C51005D80D43A19A3DF329A61D69515623@domain.hid>
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D69515623@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB84E39A5485C154127E25734"
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
--------------enigB84E39A5485C154127E25734
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nilanjan Roychowdhury wrote:
>=20
>=20
> Hi,
> I had a linux driver with functionalities like it blocks a thread on an=

> ioctl and wakes it up when an interrupt occurs and does some processing=
=2E
> Now I want to migrate to xenomai space. Can I write a user  space devic=
e
> driver for this like I create an user space rt_task and call
> rt_intr_wait in the entry fuction of the task and whenever I get an
> interrupt I wake up and do the processing. Will I have any performance
> hit?? I will make sure the priority of this xenomai task is higher than=

> any other xenomai task as it will do some interrupt processing.
>=20
> In general, if I need to migrate a traditional linux device driver with=

> only user space clients to xenomai space can I write a user - space
> device driver ???

You can. Both native and posix skin provide means to block a user-space
thread on an IRQ event. And if you already have a working user-space
driver, that step should be simple as there are likely no problems with
kernel-only services like DMA management.

It is planned to enhance the Real-Time Driver Model (RTDM) with
user-space support as well, keeping both the programming model for the
driver users (profiles) as well as for the driver developers as far as
feasible. The idea is to make drivers easily re-compilable/portable
between kernel and user-space - but that's something which cannot help
you yet.

>=20
> Under what scenario we place a driver as a kernel module in xenomai
> space??

Performance will remain a reason to go to kernel-space, specifically if
you either share your device between multiple processes (having a driver
in a separate process comes at a price...) or if you need low latency on
IRQ handling. But there are also reasons to go to user-space, e.g.
license issues. We are trying to address both.

In any case, a clear separation between driver and application design is
highly recommended and something we try to foster with RTDM.

Jan


--------------enigB84E39A5485C154127E25734
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFCSB0niDOoMHTA+kRAmk5AJ9T1BfYT66DXTaK7Z9qLYECe+aDWwCeIcaq
Sg/tNWP3a/c68AWCBw5g1BA=
=1oTR
-----END PGP SIGNATURE-----

--------------enigB84E39A5485C154127E25734--

