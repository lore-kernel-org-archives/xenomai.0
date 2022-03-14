From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] cobalt/sched: Use nr_cpumask_bits instead of BITS_PER_LONG
Date: Mon, 14 Mar 2022 21:38:41 +0100
Message-Id: <20220314203841.28925-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>

BITS_PER_LONG is too broad, the max number of usable bits is limited
by nr_cpumask_bits.
Found while debugging a system with CONFIG_DEBUG_PER_CPU_MAPS enabled.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 88c4951ed814..aa65fd7f5d63 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -1370,7 +1370,7 @@ static int affinity_vfile_show(struct xnvfile_regul=
ar_iterator *it,
 	unsigned long val =3D 0;
 	int cpu;
=20
-	for (cpu =3D 0; cpu < BITS_PER_LONG; cpu++)
+	for (cpu =3D 0; cpu < nr_cpumask_bits; cpu++)
 		if (cpumask_test_cpu(cpu, &cobalt_cpu_affinity))
 			val |=3D (1UL << cpu);
=20
@@ -1395,7 +1395,7 @@ static ssize_t affinity_vfile_store(struct xnvfile_=
input *input)
 		affinity =3D xnsched_realtime_cpus; /* Reset to default. */
 	else {
 		cpumask_clear(&affinity);
-		for (cpu =3D 0; cpu < BITS_PER_LONG; cpu++, val >>=3D 1) {
+		for (cpu =3D 0; cpu < nr_cpumask_bits; cpu++, val >>=3D 1) {
 			if (val & 1) {
 				/*
 				 * The new dynamic affinity must be a strict
--=20
2.26.2


