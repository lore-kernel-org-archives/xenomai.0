Message-ID: <45748DE3.9030300@domain.hid>
Date: Mon, 04 Dec 2006 22:06:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-1?Q?_Switch_mode_with_x86?=
References: <s56d88c0.099@domain.hid> <45732660.6050605@domain.hid>	
	<1165175999.4952.431.camel@domain.hid> <45733D1B.7010805@domain.hid>
	<1165188655.4952.457.camel@domain.hid> <4573D896.9050200@domain.hid>
In-Reply-To: <4573D896.9050200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A134F1702F15F0359695370"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A134F1702F15F0359695370
Content-Type: multipart/mixed; boundary="------------090603070704040809000401"

This is a multi-part message in MIME format.
--------------090603070704040809000401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> This indicates that we face an I-pipe bug: the scheduled Linux call on
> relaxation of TASK2 and then later TASK1 somehow gets lost (there is no=

> rthal_apc_handler in the remaining trace).

I think I got it. No I-pipe bug, but one in the HAL.

What happened? A weird race caused by the unprotected optimisation to
only call rthal_schedule_irq() if there is no APC pending yet. This is
the constellation I finally worked out via instrumenting and tracing:

PRIO 1:
rthal_apc_schedule()
  test&set rthal_apc_pending
  (but no rthal_schedule_irq() yet)

                        -PREEMPTION-

                                        PRIO 99:
                                        ...
                                        rthal_apc_schedule()
                                          test rthal_apc_pending
                                          (already set =3D> no
                                          rthal_schedule_irq()!)

So, no one reported the ACP to I-pipe, and no one ever will in Nicolas
scenario - soft lock-up!

Nicolas, please give the attached patch a try. Your test is running fine
for me now.


At this chance: do we need rthal_apc_schedule() returning the previous
state at all? No current caller checks the return value. If it's OK to
clean this up, I will post a combined patch.

Jan

--------------090603070704040809000401
Content-Type: text/x-patch;
 name="fix-rthal_apc_schedule.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-rthal_apc_schedule.patch"

Index: ksrc/arch/generic/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/generic/hal.c	(Revision 1918)
+++ ksrc/arch/generic/hal.c	(Arbeitskopie)
@@ -596,18 +596,19 @@ int rthal_apc_free(int apc)
 int rthal_apc_schedule(int apc)
 {
     rthal_declare_cpuid;
+    int ret =3D 1;
=20
     if (apc < 0 || apc >=3D RTHAL_NR_APCS)
         return -EINVAL;
=20
     rthal_load_cpuid();         /* Migration would be harmless here. */
=20
-    if (!test_and_set_bit(apc, &rthal_apc_pending[cpuid])) {
-        rthal_schedule_irq(rthal_apc_virq);
-        return 1;
-    }
+    if (test_and_set_bit(apc, &rthal_apc_pending[cpuid]))
+        ret =3D 0;                /* Already pending. */
+
+    rthal_schedule_irq(rthal_apc_virq);
=20
-    return 0;                   /* Already pending. */
+    return ret;
 }
=20
 #ifdef CONFIG_PROC_FS

--------------090603070704040809000401--

--------------enig4A134F1702F15F0359695370
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFdI3oniDOoMHTA+kRArhUAJ9GU43e3K92bG3VhPalknf3vpvAygCeJvDX
d/33Aq18zDTL0ESwEO1u+vI=
=UxTk
-----END PGP SIGNATURE-----

--------------enig4A134F1702F15F0359695370--

