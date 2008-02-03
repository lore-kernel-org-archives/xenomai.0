Message-ID: <47A6405A.8040706@domain.hid>
Date: Sun, 03 Feb 2008 23:29:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D3768B2@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3768B2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96FACC4CFB0B1B01752ED264"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] periodic issues/watchdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96FACC4CFB0B1B01752ED264
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> So with rt_timer_set_periodic(125000) on and my sound task running, I
> still trip the watchdog. /proc/xenomai/stat is showing 9.5% usage by th=
e
> sound task and a whopping 16.5% by IRQ0. (This amount seems considerabl=
y
> lower when watchdog support is not compiled in.) The weird thing is tha=
t
> the watchdog keeps killing the thread even though it isn't at all
> locking up the system.  (ROOT using 82%.)

What is your target arch, what is your time line for experiments? I'm
expecting to work on the LTTng thing soon again, maybe this week, and
that would be a good tool for all your periodic-timing-goes-crazy issues.=


One further note regarding overhead: Timers (or timed tasks) running
over a periodic timebase are expected to have a slightly higher overhead
than running (at the same frequency) directly on the master (=3D=3Done-sh=
ot)
timebase. That's because the periodic timebase is built _on_top_ of the
master base theses days (since Xenomai 2.4). So, unless you can benefit
substantially from a jiffies/ticks based timing for your application
(/wrt internal time calculations or due to the clustering of timer
events), running directly on the master base is often the more efficient
approach.

Jan


--------------enig96FACC4CFB0B1B01752ED264
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHpkBeniDOoMHTA+kRAvx0AJ0R928VZUvCtVqPZhJsf6Ymaff/cwCaA/fj
ee3gxbx4waMkayEftvOneCg=
=YHhW
-----END PGP SIGNATURE-----

--------------enig96FACC4CFB0B1B01752ED264--

