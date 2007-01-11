Message-ID: <45A6C97A.4090406@domain.hid>
Date: Fri, 12 Jan 2007 00:34:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG?] registry usage + module removal causes
	kernel	oops (xenomai native)
References: <OF4D873F49.344BC96D-ONC1257260.005DC836-C1257260.00617F2A@retarus.de>
	<45A67C77.3070006@domain.hid>
In-Reply-To: <45A67C77.3070006@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5856BB591C213E5CBF6125A"
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
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5856BB591C213E5CBF6125A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Thomas Wiedemann wrote:
>> Another bug appeared for objects registered at the registry. When
>> using xeno-native and xeno-rtdm, the order of removal seems to be
>> important. I appended a small code sample to register a mutex at
>> the registry. After the program exits, the modules can not be unloaded=

>> in the order
>>   1) xeno-native
>>   2) xeno-rtdm,
>> but the other way around works fine. Instead, rmmod ends up with a
>> segmentation fault, dmesg output appended.
>>
>> I tested this on xenomai 2.3.0/linux 2.6.19 and 2.2.5-svn/linux2.6.17.=
14.
>>
>=20
> Looks like it's related to the left-over mutex in the registry. Probabl=
y
> the other order just papers the issue. $Someone should give your code a=

> try, maybe I can check later with a debugger.

Yet another reason to address auto-cleanup soon: I thought to remember
the native skin keeps track of resources in a global list and kills them
on rmmod, but that's only true for a few.

Instead stalled named resources are kept in the registry. On
unregistration of the last skin xnregistry_cleanup() is called. It tries
to kill the stalled entries from proc but their roots may have already
been removed (here: the native skin's proc root).

Philippe, this makes the sweep loop in xnregistry_cleanup rather fragile
and of questionable use. I guess all skins have to handle this on their
own, and we should just bark loudly here if something remained.

Jan


--------------enigC5856BB591C213E5CBF6125A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpsl6niDOoMHTA+kRArGsAJ0TPD4mAaRcL8LI4Show+PKeQqt/gCfX6Vk
av++qoCsTE//15BJDit+S60=
=m3Ul
-----END PGP SIGNATURE-----

--------------enigC5856BB591C213E5CBF6125A--

