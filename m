Message-ID: <45768147.7050001@domain.hid>
Date: Wed, 06 Dec 2006 09:37:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-1?Q?_Switch_mode_with_x86?=
References: <s56d88c0.099@domain.hid> <45732660.6050605@domain.hid>	
	<1165175999.4952.431.camel@domain.hid> <45733D1B.7010805@domain.hid>	
	<1165188655.4952.457.camel@domain.hid> <4573D896.9050200@domain.hid>	
	<45748DE3.9030300@domain.hid> <1165357040.7218.15.camel@domain.hid>
In-Reply-To: <1165357040.7218.15.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD2D12A6FF547F25231F66EDD"
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
--------------enigD2D12A6FF547F25231F66EDD
Content-Type: multipart/mixed; boundary="------------040204070900060806060508"

This is a multi-part message in MIME format.
--------------040204070900060806060508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-12-04 at 22:06 +0100, Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> ...
>>> This indicates that we face an I-pipe bug: the scheduled Linux call o=
n
>>> relaxation of TASK2 and then later TASK1 somehow gets lost (there is =
no
>>> rthal_apc_handler in the remaining trace).
>> I think I got it. No I-pipe bug, but one in the HAL.
>>
>> What happened? A weird race caused by the unprotected optimisation to
>> only call rthal_schedule_irq() if there is no APC pending yet. This is=

>> the constellation I finally worked out via instrumenting and tracing:
>>
>> PRIO 1:
>> rthal_apc_schedule()
>>   test&set rthal_apc_pending
>>   (but no rthal_schedule_irq() yet)
>>
>>                         -PREEMPTION-
>>
>>                                         PRIO 99:
>>                                         ...
>>                                         rthal_apc_schedule()
>>                                           test rthal_apc_pending
>>                                           (already set =3D> no
>>                                           rthal_schedule_irq()!)
>>
>> So, no one reported the ACP to I-pipe, and no one ever will in Nicolas=

>> scenario - soft lock-up!
>>
>> Nicolas, please give the attached patch a try. Your test is running fi=
ne
>> for me now.
>>
>>
>> At this chance: do we need rthal_apc_schedule() returning the previous=

>> state at all? No current caller checks the return value. If it's OK to=

>> clean this up, I will post a combined patch.
>=20
> It's pointless to return this info, the caller would not be able to
> exploit it in any way.
>=20
> Could you please try this other form of your fix? This would prevent th=
e
> virq to be fired twice (or more) uselessly, with no request pending.
> Masking interrupts to enforce atomicity is ok here, since
> rthal_schedule_irq() will run this way in any case. Additionally, my
> comment about migration was suspicious, I do see a case where CPU
> migration would leave this code in limbos. But to get the cpuid
> properly, we need the local interrupts to be masked first. TIA,

Yes, works fine as well.

Then go for the attached fix+cleanup?

Jan

--------------040204070900060806060508
Content-Type: text/x-patch;
 name="fix-rthal_apc_schedule-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-rthal_apc_schedule-v2.patch"

Index: ksrc/arch/generic/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/generic/hal.c	(Revision 1920)
+++ ksrc/arch/generic/hal.c	(Arbeitskopie)
@@ -565,7 +565,7 @@ int rthal_apc_free(int apc)
=20
 /**
  * @fn int rthal_apc_schedule (int apc)
- *                          =20
+ *
  * @brief Schedule an APC invocation.
  *
  * This service marks the APC as pending for the Linux domain, so that
@@ -580,8 +580,7 @@ int rthal_apc_free(int apc)
  *
  * @param apc The APC id. to schedule.
  *
- * @return 0 or 1 are returned upon success, the former meaning that
- * the APC was already pending. Otherwise:
+ * @return 0 is returned upon success. Otherwise:
  *
  * - -EINVAL is returned if @a apc is invalid.
  *
@@ -596,18 +595,21 @@ int rthal_apc_free(int apc)
 int rthal_apc_schedule(int apc)
 {
     rthal_declare_cpuid;
+    unsigned long flags;
=20
     if (apc < 0 || apc >=3D RTHAL_NR_APCS)
         return -EINVAL;
=20
-    rthal_load_cpuid();         /* Migration would be harmless here. */
+    rthal_local_irq_save(flags);
+
+    rthal_load_cpuid();
=20
-    if (!test_and_set_bit(apc, &rthal_apc_pending[cpuid])) {
+    if (!__test_and_set_bit(apc, &rthal_apc_pending[cpuid]))
         rthal_schedule_irq(rthal_apc_virq);
-        return 1;
-    }
=20
-    return 0;                   /* Already pending. */
+    rthal_local_irq_restore(flags);
+
+    return 0;
 }
=20
 #ifdef CONFIG_PROC_FS

--------------040204070900060806060508--

--------------enigD2D12A6FF547F25231F66EDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFdoFKniDOoMHTA+kRAlovAJ9Hb8UF8l9m6Cy3EqH88bXgip4OfgCeLd8L
TNjzIi4ond1zIJyEiAnkQ6E=
=YMBW
-----END PGP SIGNATURE-----

--------------enigD2D12A6FF547F25231F66EDD--

