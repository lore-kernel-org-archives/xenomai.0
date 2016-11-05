From: Romain Naour <romain.naour@gmail.com>
Date: Sat,  5 Nov 2016 19:09:03 +0100
Message-Id: <1478369343-17564-2-git-send-email-romain.naour@gmail.com>
In-Reply-To: <1478369343-17564-1-git-send-email-romain.naour@gmail.com>
References: <1478369343-17564-1-git-send-email-romain.naour@gmail.com>
Subject: [Xenomai] [PATCH 2/2] nios2: remove inline keyword
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Xenomai user space tools fail to build for bfin target since it's
provide it's own pthread_atfork(), shm_open() and shm_unlink()
definition using the inline keyword and weak attribute.

With gcc 5+ the weak attribute is discarded by the inline keyword,
so each symbol are global and are redefined several time while
linking.

Like for the bfin issue:
http://autobuild.buildroot.net/results/0c2/0c2e5eb4edd4f9427f61d3c9b67a12a7a0e24140

Signed-off-by: Romain Naour <romain.naour@gmail.com>
---
 include/asm-nios2/syscall.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/asm-nios2/syscall.h b/include/asm-nios2/syscall.h
index 44badc6..214871e 100644
--- a/include/asm-nios2/syscall.h
+++ b/include/asm-nios2/syscall.h
@@ -226,11 +226,9 @@ static inline int __xn_interrupted_p(struct pt_regs *regs)
 
 /*
  * uClibc does not always provide the following symbols for this arch;
- * provide placeholders here. Note: let the compiler decides whether
- * it wants to actually inline this routine, i.e. do not force
- * always_inline.
+ * provide placeholders here.
  */
-inline __attribute__((weak)) int pthread_atfork(void (*prepare)(void),
+__attribute__((weak)) int pthread_atfork(void (*prepare)(void),
 						void (*parent)(void),
 						void (*child)(void))
 {
@@ -239,7 +237,7 @@ inline __attribute__((weak)) int pthread_atfork(void (*prepare)(void),
 
 #include <errno.h>
 
-inline __attribute__((weak)) int shm_open(const char *name,
+__attribute__((weak)) int shm_open(const char *name,
 					  int oflag,
 					  mode_t mode)
 {
@@ -247,7 +245,7 @@ inline __attribute__((weak)) int shm_open(const char *name,
 	return -1;
 }
 
-inline __attribute__((weak)) int shm_unlink(const char *name)
+__attribute__((weak)) int shm_unlink(const char *name)
 {
 	errno = ENOSYS;
 	return -1;
-- 
2.5.5


