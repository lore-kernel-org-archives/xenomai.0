Message-ID: <44ACF9DA.4090203@domain.hid>
Date: Thu, 06 Jul 2006 13:54:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Detecting switch to secondary mode
References: <20060706134351.2e582664@domain.hid>
In-Reply-To: <20060706134351.2e582664@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD0BEB2091E7FA9B899BE24E3"
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
To: "J. Niehaus" <Niehaus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD0BEB2091E7FA9B899BE24E3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

J. Niehaus wrote:
> Hello,
>=20
> I have written a xenomai application (posix-skin) with several tasks. A=
ll of them should normally use primary mode (SCHED_FIFO). While some are =
allowed to switch to secondary mode for stuff like I/O and memory allocat=
ion others must not switch due to hard realtime constraints.=20
>=20
> Is there a way to check if and how often a thread has switched to secon=
dary mode and maybe even what system call caused the switch? While a test=
 from within the program itself would be great some information from /pro=
c/xenomai would also do.
>=20

Yes, see this example:
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/snipp=
ets/sigxcpu.c

We have the following code snippet in the signal handler of our RACK
framework:

void signal_handler(int sig)
{
[...]
    switch(sig)
    {
        case SIGXCPU:

            if (signal_flags & HANDLING_TERM) // ignore while
cleaning 		                                              // up
                return;

            printf("\n");
            printf("---=3D=3D=3D SIGNAL HANDLER of %s =3D=3D=3D---\n", cl=
assname);
            printf(" -> SIGXCPU (%02d)\n", sig);
            printf(" !!! WARNING unexpected switch to secondary mode "
                   "!!!\n");
            nentries =3D backtrace (array, 10);
            strings =3D backtrace_symbols (array, nentries);
            for (i =3D 0; i < nentries; i++)
            {
                printf ("  %s\n", strings[i]);
            }
            free (strings);
            printf("---=3D=3D=3D END OF %s SIGNAL HANDLER =3D=3D=3D---\n"=
,
                   classname);
            return;
[...]

I.e. it does a back-trace to show what happened in user-space (debug
symbols are required). It's VERY useful when letting beginners hack
their first RT applications.

Jan


--------------enigD0BEB2091E7FA9B899BE24E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErPnaniDOoMHTA+kRAn4ZAJ0cF6x+FvzhWvc1On2fcf8R3oqeuACggw4e
LRduW1tRqvtM7XG4rhKLNRE=
=1P8Z
-----END PGP SIGNATURE-----

--------------enigD0BEB2091E7FA9B899BE24E3--

