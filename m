Message-ID: <44468928.8040202@domain.hid>
Date: Wed, 19 Apr 2006 21:02:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] clean up latest ipipe-tracing changes
References: <4443BF6E.907@domain.hid> <4444DEC7.8040806@domain.hid>
In-Reply-To: <4444DEC7.8040806@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1DD01E488C7509F704AF66A"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1DD01E488C7509F704AF66A
Content-Type: multipart/mixed; boundary="------------040504020803000603060707"

This is a multi-part message in MIME format.
--------------040504020803000603060707
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> here is a suggestion to do a tiny cleanup of Gilles' cpuid-fix for the=

>> tracer. Sorry that I didn't comment on this earlier. Nothing critical
>> though.
>>
>> I think it's better to drag the include/linux/compiler.h changes into
>> the main patch instead of starting to use
>> __attribute__((no_instrument_function)) all over the place just to avo=
id
>> notrace (especially as I expect that Ingo's tracer will get merged
>> anyway in the future). Moreover, local_irq_restore_hw_notrace & frieds=

>> are available even for !CONFIG_IPIPE_TRACE, so no need to differentiat=
e
>> here. Finally, I do not see a need for marking a static inline functio=
n
>> non-traced.
>>
>> The patch does not seem to produce different binary code (I checked
>> kernel/ipipe/tracer.o) - as expected.
>>
>=20
> Applied, leaving the ipipe_processor_id() unchanged though. Thanks.
>=20

I still think this makes more sense :) (otherwise, at least switch to
"notrace").

Jan

--------------040504020803000603060707
Content-Type: text/x-patch;
 name="tracer-cleanup2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tracer-cleanup2.patch"

Index: linux-2.6.16-ipipe/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16-ipipe.orig/include/asm-i386/ipipe.h
+++ linux-2.6.16-ipipe/include/asm-i386/ipipe.h
@@ -97,11 +97,11 @@
 #define IPIPE_CRITICAL_VECTOR  0xf9	/* Used by ipipe_critical_enter/exit=
() */
 #define IPIPE_CRITICAL_IPI     (IPIPE_CRITICAL_VECTOR - FIRST_EXTERNAL_V=
ECTOR)
=20
-static inline __attribute__((no_instrument_function)) int ipipe_processo=
r_id(void)
-{
-	extern int (*__ipipe_logical_cpuid)(void);
-	return __ipipe_logical_cpuid();
-}
+#define ipipe_processor_id() \
+({ \
+	extern int (*__ipipe_logical_cpuid)(void); \
+	__ipipe_logical_cpuid(); \
+})
=20
 extern u8 __ipipe_apicid_2_cpu[];
=20

--------------040504020803000603060707--

--------------enigB1DD01E488C7509F704AF66A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERokoniDOoMHTA+kRAgoUAJ9NPbi5b7S7NQ62U38Dy762/kS6VgCdGw+u
+VTcIak3vvmSdYrAEWRwRik=
=YBMn
-----END PGP SIGNATURE-----

--------------enigB1DD01E488C7509F704AF66A--

