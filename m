From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/2] drivers/testing: heapcheck: silence UMR warning (false
 positive)
Date: Wed, 27 Nov 2019 19:16:24 +0100
Message-Id: <20191127181624.3043-2-rpm@xenomai.org>
In-Reply-To: <20191127181624.3043-1-rpm@xenomai.org>
References: <20191127181624.3043-1-rpm@xenomai.org>
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
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

---
 kernel/drivers/testing/heapcheck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/testing/heapcheck.c b/kernel/drivers/testing/heapcheck.c
index 4eb6a5aae..023a06ca6 100644
--- a/kernel/drivers/testing/heapcheck.c
+++ b/kernel/drivers/testing/heapcheck.c
@@ -449,7 +449,7 @@ static int heapcheck_ioctl(struct rtdm_fd *fd,
 	struct rttst_heap_stathdr sthdr;
 	struct rttst_heap_parms parms;
 	int ret;
-	
+
 	switch (request) {
 	case RTTST_RTIOC_HEAP_CHECK:
 		ret = rtdm_copy_from_user(fd, &parms, arg, sizeof(parms));
@@ -464,6 +464,7 @@ static int heapcheck_ioctl(struct rtdm_fd *fd,
 		ret = rtdm_copy_to_user(fd, arg, &parms, sizeof(parms));
 		break;
 	case RTTST_RTIOC_HEAP_STAT_COLLECT:
+		sthdr.buf = NULL;
 		ret = rtdm_copy_from_user(fd, &sthdr, arg, sizeof(sthdr));
 		if (ret)
 			return ret;
-- 
2.21.0


