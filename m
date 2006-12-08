Message-ID: <4579387F.7030505@domain.hid>
Date: Fri, 08 Dec 2006 11:03:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] module usage counter of
	xenomai	native	corrupted (version 2.2.0 and 2.2.5)
References: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>	<457826BC.1080008@domain.hid>
	<4579248A.8040201@domain.hid>
In-Reply-To: <4579248A.8040201@domain.hid>
Content-Type: multipart/mixed; boundary="------------060602010109010900000608"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060602010109010900000608
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> 
>>Thomas Wiedemann wrote:
>>
>>
>>>Hi,
>>>
>>>there seems to be a bug in rt_task_create(). When no more memory is
>>>available, the module usage counter of xeno_native is decremented. I
>>>guess it is not incremented before, however, so the counter gets 0 and
>>>wraps then to a negative number. It is therefore not possible to remove
>>>the module.
>>>
>>>I appended a small program to demonstrate this. It simply eats up all
>>>memory from xenomai by registering as much mutexes as possible,
>>>and then tries to execute rt_task_create(), which fails. When started
>>>again, the bug occurs at rt_task_shadow(), as the mutexes have never
>>>been deleted.
>>>Compile with  gcc -O2 -Wall `xeno-config --xeno-cflags` `xeno-config
>>>--xeno-ldflags` -lrtdm -lnative -o rttest rttest.c
>>>then simply run it, and watch the output of lsmod before and after.
>>>
>>>Tested with xenomai 2.2.{0,5} and linux 2.6.17.8, modules loaded:
>>>xeno_native and xeno_nucleus.
>>>
>>
>>
>>Confirmed. Requires a closer look to find the leak path.
> 
> 
> Here is what happens: the task is created with the XNSHADOW bit, and
> destroyed before it was xnshadow_mapped, but the deletion hook calls
> xnshadow_unmap because the task has the XNSHADOW bit. And xnshadow_unmap
>  decrements the module count.

Here is an untested quick fix.

-- 
                                                 Gilles Chanteperdrix


--------------060602010109010900000608
Content-Type: text/x-patch;
	name="xeno-avoid-unmapping-not-yet-mapped-shadow.diff"
Content-Disposition: inline;
	filename="xeno-avoid-unmapping-not-yet-mapped-shadow.diff"
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

--------------060602010109010900000608--

