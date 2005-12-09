Message-ID: <4399313A.6090004@domain.hid>
Date: Fri, 09 Dec 2005 08:24:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug?] set pthread stack size broken
References: <4398B958.8040705@domain.hid>
In-Reply-To: <4398B958.8040705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24C5275F0DB691AEB8262E51"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24C5275F0DB691AEB8262E51
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi,
> 
> something for the night: Can someone explain why normal pthreads can be
> restricted to initially use only the stack size provided via
> pthread_attr_setstacksize() while any rt-mapped thread (posix and
> native) refuse to accept this? For a simple test, compile the attached
> program one time as normal
> 
>     gcc -lpthread -o stacksize stacksize.c
> 
> and the other time against xeno's posix skin
> 
>     gcc `xeno-config --posix-cflags` `xeno-config --posix-ldflags` \
>         -o stacksize.o stacksize.c
> 
> Then compare the memory requirements of both processes - they should
> differ by 2M, the stack size when pthread_attr_setstacksize is not used.
> Strange - and also critical when considering larger applications...

This has been nailed down now to be some strange linker problem: while
the standard version of the stacksize demo calls the latest
pthread_create (__pthread_create_2_1 in glibc-2.3.x), the wrapped
real-time version and likely also applications linked against libnative
call an older pthread_create (__pthread_create_2_0). That variant
assumes that pthread_attr_t does not yet contain things like the stack
size and fills in the standard value again. :(

Can anyone with another build environment than my SuSE 10 confirm this?

> 
> So far I only tested against 2.1, but I don't see a reason why 2.0.x
> should behave different. Will get checked, though.
> 

Same behaviour on 2.0.x (SVN).

Jan

--------------enig24C5275F0DB691AEB8262E51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmTE6niDOoMHTA+kRApLyAJ91695oBfRIxOXBH5FJC+LPjn8zXgCfe772
/EXfoAFUft+iRBkrXJaWaZc=
=2SqB
-----END PGP SIGNATURE-----

--------------enig24C5275F0DB691AEB8262E51--

