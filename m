From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [wip/dovetail][PATCH 1/2] cobalt/mutex: Bring back ia32 support for
 mutex_timedwait
Date: Thu, 11 Mar 2021 17:38:26 +0100
Message-Id: <20210311163827.67202-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210311163827.67202-1-florian.bezdeka@siemens.com>
References: <20210311163827.67202-1-florian.bezdeka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org, jan.kiszka@siemens.com, chensong@kylinos.cn

The helper used for copying the timeout values (=mutex_fetch_timeout())
was always copying sizeof(struct timespec64) from user to kernel space.
For applications with time_t being 4 bytes only (like for native 32 bit
applications) that is simply too much.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/mutex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index d43a747b3..70fe7960a 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -349,8 +349,7 @@ COBALT_SYSCALL(mutex_lock, primary,
 static inline int mutex_fetch_timeout(struct timespec64 *ts,
 				      const void __user *u_ts)
 {
-	return u_ts == NULL ? -EFAULT :
-		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
+	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
 }
 
 COBALT_SYSCALL(mutex_timedlock, primary,
-- 
2.29.2


