From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/drivers: Ensure bidirectional IOCTL migration
Message-ID: <ecb53e23-857e-bde2-6ac1-2dcae1a22d7b@siemens.com>
Date: Mon, 23 Sep 2019 16:01:30 +0200
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
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Ensure that IOCTL switch-over is also prepared for the NRT-to-RT path.
While we didn't need this in practice for the changed drivers, it's
better to have this enabled in case driver developers derive from this
pattern.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/autotune/autotune.c  | 2 +-
 kernel/drivers/testing/switchtest.c | 2 +-
 kernel/drivers/testing/timerbench.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
index 469e628691..d9208f2a89 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -665,7 +665,7 @@ static int autotune_ioctl_nrt(struct rtdm_fd *fd, unsigned int request, void *ar
 		tuner = &uthread_tuner.tuner;
 		break;
 	default:
-		return -EINVAL;
+		return -ENOSYS;
 	}
 
 	ret = rtdm_copy_from_user(fd, &setup, arg, sizeof(setup));
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index d955c2b65f..8224974e5c 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -667,7 +667,7 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
 		return 0;
 
 	default:
-		return -ENOTTY;
+		return -ENOSYS;
 	}
 }
 
diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing/timerbench.c
index 1b4c413b7e..8b91bae9b2 100644
--- a/kernel/drivers/testing/timerbench.c
+++ b/kernel/drivers/testing/timerbench.c
@@ -453,7 +453,7 @@ static int rt_tmbench_ioctl_nrt(struct rtdm_fd *fd,
 		err = rt_tmbench_stop(ctx, arg);
 		break;
 	default:
-		err = -EINVAL;
+		err = -ENOSYS;
 	}
 
 	return err;
-- 
2.16.4

