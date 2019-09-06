From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/rtdm: Drop unused nop_close
Message-ID: <168d1a2f-9f8a-ccb2-5643-0d3bc1bfcfbd@siemens.com>
Date: Fri, 6 Sep 2019 19:49:21 +0200
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

Since 1909729e00dd, the device's close operation is always interposed
with __rtdm_dev_close, thus will never be NULL even if the driver
provides none. Other callers of rtdm_fd_enter, timerfd and mqueue, also
provide close handlers. So drop the default initialization.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 8a87e22643..d8a62376e6 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -56,10 +56,6 @@ static int eadv(void)
 	return -EADV;
 }
 
-static void nop_close(struct rtdm_fd *fd)
-{
-}
-
 static inline struct rtdm_fd_index *
 fetch_fd_index(struct cobalt_ppd *p, int ufd)
 {
@@ -157,7 +153,6 @@ int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
 	assign_default_dual_handlers(ops->sendmsg);
 	assign_invalid_default_handler(ops->select);
 	assign_invalid_default_handler(ops->mmap);
-	__assign_default_handler(ops->close, nop_close);
 
 	ppd = cobalt_ppd_get(0);
 	fd->magic = magic;
-- 

2.16.4

