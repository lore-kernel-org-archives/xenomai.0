Message-ID: <4994A5A1.9050402@domain.hid>
Date: Thu, 12 Feb 2009 23:41:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200902122231.25745.paul_c@domain.hid>
In-Reply-To: <200902122231.25745.paul_c@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] SMP build failure (2.6.28)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Paul wrote:
> Patching a 2.6.28.2 with the relevant patch in trunk, using a config wi=
th SMP=20
> enabled resulted in:
>=20
>   LD      kernel/xenomai/arch/built-in.o
>   CC      kernel/xenomai/nucleus/heap.o
> In file included from include/xenomai/nucleus/pod.h:34,
>                  from kernel/xenomai/nucleus/heap.c:66:
> include/xenomai/nucleus/sched.h: In function =E2=80=98xnsched_self_resc=
hed_p=E2=80=99:
> include/xenomai/nucleus/sched.h:171: error: =E2=80=98nkpod=E2=80=99 und=
eclared (first use in=20
> this function)
> include/xenomai/nucleus/sched.h:171: error: (Each undeclared identifier=
 is=20
> reported only once
> include/xenomai/nucleus/sched.h:171: error: for each function it appear=
s in.)
> make[3]: *** [kernel/xenomai/nucleus/heap.o] Error 1
>=20
>=20
> Digging in to the nucleus/sched.h and nucleus/pod.h headers, there appe=
ars to=20
> be a circular dependency around nkpod_struct - This only hits home with=
=20
> CONFIG_SMP defined.

There must be some other option triggering the bug, because I run trunk
with 2.6.28 on an SMP x86(_64).

--=20
					    Gilles.


