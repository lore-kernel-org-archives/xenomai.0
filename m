Message-ID: <448147B6.9080101@domain.hid>
Date: Sat, 03 Jun 2006 10:26:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xnpod help
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>	<17535.18007.179715.207040@domain.hid>	<447F49C8.4090609@domain.hid>
	<39455.155.98.4.39.1149195102.squirrel@domain.hid>
	<447F5935.4090105@domain.hid>
	<47190.155.98.4.39.1149199741.squirrel@domain.hid>
	<447F704B.10303@domain.hid>
	<43446.155.98.4.39.1149280881.squirrel@domain.hid>
In-Reply-To: <43446.155.98.4.39.1149280881.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD41D26D77C609531A01C2FFB"
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
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD41D26D77C609531A01C2FFB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
>> ioperm() or iopl() not applicable?
>=20
> I'm not sure.  I'm using a Sensoray S626 card (PCI).  The driver I have=
 is
> something I pieced together from psuedo-working code I got from someone=

> else, so I'm not entirely sure how it works (or if it's even rt-safe).
> -Brandt
>=20

Sounds like very good preconditions to create a deterministic
time-critical system. :)

I just had a short look at their linux driver [1] (if this is what you
are referring to): in fact, terrible code. That there is no locking
makes it highly suspicious. And the way kernel 2.4 compat code is
handled is very ugly as well.

But the driver core is fortunately not that large (in contrast to the
user lib - bah!), so you may try to grab the essentials from it.
Converting that API to RTDM would be straightforward (given that there
are no design faults in that code).

I wonder if there is already comedi support for this device. Alexis, do
you know this? That would likely be a better driver model, because it's
generic.

Jan


[1] http://www.sensoray.com/html/626data.htm


--------------enigD41D26D77C609531A01C2FFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEgUe2niDOoMHTA+kRAorbAJ0eWlrVkjnm0IYcF+JhOZArG+1LQACfSEeo
+Uwi2dspICpQU2AUuRalkwc=
=pdWU
-----END PGP SIGNATURE-----

--------------enigD41D26D77C609531A01C2FFB--

