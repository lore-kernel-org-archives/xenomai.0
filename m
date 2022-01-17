From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] lib: Fix fallback signature of pthread_mutexattr_setrobust
Date: Mon, 17 Jan 2022 17:52:34 +0100
Message-Id: <20220117165234.387081-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Detected when trying to compile Xenomai on a 32bit system using latest
glibc release (2.34) without running autoreconf to regenerate
xeno_config.h.

The signature of _setrobust was mixed with the signature of _getrobust.

Updates https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/31

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/boilerplate/libc.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/boilerplate/libc.h b/include/boilerplate/libc.h
index 797e377a2..071cdf321 100644
--- a/include/boilerplate/libc.h
+++ b/include/boilerplate/libc.h
@@ -247,9 +247,8 @@ __weak int shm_unlink(const char *name)
 #ifdef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
 #define pthread_mutexattr_setrobust	pthread_mutexattr_setrobust_np
 #else
-static inline
-int pthread_mutexattr_setrobust(const pthread_mutexattr_t *attr,
-				int *robustness)
+inline int pthread_mutexattr_setrobust(pthread_mutexattr_t *attr,
+				       int robustness)
 {
 	return ENOSYS;
 }
-- 
2.30.2


