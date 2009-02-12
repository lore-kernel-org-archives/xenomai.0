From: Paul <paul_c@domain.hid>
Date: Thu, 12 Feb 2009 22:31:25 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200902122231.25745.paul_c@domain.hid>
Subject: [Xenomai-core] SMP build failure (2.6.28)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Patching a 2.6.28.2 with the relevant patch in trunk, using a config with S=
MP=20
enabled resulted in:

  LD      kernel/xenomai/arch/built-in.o
  CC      kernel/xenomai/nucleus/heap.o
In file included from include/xenomai/nucleus/pod.h:34,
                 from kernel/xenomai/nucleus/heap.c:66:
include/xenomai/nucleus/sched.h: In function =E2=80=98xnsched_self_resched_=
p=E2=80=99:
include/xenomai/nucleus/sched.h:171: error: =E2=80=98nkpod=E2=80=99 undecla=
red (first use in=20
this function)
include/xenomai/nucleus/sched.h:171: error: (Each undeclared identifier is=
=20
reported only once
include/xenomai/nucleus/sched.h:171: error: for each function it appears in=
=2E)
make[3]: *** [kernel/xenomai/nucleus/heap.o] Error 1


Digging in to the nucleus/sched.h and nucleus/pod.h headers, there appears =
to=20
be a circular dependency around nkpod_struct - This only hits home with=20
CONFIG_SMP defined.


Regards, Paul.

