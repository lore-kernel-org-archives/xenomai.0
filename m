Message-ID: <463B5B7F.6040501@domain.hid>
Date: Fri, 04 May 2007 18:12:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1178268043.5391.47.camel@domain.hid>		<463B0A58.4070206@domain.hid>
	<1178287470.22169.9.camel@domain.hid> <463B5A11.8080406@domain.hid>
In-Reply-To: <463B5A11.8080406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9F3B32977ACC58DCC7D5AEC5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9F3B32977ACC58DCC7D5AEC5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> CAMUS Benoit wrote:
>> / # rtnet -v start
>> Turning on verbose mode
>>
>> *** RTnet 0.9.9 - built on May  4 2007 13:20:37 ***
>>
>> RTnet: initialising real-time networking
>> LAN91C111: You shouldn't use auto-probing with insmod!
>>  Adresse recue: 0
>>  entraine une detection ? --> 0=20
>>  Detection brutale des adresses
>>  Demande de region avec l'adresse: 512
>>  Demande acceptee, selection du banc de registre sur 512 + 14
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 0000020e
>=20
> Jan will probably be of more help here. However, 0x20e is the
> hexadecimal value of 512 + 14. What about passing the correct I/O
> address of your card at insmod time using its "io" parameter ?
>=20

Ack. That nice driver required some io=3D argument on insmod, it actually=

doesn't do any kind of autoprobing. Looks like we should better fix the
error handling...

Jan


--------------enig9F3B32977ACC58DCC7D5AEC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGO1t/niDOoMHTA+kRAh2+AJ44Vab2jufZWpKrTB3CSuIzpkx3UwCfVMpm
iOCVrQf3bbtlkNcbZjkRzNg=
=Sxv4
-----END PGP SIGNATURE-----

--------------enig9F3B32977ACC58DCC7D5AEC5--

