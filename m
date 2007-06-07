Message-ID: <4668440F.7020706@domain.hid>
Date: Thu, 07 Jun 2007 19:44:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
In-Reply-To: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0D2A388A13284E5C9EC400F0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] real time task disapears... memory problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: desvages@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D2A388A13284E5C9EC400F0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

desvages@domain.hid wrote:
>> What kind of statistics would you precisely need? And where would you
>> need it, means where is your scheduler located, what API does it use?
>=20
> I need execution time (and not response time). A patch for this has bee=
n
> create by a former student (now Doctor David Robert) working before me.=


Hmm, the patch looks like it consequently reimplements existing runtime
statistics instead of reusing them as a foundation...

Anyway, I think we could discuss some API extension of Xenomai (for
native, probably via rt_task_inquire). Likely we would keep this report
optional, ie. make it return -1 or so if CONFIG_XENO_OPT_STATS is off.
Tracking stats is not as costly as other instrumentations, but it's also
not free. If you are interested, let us know. It won't be a one-liner,
but it doesn't look like it has to be as invasive as your approach.

> You can find it enclosed with this mail. Anyway the problem doesn't com=
e
> from this patch, it appears also with vanilla xenomai.

OK.

>=20
>> Primarily code. We need your code that demonstrates the weird behaviou=
r.
>> If you patched Xenomai in any way, that patch would be required as wel=
l
>> of course.
>=20
> I have reduced the size of the code to the thing that is not working. Y=
ou
> can find it enclosed.
> The main program creates a task that calls the gsl_qp function (a
> quadratic solver).
> The problem appends during the call of ql0001_. If I remove this call, =
it
> works. I if keep it, the task disapears without any error (I only see t=
hat
> in /proc/xenomai/stat ).

This sounds like some fault is triggered and your program simply
terminates on report of the same ("Hey, if I add that printf, my program
stops. What's wrong with printf?" -- You can't imagine how often I
already heard this. ;) ).

>=20
>> BTW, did you already try to attach gdb to your disappearing process?
>> Maybe it can catch what makes it terminate.
> I have tried without success, but I don really know how to use it in th=
at
> way...

You should compile it with "-g", start it with "gdb <your program>" (or
the graphical front-end "ddd"), simply let it "run" and wait what gdb
reports. It should really say /something/.

I can't help anyway, some files are missing, at least gsl/gsl_matrix.h.
If I shall have a look, I really need a smaller test-case, only
including Xenomai interaction.

>=20
> My config: (I have install the last availlable xenomai since last mail)=

> - Linux kernel : 2.6.20.3
> - xenomai : 2.3.1
> - Adeos : 1.7-03
> - Laptop compact Evo N600c Pentium 3M 1.2Ghz
>=20
>> .config, Xenomai version, and I-pipe version can be helpful too.
> .config is enclosed (DentiX231)
>=20
>=20
>> Jan
>=20
> Thanks for your help
>=20
> Arnaud DESVAGES
>=20

Jan


--------------enig0D2A388A13284E5C9EC400F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaEQPniDOoMHTA+kRAk25AJ0cm/p/MKIdfMyhOVfpYMtbPb4BiQCcCQKh
7IxxUZ2kBOY52Ud1gQTs7e0=
=fYLM
-----END PGP SIGNATURE-----

--------------enig0D2A388A13284E5C9EC400F0--

