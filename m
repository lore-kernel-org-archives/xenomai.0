Message-ID: <43B3EAFA.2050906@domain.hid>
Date: Thu, 29 Dec 2005 14:56:10 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB0831A121F8A42239282AC2F"
Subject: [Xenomai-core] autostart timer, rt_timer_start/stop
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB0831A121F8A42239282AC2F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

cant the timer be started by default ?

The current state (2.0.1) seems to lead to the following scenario:
1) Every app calls rt_timer_start()
2) If you call rt_timer_stop you can hurt other rt-apps, so dont
   call it
3) As some apps dont stop the timer, check in 1) if its already running

I think most apps do not care in which mode the timer is running if it is=
 already,
and just go on, of course you can stop and restart the timer if its a wro=
ng state,
but you do not know if you hurt others.

Now, as i read in the other thread that the periodic timer support isnt c=
onfigured by default,
why not start the oneshot timer automatic ?

Like this, a 'normal' app doesnt need to fiddle with the timer and
an app that really cares can still call rt_timer_inquire,_stop,_start.

kisda


--------------enigB0831A121F8A42239282AC2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFDs+sBIPTw9rIdn6oRAqXDAKCBiBfyyoGh2FWwxy1fQGxf7SIFxQCbBbQi
mVI8Ess1y4LKsC8fZctb2H0=
=A1iW
-----END PGP SIGNATURE-----

--------------enigB0831A121F8A42239282AC2F--

