From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:41 +0200
Message-Id: <383d88a88155ae3ae71bbfddeacd742612d03245.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 01/25] RTDM: Fix potential NULL pointer
	dereference
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

The rework in 95278926edc559d4 misses the case that context can be NULL,
which can (and has) triggered a kernel oops. Take care of this case.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index 8677c47..8cccf52 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -175,7 +175,7 @@ static int cleanup_instance(struct rtdm_device *device,
 
 	xnlock_get_irqsave(&rt_fildes_lock, s);
 
-	if (unlikely(atomic_read(&context->close_lock_count) > 1)) {
+	if (context && unlikely(atomic_read(&context->close_lock_count) > 1)) {
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
 		return -EAGAIN;
 	}
-- 
1.6.0.2


