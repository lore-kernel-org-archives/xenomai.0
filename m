Message-ID: <434E2D10.7070208@domain.hid>
Date: Thu, 13 Oct 2005 11:46:56 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Future of fusion
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<434E19AD.4030500@domain.hid>
	<Pine.LNX.4.64.0510131033300.5110@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0510131033300.5110@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD24A89893F27C4A2DAEA0775"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD24A89893F27C4A2DAEA0775
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Herman Bruyninckx wrote:
> On Thu, 13 Oct 2005, Philippe Gerum wrote:
> [...]
> 
>> - Drivers: Now that we have a deeply integrated port of RTDM, what's
>> next? Field busses and other industrial gizmos anyone?
> 
> 
> That's an interesting avenue for all our machine control oriented realtime
> applications. But this avenue is full of incomplete or non-free
> specifications and interfaces...
> 

Indeed, but we cannot solve all problems at once. Let's start with those
devices which are more or less open (and there are already a lot). Let's
also try to propagate the message that RTDM is the prefered way to
provide real-time drivers. And if someone comes up with a new driver,
check if its interface is generic enough to implement it for similar
devices as well (=>generic device profiles).

Far from being perfect, but there are first efforts for such profiles:
Serial (as it comes with Xenomai), process image (see the Hilscher
Interbus driver I once announced), or CAN (yet a bit in flux, but things
slowly stabilises here). Plans exist to go the same way for low level
access to FireWire or USB. And you can even map whole protocol stacks
onto RTDM, like UDP/IP (RTnet) or also CANopen. The enables thrilling
combinations without the need to rewrite your application.

The interest in such progress is there, not yet on the vendor side, but
on the user side - including many industrial users. And they can push
things forward as well, finally making at least some vendors more
cooperative, too.

Jan

--------------enigD24A89893F27C4A2DAEA0775
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDTi0QncNeS9Q0k+IRAv2bAKCQTCE5ICg2Ci+lMxCwe1oo4/llkACfbpNj
Yk5k4wKWpj4v062A7YN3KZ0=
=FoWf
-----END PGP SIGNATURE-----

--------------enigD24A89893F27C4A2DAEA0775--

