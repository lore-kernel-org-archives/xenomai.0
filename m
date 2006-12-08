Message-ID: <4579A8CE.2040608@domain.hid>
Date: Fri, 08 Dec 2006 19:02:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] module usage counter of
	xenomai	native	corrupted (version 2.2.0 and 2.2.5)
References: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>	<457826BC.1080008@domain.hid>
	<4579248A.8040201@domain.hid> <4579387F.7030505@domain.hid>
	<457956F3.6090904@domain.hid> <45796841.4040106@domain.hid>
	<45797CC0.8010609@domain.hid>
In-Reply-To: <45797CC0.8010609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
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

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
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
>>@@ -1639,8 +1642,6 @@
>> 		xnshadow_relax(0);
>>=20
>> 	xnlock_get_irqsave(&nklock, s);
>>-	/* Prevent wakeup call from xnshadow_unmap(). */
>>-	xnshadow_thrptd(p) =3D NULL;
>> 	xnthread_archtcb(thread)->user_task =3D NULL;
>> 	/* xnpod_delete_thread() -> hook -> xnshadow_unmap(). */
>> 	xnpod_delete_thread(thread);
>=20
>=20
> Can't comment on the correctness of the second hunk, but it
> unfortunately doesn't change the situation that test case does not
> longer terminate with the first hunk applied. May look like a trivial
> issue - but it isn't. :->
>=20

Indeed. And xnshadow_thrptd(current) =3D=3D NULL is used by xnpod_schedul=
e,
so the patch is probably completely incorrect.

--=20
                                                 Gilles Chanteperdrix

