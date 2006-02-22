Message-ID: <43FC7C8E.3040902@domain.hid>
Date: Wed, 22 Feb 2006 16:00:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
References: <C021B37E.24C4%steve@domain.hid>
In-Reply-To: <C021B37E.24C4%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig19C9CB4356D69A35A1D638BE"
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig19C9CB4356D69A35A1D638BE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> There is a awful amount of code in this project, and I should point out=
 that
> this same code did not exhibit these problems under a fusion cvs from

You code contains a wrong assumption about the execution context. Older
Xenomai/fusion versions may have concealed this due to different
internal design.

> October. I can see about posting the full code, but my supervisors don=B9=
t
> want anything having our hardware addresses in it going out.
>=20
> This is an x86 board, so inb/outb are just instructions.

Then please shrink down your scenario so that

a) no proprietary code or addresses are contained AND
b) only a minimum of surrounding code is used AND
c) the problem (timing issues) still show up.

This first of all means to replace the specific detection of deadline
misses (flickering LEDs) with a generic mechanism - e.g. the latency
tool. Then we can try to reproduce your problem or already find the
issue in the test code. As I pointed out: mixing non-RT with RT code is
feasible but requires careful design.

>=20
> I know about the volatile thing but that isn=B9t my problem. I=B9m havi=
ng
> realtime preemption issues.
>=20
> Steven
>=20
> On 2/21/06 1:20 PM, "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid.=
com>
> wrote:
>=20
>> It would be helpful if a complete code could be posted. That means, in=
cluding
>> the main() function, in which the task dispatching is done as well.
>> =20
>> Furthermore, be sure to declare counting variables inside waiting loop=
s with
>> the 'volatile' specifier. The compiler might optimize it away otherwis=
e.
>> =20
>> Another, maybe dumb suggestion: how is inb() / outb() actually impleme=
nted on
>> your platform ?
>> =20
>> =20
>> Jeroen.
>> =20
>>
>=20
>=20
>=20

Jan


--------------enig19C9CB4356D69A35A1D638BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/HyOniDOoMHTA+kRAqp+AJ0afzcSOYb6OYz9DBeKXelReTS3ZQCfZKK1
j0z4Hl1mugZYEIMuFuIVjdo=
=uMg/
-----END PGP SIGNATURE-----

--------------enig19C9CB4356D69A35A1D638BE--

