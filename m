Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4A2681F5.3030305@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 03 Jun 2009 15:59:13 +0200
Message-ID: <20090603135913.22120.48688.stgit@domain.hid>
In-Reply-To: <20090603135912.22120.29245.stgit@domain.hid>
References: <20090603135912.22120.29245.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 3/4] RTDM: Instrument rtdm_lock_get for
	proper use
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

In case the user thinks rtdm_lock_get could be used like spin_lock or
messes up the IRQ protection for other reasons, catch this with a
XENO_BUGON.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/rtdm/rtdm_driver.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 058a9f8..5fc8b57 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -655,7 +655,15 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: never.
  */
+#ifdef DOXYGEN_CPP /* Beautify doxygen output */
 #define rtdm_lock_get(lock)	rthal_spin_lock(lock)
+#else /* This is how it really works */
+#define rtdm_lock_get(lock)					\
+	do {							\
+		XENO_BUGON(RTDM, !rthal_local_irq_disabled());	\
+		rthal_spin_lock(lock);				\
+	} while (0)
+#endif
 
 /**
  * Release lock without preemption restoration


