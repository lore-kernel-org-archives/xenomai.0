From: Thierry Bultel <tbultel@free.fr>
Date: Thu, 28 Apr 2016 16:39:50 +0200
Message-Id: <1461854390-27536-1-git-send-email-tbultel@free.fr>
Subject: [Xenomai] [PATCH 1/1] posix skin: fix address passed to
	pse51_mutex_check_init in syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Thierry Bultel <tbultel@free.fr>

The address passed to pse51_mutex_check_init was the one of userland,
not the kernel one.

Signed-off-by: Thierry Bultel <tbultel@free.fr>
---
 ksrc/skins/posix/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 87b95fa..31e2705 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -1202,7 +1202,7 @@ static int __pthread_mutex_check_init(struct pt_regs *regs)
 	} else
 		attr = NULL;
 
-	return pse51_mutex_check_init(&umx->shadow_mutex, attr);
+	return pse51_mutex_check_init(&mx.shadow_mutex, attr);
 }
 
 static int __pthread_mutex_init(struct pt_regs *regs)
-- 
1.9.1


