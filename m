From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86/hpet: dovetail: Harden clocksource for use in oob
Message-ID: <f6aac31a-edc2-dd3d-d1d2-9cd4f28d0fca@siemens.com>
Date: Fri, 18 Jun 2021 08:29:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

While it's slow, has scalability issues, it remains the second-best
clocksource for Linux on x86. If Linux decides that the TSC is not
reliable we will end up here and should avoid bringing the system into
an unstable state.

Suggested-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

While this does not give us hpet for Xenomai yet (vDSO fallback path 
still missing), it resolves the system stalls when Linux switches here.

 arch/x86/kernel/hpet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 67a9f248270c..ce8e15aa8a97 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -811,7 +811,7 @@ static u64 read_hpet(struct clocksource *cs)
 	if (arch_spin_is_locked(&old.lock))
 		goto contended;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	if (arch_spin_trylock(&hpet.lock)) {
 		new.value = hpet_readl(HPET_COUNTER);
 		/*
@@ -819,10 +819,10 @@ static u64 read_hpet(struct clocksource *cs)
 		 */
 		WRITE_ONCE(hpet.value, new.value);
 		arch_spin_unlock(&hpet.lock);
-		local_irq_restore(flags);
+		hard_local_irq_restore(flags);
 		return (u64)new.value;
 	}
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 
 contended:
 	/*
-- 
2.26.2

