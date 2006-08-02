Message-ID: <44D0F876.8020406@domain.hid>
Date: Wed, 02 Aug 2006 21:09:42 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] native heap services and overloading new
References: <38215.155.98.4.39.1154456700.squirrel@domain.hid>
In-Reply-To: <38215.155.98.4.39.1154456700.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24F9EDEEC26FDA7676A96D3B"
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
--------------enig24F9EDEEC26FDA7676A96D3B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
> I have some code where I'd like to be able to dynamically allocate memo=
ry
> in realtime.  Since the code is written in C++, I was thinking of just
> making a huge global RT_HEAP and overloading the new and delete operato=
rs
> to use the rt_heap_alloc and rt_heap_free functions.  First off, I'm
> wondering if there are any caveats to this sort of thing that wouldn't =
be
> obvious to someone new to xenomai like myself.  Second, if I fail to ca=
ll
> rt_heap_delete before the program terminates, does the heap remain
> registered hang potentially causing problems when I try to re-allocate =
the
> heap when the program is run again?  Thanks.

For now: yes, the heap will stay, no automatic cleanup (the posix skin
already have this). You could then run into naming conflicts and you
lose memory, of course.

But you could install some signal handler for cleaning up. We do so in
our native-skin-based framework (also C++, but no "evil" ;) features in
use). We even catch SIGSEGV this way.

Jan


--------------enig24F9EDEEC26FDA7676A96D3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0Ph2ncNeS9Q0k+IRAkJUAJ4wEDn3/JjAwJZ7RfYO/70U0CnYlACgsrXE
RkDiSMVkDShVwrYr0/KeRcE=
=SoMc
-----END PGP SIGNATURE-----

--------------enig24F9EDEEC26FDA7676A96D3B--

