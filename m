From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/5] drivers/autotune: do not read user data we should not
 expect
Date: Mon, 14 Jan 2019 18:35:19 +0100
Message-Id: <20190114173522.25750-2-rpm@xenomai.org>
In-Reply-To: <20190114173522.25750-1-rpm@xenomai.org>
References: <20190114173522.25750-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

We receive the sampling period from the setup struct attached to the
AUTOTUNE_RTIOC_{IRQ,KERN,USER} requests, drop the last copy from user
from autotune_ioctl_nrt() which is spurious.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/autotune/autotune.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
index 46a34bf36..2629bf9d4 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -644,7 +644,7 @@ static int autotune_ioctl_nrt(struct rtdm_fd *fd, unsigned int request, void *ar
 	struct autotune_context *context;
 	struct autotune_setup setup;
 	struct gravity_tuner *tuner;
-	int period, ret;
+	int ret;
 
 	if (request == AUTOTUNE_RTIOC_RESET) {
 		xnclock_reset_gravity(&nkclock);
@@ -678,10 +678,6 @@ static int autotune_ioctl_nrt(struct rtdm_fd *fd, unsigned int request, void *ar
 		return -EINVAL;
 	}
 
-	ret = rtdm_safe_copy_from_user(fd, &period, arg, sizeof(period));
-	if (ret)
-		return ret;
-
 	ret = tuner->init_tuner(tuner);
 	if (ret)
 		return ret;
-- 
2.17.2


