Message-ID: <46B86E53.1030803@domain.hid>
Date: Tue, 07 Aug 2007 15:06:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig600B7ACB2E7211E19969BC6C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [COW-BUG] __alloc_pages called from atomic context
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig600B7ACB2E7211E19969BC6C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

we are getting a lot of

BUG: sleeping function called from invalid context at mm/page_alloc.c:122=
5
in_atomic():1, irqs_disabled():0
 [<c010305d>] show_trace_log_lvl+0x1a/0x2f
 [<c0103156>] show_trace+0x12/0x14
 [<c0103915>] dump_stack+0x16/0x18
 [<c010c4ab>] __might_sleep+0xcd/0xd3
 [<c0149488>] __alloc_pages+0x32/0x281
 [<c014fdd2>] copy_page_range+0x221/0x41e
 [<c010ec18>] copy_process+0x9e1/0xfe2
 [<c010f415>] do_fork+0x99/0x176
 [<c0100e75>] sys_clone+0x33/0x39
 [<c0102aaf>] syscall_call+0x7/0xb
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

here due to a Xenomai program issuing system() calls.

After once again dissecting the "nice" mm code (sigh...), the reason
turned out to be plain simple:

copy_pte_range(...);
  spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
  copy_one_pte(...);
    if (is_cow_mapping(vm_flags))
      alloc_page_vma(GFP_HIGHUSER, ...);
        __alloc_pages(...)
	  might_sleep_if(gfp_mask & __GFP_WAIT);

And this is true due to #define GFP_HIGHUSER (__GFP_WAIT | ...

So the bad news is that the COW code in likely all i-pipe versions is
broken. But the good new is that this might be easily fixable by
providing the right gfp_mask. GFP_ATOMIC?

Jan


--------------enig600B7ACB2E7211E19969BC6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuG5TniDOoMHTA+kRAmxXAJ0Tl1J5yFtvek89a8A9LhmEXjCBLQCcCaxi
XHvDhJo8PLVRYLRo9xwpt1E=
=04z+
-----END PGP SIGNATURE-----

--------------enig600B7ACB2E7211E19969BC6C--

