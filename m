From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:53 +0200
Message-Id: <79b2edfb9968a6e1a02f1e71956c68effe2fb751.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 13/25] Fix historic msleep wrapping
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Probably only an academic exercise: Fix the rounding bug in msleep
wrapper for kernels < 2.4.28.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/wrappers.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index 15d9837..64ec43f 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -197,7 +197,7 @@ do {									\
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,28)
 #define msleep(x) do {				 \
 	set_current_state(TASK_UNINTERRUPTIBLE); \
-	schedule_timeout((x)*(HZ/1000));         \
+	schedule_timeout(((x)*HZ)/1000);         \
 } while(0)
 #endif
 
-- 
1.6.0.2


