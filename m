From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/rtdm: Avoid macro code duplication
Message-ID: <35a8291a-ba57-0b70-128a-c25c8b3cecbb@siemens.com>
Date: Fri, 6 Sep 2019 19:45:21 +0200
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index d965aafef2..8a87e22643 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -84,19 +84,16 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
 		(__handler) = (typeof(__handler))eadv;			\
 	while (0)
 
-/* Calling this handler should beget EADV if not implemented. */
-#define assign_invalid_default_handler(__handler)			\
-	do								\
-		if ((__handler) == NULL)				\
-			(__handler) = (typeof(__handler))eadv;		\
-	while (0)
-
 #define __assign_default_handler(__handler, __placeholder)		\
 	do								\
 		if ((__handler) == NULL)				\
 			(__handler) = (typeof(__handler))__placeholder;	\
 	while (0)
 
+/* Calling this handler should beget EADV if not implemented. */
+#define assign_invalid_default_handler(__handler)			\
+	__assign_default_handler(__handler, eadv)
+
 /* Calling this handler should beget ENOSYS if not implemented. */
 #define assign_default_handler(__handler)				\
 	__assign_default_handler(__handler, enosys)
-- 

2.16.4

