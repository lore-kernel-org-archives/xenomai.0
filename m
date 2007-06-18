Message-ID: <467641F3.3010308@domain.hid>
Date: Mon, 18 Jun 2007 10:27:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467639BE.30504@domain.hid>
In-Reply-To: <467639BE.30504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig74415A00ED7B0539D7416734"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig74415A00ED7B0539D7416734
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> The answer I found is to synchronise all time bases as good as possible=
=2E
> That means if one base changes its wall clock offset, all others need t=
o
> be adjusted as well. At this chance, we would also implement
> synchronisation of the time bases on the system clock when they get
> started. Because skins may work with different type width to represent
> time, relative changes have to be applied, i.e. the core API changes
> from xntbase_set_time(new_time) to xntbase_adjust_time(relative_change)=
=2E
> The patch (global-wallclock.patch) finally touches more parts than I wa=
s
> first hoping. Here is the full list:
>=20
>  - synchronise slave time bases on the master on xntbase_start
>  - xntbase_set_time -> xntbase_adjust_time, fixing all time bases
>    currently registered
>  - make xnarch_start_timer return the nanos since the last host tick
>    (only ia64 affected, all others return 0 anyway, causing one tick
>    off when synchronising on system time -- but this fiddling becomes
>    pointless on the long term due to better clocksourses on all archs)
>  - adapt vrtx, vxworks, and psos+ skin to new scheme, fixing sc_sclock
>    at this chance
>  - make xnarch_get_sys_time internal, no skin should (need to) touch
>    this anymore

Forgot to mention two further aspects:

 - The semantic of XNTBSET was kept time base-local. But I wonder if
   this flag is still required. Unless it was introduced to emulated
   some special RTOS behaviour, we now have the time bases automatically
   set on startup. Comments welcome.

 - This patch is a nice foundation for the stuff I have in mind post 2.4
   release: an infrastructure to synchronise the Xenomai clock on
   arbitrary external sources like local ToD, RTCs, sync packets sent
   over CAN (CANopen...), Ethernet (RTnet, IEEE1588, ...), or whatever
   media (poor-man's nullmodem links...)

Jan


--------------enig74415A00ED7B0539D7416734
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGdkH2niDOoMHTA+kRAhfGAJ9W8PnysRYBqtpJBdXtmYxEhXXwNwCdFOY3
GQTUHDEmUhraolYHVUl6VYw=
=RnXP
-----END PGP SIGNATURE-----

--------------enig74415A00ED7B0539D7416734--

