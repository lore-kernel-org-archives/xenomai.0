Message-ID: <45E34014.6080105@domain.hid>
Date: Mon, 26 Feb 2007 21:16:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newby question, can/socket stuff
References: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>	<45E33BA0.6080903@domain.hid>
	<bc4264770702261206v1e3d84cbhe94b923540dbaae6@domain.hid>
In-Reply-To: <bc4264770702261206v1e3d84cbhe94b923540dbaae6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig01F00A78AD7EEC721E4F5000"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01F00A78AD7EEC721E4F5000
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
>=20
> You must all be getting very exasperated with me. :)

How did you guess this? ;)

>=20
>> > I know too little of the basic socket programming. Not even sure my
>> > wording in the previous sentence is capturing the correct area of
>> > ignorance.
>>
>> There are plenty text books on BSD socket programming and the rational=

>> behind it.
> These are the ones I need. But without the time to get hold of them I
> will have to search the net.

"man" is your friend (if installed on your linux distro). E.g.

# man recvmsg

Then there is the OpenGroups spec:

http://www.opengroup.org/onlinepubs/009695399/

But I thing before diving too deep into this, rather apply the
Chinaman's tactic.

>=20
>> > ret =3D rt_dev_ioctl(can_fd, SIOCGIFINDEX, &ifr);
>> >
>> > and
>> > ret =3D rt_dev_ioctl(can_fd, SIOCSCANBAUDRATE, &ifr);
>> >
>> > But exactly what is happening is beyond me at the moment.
>>
>> SIOCGIFINDEX gets the interface index for a named device and
>> SIOCSCANBAUDRATE allows to set the baudrate. The RT-Socket-CAN utiliti=
es
>=20
> My email must have been very bad. I realize roughly what SIOCGIFINDEX
> and  SIOCSCANBAUDRATE do. This is described very nicely in your
> documentation or rather the documentation that refers to you and which
> Gilles kindly also pointed out to me but which I already knew about.
>=20
> No my problem is with the
> rt_dev_ioctl
>=20
> part. I would like to have a better understanding of the part that
> these functions play.

Add 1 to 1: The CAN profile describes what IOCTLs are available for CAN
sockets. rt_dev_ioctl() (or ioctl() with the POSIX skin) is the way to
pass these IOCTLs down to the CAN stack.

I think this should be visible when making one step back, looking at the
whole picture of the documentation pieces and the examples, no?

>=20
>> are now even hyperlinked with the API doc (still not 100% perfect yet)=

>> e.g.:
>>
>> http://www.xenomai.org/documentation/trunk/html/api/rtcanconfig_8c-exa=
mple.html
>>
>=20
> And by tremendous chance this was also the code I was studying when I
> posted my email.
>=20
> Sorry to be such a nuisance. I'll see if I can google for some info on
> rt_dev_ioctl.
>=20
> Regards,
>=20
> Roland
>=20

Jan


--------------enig01F00A78AD7EEC721E4F5000
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF40AVniDOoMHTA+kRArimAJ9gMzNIJhw1nr1ITCKHvTXxIZF6wwCeLoux
bNcgNQ1+35s1WE5FVZJ5qis=
=1edi
-----END PGP SIGNATURE-----

--------------enig01F00A78AD7EEC721E4F5000--

