Message-ID: <44D043A6.3070902@domain.hid>
Date: Wed, 02 Aug 2006 08:18:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Comedi4xenomai
References: <200608020050.35697.berlemont.hauw@domain.hid>
	<Pine.LNX.4.64.0608020735160.5922@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0608020735160.5922@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig278E78085D7C377467C08C4F"
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Orocos Developers <orocos-dev@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig278E78085D7C377467C08C4F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Herman Bruyninckx wrote:
> On Wed, 2 Aug 2006, Alexis Berlemont wrote:
>>
>> comedi-over-rtdm is currently undergoing deep modifications. I am
>> trying to
>> redefine an architecture more suitable for RTDM. That implies I am
>> rewriting
>> a big chunk of the Comedi code and its drivers without commiting into
>> SVN.
>>
>> I thought it was a bad idea to commit broken code (It does not even
>> compile).
>> Tell me if I'm wrong.
>=20
> You are right! But maybe it could be good to discuss your architecture =
on
> the xenomai mailinglist?

Ack. I would be interested in learning more details about the
differences between original comedi (which I still don't know well
enough) and your design. Will the user notice it? What will change for
comedi driver developers? How will the RTDM profile of comedi look like?

And I think that it could be helpful for such a discussion to update the
code in your branch - even if its not compiling.

Jan


--------------enig278E78085D7C377467C08C4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0EOmniDOoMHTA+kRAihAAJ9PVDyy+ptSoQ2+i0oQimF4URnmZQCfTRnZ
SqFW3FCYXIU7DAT/TUJDPZk=
=YAcb
-----END PGP SIGNATURE-----

--------------enig278E78085D7C377467C08C4F--

