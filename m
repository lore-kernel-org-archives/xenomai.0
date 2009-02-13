Message-ID: <4994D44C.9050205@domain.hid>
Date: Fri, 13 Feb 2009 03:00:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200902122231.25745.paul_c@domain.hid>
	<4994A5A1.9050402@domain.hid>
	<200902122319.45617.paul_c@domain.hid>
In-Reply-To: <200902122319.45617.paul_c@domain.hid>
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
> On Thursday 12 February 2009, Gilles Chanteperdrix wrote:
>> Paul wrote:
>>> Patching a 2.6.28.2 with the relevant patch in trunk, using a config =
with
>>> SMP enabled resulted in:
>>>
>>>   LD      kernel/xenomai/arch/built-in.o
>>>   CC      kernel/xenomai/nucleus/heap.o
>>> In file included from include/xenomai/nucleus/pod.h:34,
>>>                  from kernel/xenomai/nucleus/heap.c:66:
>>> include/xenomai/nucleus/sched.h: In function =E2=80=98xnsched_self_re=
sched_p=E2=80=99:
>>> include/xenomai/nucleus/sched.h:171: error: =E2=80=98nkpod=E2=80=99 u=
ndeclared (first use
>>> in this function)
>>> include/xenomai/nucleus/sched.h:171: error: (Each undeclared identifi=
er
>>> is reported only once
>>> include/xenomai/nucleus/sched.h:171: error: for each function it appe=
ars
>>> in.) make[3]: *** [kernel/xenomai/nucleus/heap.o] Error 1
>>>
>>>
>>> Digging in to the nucleus/sched.h and nucleus/pod.h headers, there
>>> appears to be a circular dependency around nkpod_struct - This only h=
its
>>> home with CONFIG_SMP defined.
>> There must be some other option triggering the bug, because I run trun=
k
>> with 2.6.28 on an SMP x86(_64).
>=20
> Attached, tarball of the two configs - One for SMP, the other, UP, both=
 for=20
> 32Bit.
>=20
> Looking at the changelog, I see xnsched_self_resched_p was introduced i=
n=20
> r4611 - Reverting the change allows compilation to progress...

The following patch replaces a division by a memory access, which should
be better on low-end and seems to fix the issue.

Index: include/nucleus/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/sched.h	(revision 4623)
+++ include/nucleus/sched.h	(working copy)
@@ -64,6 +64,7 @@ struct xnsched_rt {
 typedef struct xnsched {
=20
 	xnflags_t status;		/*!< Scheduler specific status bitmask. */
+	int cpu;
 	struct xnthread *curr;		/*!< Current thread. */
 	xnarch_cpumask_t resched;	/*!< Mask of CPUs needing rescheduling. */
=20
@@ -155,7 +156,7 @@ struct xnsched_class {
 #define XNSCHED_RUNPRIO   0x80000000
=20
 #ifdef CONFIG_SMP
-#define xnsched_cpu(__sched__)	((__sched__) - &nkpod->sched[0])
+#define xnsched_cpu(__sched__)	((__sched__)->cpu)
 #else /* !CONFIG_SMP */
 #define xnsched_cpu(__sched__)	({ (void)__sched__; 0; })
 #endif /* CONFIG_SMP */
@@ -228,7 +229,7 @@ static inline void xnsched_reset_watchdo
=20
 int xnsched_register_class(struct xnsched_class *sched_class);
=20
-void xnsched_init(struct xnsched *sched);
+void xnsched_init(struct xnsched *sched, int cpu);
=20
 void xnsched_destroy(struct xnsched *sched);
=20
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(revision 4623)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -407,7 +407,7 @@ int xnpod_init(void)
=20
 	for (cpu =3D 0; cpu < nr_cpus; ++cpu) {
 		sched =3D &pod->sched[cpu];
-		xnsched_init(sched);
+		xnsched_init(sched, cpu);
 		appendq(&pod->threadq, &sched->rootcb.glink);
 	}
=20
Index: ksrc/nucleus/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/sched.c	(revision 4623)
+++ ksrc/nucleus/sched.c	(working copy)
@@ -82,15 +82,16 @@ static void xnsched_watchdog_handler(str
=20
 #endif /* CONFIG_XENO_OPT_WATCHDOG */
=20
-void xnsched_init(struct xnsched *sched)
+void xnsched_init(struct xnsched *sched, int cpu)
 {
 	char htimer_name[XNOBJECT_NAME_LEN];
 	char root_name[XNOBJECT_NAME_LEN];
 	union xnsched_policy_param param;
 	struct xnthread_init_attr attr;
-	int cpu =3D xnsched_cpu(sched);
 	struct xnsched_class *p;
=20
+	sched->cpu =3D cpu;
+
 	for_each_xnsched_class(p) {
 		if (p->sched_init)
 			p->sched_init(sched);

--=20
					    Gilles.


