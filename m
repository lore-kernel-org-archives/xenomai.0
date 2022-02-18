Message-ID: <ba6f4c41-c849-8f36-c3c7-973acfcc8837@siemens.com>
Date: Fri, 18 Feb 2022 13:51:17 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib: Re-add "static" to pthread_mutexattr_setrobust fallback
 stub
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
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

Lost in 3dfa855b6dd0.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/boilerplate/libc.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/boilerplate/libc.h b/include/boilerplate/libc.h
index 071cdf321a..44ddad5afb 100644
--- a/include/boilerplate/libc.h
+++ b/include/boilerplate/libc.h
@@ -247,8 +247,9 @@ __weak int shm_unlink(const char *name)
 #ifdef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
 #define pthread_mutexattr_setrobust	pthread_mutexattr_setrobust_np
 #else
-inline int pthread_mutexattr_setrobust(pthread_mutexattr_t *attr,
-				       int robustness)
+static inline
+int pthread_mutexattr_setrobust(pthread_mutexattr_t *attr,
+				int robustness)
 {
 	return ENOSYS;
 }
-- 
2.34.1

