Message-ID: <45796841.4040106@domain.hid>
Date: Fri, 08 Dec 2006 14:27:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] module usage counter of
	xenomai	native	corrupted (version 2.2.0 and 2.2.5)
References: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>	<457826BC.1080008@domain.hid>
	<4579248A.8040201@domain.hid> <4579387F.7030505@domain.hid>
	<457956F3.6090904@domain.hid>
In-Reply-To: <457956F3.6090904@domain.hid>
Content-Type: multipart/mixed; boundary="------------080606010507030809090605"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080606010507030809090605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>=20
>>Gilles Chanteperdrix wrote:
>>
>>>Jan Kiszka wrote:
>>>
>>>
>>>>Thomas Wiedemann wrote:
>>>>
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>there seems to be a bug in rt_task_create(). When no more memory is
>>>>>available, the module usage counter of xeno_native is decremented. I
>>>>>guess it is not incremented before, however, so the counter gets 0 a=
nd
>>>>>wraps then to a negative number. It is therefore not possible to rem=
ove
>>>>>the module.
>>>>>
>>>>>I appended a small program to demonstrate this. It simply eats up al=
l
>>>>>memory from xenomai by registering as much mutexes as possible,
>>>>>and then tries to execute rt_task_create(), which fails. When starte=
d
>>>>>again, the bug occurs at rt_task_shadow(), as the mutexes have never
>>>>>been deleted.
>>>>>Compile with  gcc -O2 -Wall `xeno-config --xeno-cflags` `xeno-config
>>>>>--xeno-ldflags` -lrtdm -lnative -o rttest rttest.c
>>>>>then simply run it, and watch the output of lsmod before and after.
>>>>>
>>>>>Tested with xenomai 2.2.{0,5} and linux 2.6.17.8, modules loaded:
>>>>>xeno_native and xeno_nucleus.
>>>>>
>>>>
>>>>Confirmed. Requires a closer look to find the leak path.
>>>
>>>Here is what happens: the task is created with the XNSHADOW bit, and
>>>destroyed before it was xnshadow_mapped, but the deletion hook calls
>>>xnshadow_unmap because the task has the XNSHADOW bit. And xnshadow_unm=
ap
>>> decrements the module count.
>>
>>Here is an untested quick fix.
>>
>>
>>
>>-----------------------------------------------------------------------=
-
>>
>>Index: ksrc/nucleus/shadow.c
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>--- ksrc/nucleus/shadow.c	(r=C3=A9vision 1930)
>>+++ ksrc/nucleus/shadow.c	(copie de travail)
>>@@ -888,6 +888,9 @@
>>=20
>> 	p =3D xnthread_archtcb(thread)->user_task;	/* May be !=3D current */
>>=20
>>+	if (!xnshadow_thrptd(p))
>>+		return;
>>+
>> 	magic =3D xnthread_get_magic(thread);
>>=20
>> 	for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {
>=20
>=20
> Nope, shows unwanted side effects, probably because xnshadow_thrptd is
> already NULL'ed in do_taskexit_event. Looks like it takes an extra flag=
, no?

Setting xnshadow_thrptd to NULL in do_taskexit_event does not seem to be
 that useful. Here comes version 2.

--=20
                                                 Gilles Chanteperdrix

--------------080606010507030809090605
Content-Type: text/x-patch;
	name="xeno-avoid-unmapping-not-yet-mapped-shadow.2.diff"
Content-Disposition: inline;
	filename="xeno-avoid-unmapping-not-yet-mapped-shadow.2.diff"
Content-Transfer-Encoding: quoted-printable

Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(r=C3=A9vision 1930)
+++ ksrc/nucleus/shadow.c	(copie de travail)
@@ -888,6 +888,9 @@
=20
 	p =3D xnthread_archtcb(thread)->user_task;	/* May be !=3D current */
=20
+	if (!xnshadow_thrptd(p))
+		return;
+
 	magic =3D xnthread_get_magic(thread);
=20
 	for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {
@@ -1639,8 +1642,6 @@
 		xnshadow_relax(0);
=20
 	xnlock_get_irqsave(&nklock, s);
-	/* Prevent wakeup call from xnshadow_unmap(). */
-	xnshadow_thrptd(p) =3D NULL;
 	xnthread_archtcb(thread)->user_task =3D NULL;
 	/* xnpod_delete_thread() -> hook -> xnshadow_unmap(). */
 	xnpod_delete_thread(thread);

--------------080606010507030809090605--

