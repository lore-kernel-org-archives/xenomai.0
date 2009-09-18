Message-ID: <4AB351BD.9050201@domain.hid>
Date: Fri, 18 Sep 2009 11:24:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] rtipc: Fix 64-bit related warnings
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

The following changes since commit 13d66eb4c8f1648614095d43dd529a3c98fc5278:
  Philippe Gerum (1):
        x86: upgrade I-pipe support to 2.6.31-x86-2.4-05

are available in the git repository at:

  git://xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      rtipc: Fix 64-bit related warnings

 ksrc/drivers/ipc/internal.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

---

rtipc: Fix 64-bit related warnings

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

diff --git a/ksrc/drivers/ipc/internal.h b/ksrc/drivers/ipc/internal.h
index 737038e..296a988 100644
--- a/ksrc/drivers/ipc/internal.h
+++ b/ksrc/drivers/ipc/internal.h
@@ -70,12 +70,12 @@ static inline void *rtipc_context_to_state(struct rtdm_dev_context *context)
 
 static inline void *rtipc_fd2map(int fd)
 {
-	return (void *)(fd + 1);
+	return (void *)(long)(fd + 1);
 }
 
 static inline int rtipc_map2fd(void *p)
 {
-	return (int)(p) - 1;
+	return (long)p - 1;
 }
 
 static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct timeval *tv)

