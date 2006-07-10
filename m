Message-ID: <44B28DBA.6070606@domain.hid>
Date: Mon, 10 Jul 2006 19:26:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] memset of heap crashes Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F91A5@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F91A5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A0E2AD1150A9995D7DD1A63"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A0E2AD1150A9995D7DD1A63
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Xenomai Version : 2.2-rc2
> Skin : native
> Kernel : 2.4.25
> Arch.: PPC
>=20
> I try to allocate as much memory as possible with the functions :
> rt_heap_create and
> rt_heap_alloc.
> (see also "Xenomai heap services" in this mailing list; see source
> attached)
>=20
> When I try to use the allocated memory with memset, the Xenomai-task
> crashes with a "Segmentation fault".
>=20
> Is memset allowed to be used with Xenomai heaps ?
> If so, could somebody try to reproduce this (preferable with a PPC), to=

> see whether it is a common problem or just one of my configuration .
> I have the feeling it is timing dependend, as it does not crash every
> time. So try to start it several times, please.
>=20

Nice test case with a tendency to jump out of every half-opened window
around. :)

First of all, I'm not sure if that 8K of stack is enough on PPC with
2.4, on x86 over 2.6 it isn't. The native skin picks PTHREAD_STACK_MIN*4
for you by default. Is this too much? Unless dealing with dozens of
*simple* threads, reducing this makes no sense to me.

Then there was this bug:

@@ -168,13 +169,13 @@
 void root_thread_exit(void)
 {
    int i;
-   RT_HEAP_INFO *hpinfo;
+   RT_HEAP_INFO hpinfo;

    printf("UDP->root_thread_exit\n");

    for(i=3D0;i<MAXHEAPBLOCKS;i++)
    {
-      if( !rt_heap_inquire(&bigheap[i],hpinfo) )
+      if( !rt_heap_inquire(&bigheap[i],&hpinfo) )
          rt_heap_delete(&bigheap[i]);
    }

Now I get some other strange effects (e.g. kernel oopses after OOM
oopses) that need a closer look under qemu later.

Jan


--------------enig8A0E2AD1150A9995D7DD1A63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEso27niDOoMHTA+kRAsjoAJ9wYDHqmKQVqtNCNa3QG5rsYgUyWQCeM+Ik
YiXamp381hfgAdUc2Ya1tDs=
=GuKV
-----END PGP SIGNATURE-----

--------------enig8A0E2AD1150A9995D7DD1A63--

