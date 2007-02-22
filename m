Message-ID: <45DDB2DB.4010104@domain.hid>
Date: Thu, 22 Feb 2007 16:12:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] hello xenomai world?
References: <bc4264770702220311m604b0dcdh2543e40405451147@domain.hid>	
	<45DD7E00.8020505@domain.hid>	
	<bc4264770702220456se1cb181r8aee5fde75c93db4@domain.hid>	
	<45DD99D1.9000600@domain.hid>
	<bc4264770702220641me28831ahd9e10cf1b689510c@domain.hid>
In-Reply-To: <bc4264770702220641me28831ahd9e10cf1b689510c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF3A53C958426F1BAF9C8897"
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
--------------enigAF3A53C958426F1BAF9C8897
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi Jan,
>=20
>> See, you seem to manage choosing the complicated, non-standard way of
>> doing things first. Now try to solve your issues one by one, not in
>> arbitrary order.
> :)  Its not quite as arbitrary as it may seem.
>=20
>> 1. Make your kernel boot fine, including all desired modules, without
>> having it issue any kind of error messages. Bootlogs are under /var/lo=
g,
>> just look into those files.
> All sorted out! Remember that the kernel was fine.  I could only
> realized that something was missing when I tried rtcanconfig and I
> could not find the /rtcan0 and /rtcan1. For someone entirely new to
> both xenomai and rt-can its not surprising this take place. I stuck as
> closely as possible to the default suggestion in the kernel config.
> AFAIK the virtual device was not selected.
>=20

Feel free to write down some "first steps with CAN under Xenomai" once
you are through (=3D>wiki)! The virtual devices are not explicitly
documented yet. But making them default on the other hand is overkill,
because they are special to most users (with real hardware).

>=20
>> 2. Check where you have installed the user space part. Default is
>> /usr/xenomai, and for a first run it's probably wise to keep this.
> Sorted! Absolutely, this is where I have had it installed all the
> time. It seems to be in perfect shape.
>=20
>> 3. Check if you can build the examples repository. If you installed th=
e
>> user space part to default location, it must work with only providing
>> the "make KSRC=3D<path-to-kernel-src>" as described in the Makefile.
>> Inside examples/native, you even just need to type "make".
> Well this is not quite the case. I install to the correct places
> actually I have from the start used the directories exactly as they
> are suggested int he documentation. I have jsut reinstalled and the
> make procedure seems fine. My install directory works and the programs
> therein are now all functioning. Even rtcongi rtcansend and rtcanrecv.
> Running make in /examples/native says
>=20
> Invoke make like this: make /path to xeno-config/. Which is why I was
> going on about the config variables. I wil now try and find
> xeno-config if it exists and see how that works. On the other hand I
> don;t doubt that the application will compile. I need to find out what
> libraries to include for this particular one for the next steps. See
> later.

Ack, my bad. The example makefiles do not assume /usr/xenomai (or,
alternatively, /usr/xenomai/bin/xeno-config) as default for XENO. Will fi=
x.

Meanwhile try "make XENO=3D/usr/xenomai".

>=20
> The point being that 1, 2 and 3 have been completed in that order. To
> lay out the structure of what is planned next:
>=20
> 4-Get a task ala trivial-task compiled into a qt C++ project. (for
> which I need to know what libraries are required)
>=20
> 5-Write this task to read CAN messages ever 1 ms and write them to cons=
ole.
>=20
> 6-Get multiple tasks into the project running at different times
>=20
> I do understand your consternation, I have been very verbose on this
> list today.

Your feedback is appreciated and helps improving things. Just a certain
part of your verbosity might have been avoidable by digging a bit deeper
and checking twice, no? :)

Jan


--------------enigAF3A53C958426F1BAF9C8897
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3bLbniDOoMHTA+kRArLrAJ9EEdRz2cIkR8uYItKvpHat7IFApACePCty
fLp5s52wLDrLHKGhIwa4ro8=
=uESn
-----END PGP SIGNATURE-----

--------------enigAF3A53C958426F1BAF9C8897--

