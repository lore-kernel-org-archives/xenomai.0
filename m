Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <49513830.7010808@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 23 Dec 2008 20:06:49 +0100
Message-ID: <20081223190649.26094.10266.stgit@domain.hid>
In-Reply-To: <20081223190649.26094.61372.stgit@domain.hid>
References: <20081223190649.26094.61372.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v2 3/5] x86: Clear perfctr_msr on
	rthal_nmi_release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Better safe than sorry: Clear all per-CPU perfctr_msr values so that
no one can rearm the NMI watchdog after we released it.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/arch/x86/nmi_32.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/ksrc/arch/x86/nmi_32.c b/ksrc/arch/x86/nmi_32.c
index 78ba905..69a392a 100644
--- a/ksrc/arch/x86/nmi_32.c
+++ b/ksrc/arch/x86/nmi_32.c
@@ -264,6 +264,7 @@ int rthal_nmi_request(void (*emergency) (struct pt_regs *))
 void rthal_nmi_release(void)
 {
 	rthal_nmi_wd_t *wd = &rthal_nmi_wds[rthal_processor_id()];
+	int i;
 
 	if (!rthal_linux_nmi_tick)
 		return;
@@ -276,6 +277,8 @@ void rthal_nmi_release(void)
 		wrmsr(wd->perfctr_msr, (u32)(0 - RTHAL_CPU_FREQ), 0);
 	else
 		wrmsrl(wd->perfctr_msr, 0 - RTHAL_CPU_FREQ);
+	for (i = 0; i < NR_CPUS; i++)
+		rthal_nmi_wds[i].perfctr_msr = 0;
 	touch_nmi_watchdog();
 	wmb();
 	nmi_watchdog_tick = rthal_linux_nmi_tick;


