From: Romain Naour <romain.naour@gmail.com>
Date: Sat,  5 Nov 2016 19:09:02 +0100
Message-Id: <1478369343-17564-1-git-send-email-romain.naour@gmail.com>
Subject: [Xenomai] [PATCH 1/2] bfin: remove inline keyword
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

Fixes:
http://autobuild.buildroot.net/results/0c2/0c2e5eb4edd4f9427f61d3c9b67a12a7a0e24140

Signed-off-by: Romain Naour <romain.naour@gmail.com>
---
 include/asm-blackfin/syscall.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-blackfin/syscall.h b/include/asm-blackfin/syscall.h
index 9eda8b9..b5728b5 100644
--- a/include/asm-blackfin/syscall.h
+++ b/include/asm-blackfin/syscall.h
@@ -132,9 +132,9 @@ static inline int __xn_interrupted_p(struct pt_regs *regs)
 #define XENOMAI_SKINCALL5(id,op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,id,op,a1,a2,a3,a4,a5)
 
 /* uClibc does not provide pthread_atfork() for this arch; provide it
-   here. Note: let the compiler decides whether it wants to actually
-   inline this routine, i.e. do not force always_inline. */
-inline __attribute__((weak)) int pthread_atfork(void (*prepare)(void),
+   here.
+*/
+__attribute__((weak)) int pthread_atfork(void (*prepare)(void),
 						void (*parent)(void),
 						void (*child)(void))
 {
@@ -143,7 +143,7 @@ inline __attribute__((weak)) int pthread_atfork(void (*prepare)(void),
 
 #include <errno.h>
 
-inline __attribute__((weak)) int shm_open(const char *name,
+__attribute__((weak)) int shm_open(const char *name,
 					  int oflag,
 					  mode_t mode)
 {
@@ -151,7 +151,7 @@ inline __attribute__((weak)) int shm_open(const char *name,
 	return -1;
 }
 
-inline __attribute__((weak)) int shm_unlink(const char *name)
+__attribute__((weak)) int shm_unlink(const char *name)
 {
 	errno = ENOSYS;
 	return -1;
-- 
2.5.5


