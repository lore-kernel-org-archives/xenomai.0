Message-ID: <49591295.4070209@domain.hid>
Date: Mon, 29 Dec 2008 19:10:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4958E439.9040503@domain.hid> <4958F2EE.8080804@domain.hid>
	<495908DA.7030304@domain.hid> <49590983.4010005@domain.hid>
In-Reply-To: <49590983.4010005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig360FCF5D83321C5CDAF775BA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] Fix include for kernel/panic.c
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig360FCF5D83321C5CDAF775BA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> +++ b/kernel/panic.c
>>>> @@ -21,6 +21,7 @@
>>>>  #include <linux/debug_locks.h>
>>>>  #include <linux/random.h>
>>>>  #include <linux/kallsyms.h>
>>>> +#include <linux/ipipe_trace.h>
>>> That is not enough, when compiling a kernel without I-pipe enabled, t=
he
>>> compiler complains about ipipe_processor_id.
>> Good point. But I wonder where the ipipe_processor_id wrapper for the
>> disabled case is - can't find it in adeos-ipipe-2.6.26-arm-1.11-02.pat=
ch
>> right now.
>=20
> It does not exist.

Ah, I see now. This hunk from my ipipe-lttng patch is required upstream:

Index: b/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -534,7 +534,8 @@ static inline void local_irq_restore_nos
 #define ipipe_irq_unlock(irq)		do { } while(0)
=20
 #define ipipe_root_domain_p		1
-#define ipipe_safe_current		current
+#define ipipe_processor_id()		smp_processor_id()
+#define ipipe_safe_current()		current
=20
 #define local_irq_disable_head()	local_irq_disable()
=20

Jan


--------------enig360FCF5D83321C5CDAF775BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklZEpkACgkQniDOoMHTA+kykgCdG4e32NLz7mN7OhDb/ld/mtKL
8KgAn2Dx9CD+BtkD5Dt2M68I39IkMiI4
=trhw
-----END PGP SIGNATURE-----

--------------enig360FCF5D83321C5CDAF775BA--

