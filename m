From: Jan Kiszka <jan.kiszka@web.de>
Subject: [v5.13.y-dovetail][PATCH 2/2] irq_pipeline: Account for stage
 migration across faults
Message-ID: <0eb03889-d16d-3446-e07b-a4a36964ef15@web.de>
Date: Thu, 3 Jun 2021 11:50:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to unstall the inband stage when we entered for a fault over OOB
and unstalled and then migrated to inband. So far we kept the inband
stage stalled, causing a state corruption this way.

Introduce an additional state to irqentry_info for this, tracking the
stalling state on OOB entry.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--

Note: Tested only as backport to 5.10-x86 so far.

 include/linux/entry-common.h |  3 ++-
 kernel/entry/common.c        | 10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2a08b00632b9..782e94b88076 100644
=2D-- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -402,7 +402,8 @@ void irqentry_exit_to_user_mode(struct pt_regs *regs);
 enum irqentry_info {
 	IRQENTRY_INBAND_UNSTALLED =3D 0,
 	IRQENTRY_INBAND_STALLED,
-	IRQENTRY_OOB,
+	IRQENTRY_OOB_UNSTALLED,
+	IRQENTRY_OOB_STALLED,
 };

 #ifndef irqentry_state
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5a669f87ec3f..5f2ec6dba1a4 100644
=2D-- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -410,7 +410,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs=
 *regs)

 #ifdef CONFIG_IRQ_PIPELINE
 	if (running_oob()) {
-		ret.stage_info =3D IRQENTRY_OOB;
+		ret.stage_info =3D test_oob_stall() ? IRQENTRY_OOB_STALLED :
+			IRQENTRY_OOB_UNSTALLED;
 		return ret;
 	}
 #endif
@@ -577,9 +578,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqe=
ntry_state_t state)
 	/*
 	 * If pipelining interrupts, clear the in-band stall bit if
 	 * irqentry_enter() raised it in order to mirror the hardware
-	 * state.
+	 * state. Also clear it when we where coming from OOB_UNSTALLED,
+	 * thus went through a migration that was caused by taking, e.g.,
+	 * a fault.
 	 */
-	if (state.stage_info =3D=3D IRQENTRY_INBAND_UNSTALLED)
+	if (state.stage_info =3D=3D IRQENTRY_INBAND_UNSTALLED ||
+	    state.stage_info =3D=3D IRQENTRY_OOB_UNSTALLED)
 		unstall_inband();
 #endif
 	return;
=2D-
2.26.2


