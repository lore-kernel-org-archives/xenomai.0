Message-ID: <472ECC0C.6080601@domain.hid>
Date: Mon, 05 Nov 2007 08:53:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4717C642.6030002@domain.hid> <1192764423.6252.4.camel@domain.hid>
	<4718651D.9070602@domain.hid>
In-Reply-To: <4718651D.9070602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEC4CEF82DA503EB19273D5EF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] avoid resched test on syscall entry
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEC4CEF82DA503EB19273D5EF
Content-Type: multipart/mixed;
 boundary="------------080906010200020602060604"

This is a multi-part message in MIME format.
--------------080906010200020602060604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Thu, 2007-10-18 at 22:46 +0200, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> what's the point about
>>>
>>> 	if (xnsched_resched_p())
>>> 		xnpod_schedule();
>>>
>>> at the beginning of do_hisyscall_event() [1]? Could you provide a
>>> comment for the background of this hunk? Or can we even remove it?
>> No, we can't. It's a Blackfin-specific thing in disguise actually, so =
we
>> may make this code conditional through some arch-dependent wrapper
>> though.
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/include/asm-blackfin=
/bits/pod.h#141
>>
>=20
> Something like the attached patch?

Because you pointed out that overloading functions names with macros can
be problematic (with older compilers?), here comes a variant free of
such a pattern.

Jan

--------------080906010200020602060604
Content-Type: text/x-patch;
 name="add-xnarch_hisyscall_entry-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="add-xnarch_hisyscall_entry-v2.patch"

---
 include/asm-blackfin/system.h |    7 +++++++
 include/asm-generic/system.h  |    4 ++++
 ksrc/nucleus/shadow.c         |    3 +--
 3 files changed, 12 insertions(+), 2 deletions(-)

Index: xenomai/include/asm-blackfin/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-blackfin/system.h
+++ xenomai/include/asm-blackfin/system.h
@@ -95,6 +95,13 @@ static inline void xnarch_free_host_mem=20
     kfree(chunk);
 }
=20
+static inline void __xnarch_hisyscall_entry(void)
+{
+	if (xnsched_resched_p())
+		xnpod_schedule();
+}
+#define xnarch_hisyscall_entry	__xnarch_hisyscall_entry
+
 #ifdef __cplusplus
 }
 #endif
Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -410,6 +410,10 @@ static inline int xnarch_remap_io_page_r
     return wrap_remap_io_page_range(vma,from,to,size,prot);
 }
=20
+#ifndef xnarch_hisyscall_entry
+static inline void xnarch_hisyscall_entry(void)	{ }
+#endif
+
 #ifdef __cplusplus
 }
 #endif
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -1878,8 +1878,7 @@ static inline int do_hisyscall_event(uns
 	if (!xnpod_active_p())
 		goto no_skin;
=20
-	if (xnsched_resched_p())
-		xnpod_schedule();
+	xnarch_hisyscall_entry();
=20
 	p =3D current;
 	thread =3D xnshadow_thread(p);

--------------080906010200020602060604--

--------------enigEC4CEF82DA503EB19273D5EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHLswMniDOoMHTA+kRAv7DAKCBnzu22uBOSbZTlOL2pC1PI3qubACfW8Mz
u9B1eK51hr4aUDs9Dtta1Yk=
=45eS
-----END PGP SIGNATURE-----

--------------enigEC4CEF82DA503EB19273D5EF--

