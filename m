From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 2/7] cobalt: posix/cond: Add missing __user annotation to user
 provided ptr
Date: Wed,  5 Jan 2022 15:06:45 +0100
Message-Id: <20220105140650.1033850-3-florian.bezdeka@siemens.com>
In-Reply-To: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
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

Like all other pointers in the cond_wait_prologue interface the error
pointer is user-provided and should be annotated accordingly.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/cond.c      | 8 ++++----
 kernel/cobalt/posix/cond.h      | 8 ++++----
 kernel/cobalt/posix/syscall32.c | 4 ++--
 kernel/cobalt/posix/syscall32.h | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index 28400505f..e3a95ff83 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -285,7 +285,7 @@ static inline int cond_fetch_timeout64(struct timespec64 *ts,
 
 int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 				struct cobalt_mutex_shadow __user *u_mx,
-				int *u_err,
+				int __user *u_err,
 				void __user *u_ts,
 				int (*fetch_timeout)(struct timespec64 *ts,
 						     const void __user *u_ts))
@@ -351,7 +351,7 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 
 int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
 				  struct cobalt_mutex_shadow __user *u_mx,
-				  int *u_err, unsigned int timed,
+				  int __user *u_err, unsigned int timed,
 				  void __user *u_ts)
 {
 	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
@@ -362,7 +362,7 @@ int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
 COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
 	       (struct cobalt_cond_shadow __user *u_cnd,
 		struct cobalt_mutex_shadow __user *u_mx,
-		int *u_err,
+		int __user *u_err,
 		unsigned int timed,
 		struct __user_old_timespec __user *u_ts))
 {
@@ -373,7 +373,7 @@ COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
 COBALT_SYSCALL(cond_wait_prologue64, nonrestartable,
 	       (struct cobalt_cond_shadow __user *u_cnd,
 		struct cobalt_mutex_shadow __user *u_mx,
-		int *u_err,
+		int __user *u_err,
 		unsigned int timed,
 		struct __kernel_timespec __user *u_ts))
 {
diff --git a/kernel/cobalt/posix/cond.h b/kernel/cobalt/posix/cond.h
index b087b189e..1fd4256ce 100644
--- a/kernel/cobalt/posix/cond.h
+++ b/kernel/cobalt/posix/cond.h
@@ -41,14 +41,14 @@ struct cobalt_cond {
 
 int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 				struct cobalt_mutex_shadow __user *u_mx,
-				int *u_err,
+				int __user *u_err,
 				void __user *u_ts,
 				int (*fetch_timeout)(struct timespec64 *ts,
 						     const void __user *u_ts));
 
 int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
 				  struct cobalt_mutex_shadow __user *u_mx,
-				  int *u_err, unsigned int timed,
+				  int __user *u_err, unsigned int timed,
 				  void __user *u_ts);
 
 COBALT_SYSCALL_DECL(cond_init,
@@ -61,14 +61,14 @@ COBALT_SYSCALL_DECL(cond_destroy,
 COBALT_SYSCALL_DECL(cond_wait_prologue,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx,
-		     int *u_err,
+		     int __user *u_err,
 		     unsigned int timed,
 		     struct __user_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(cond_wait_prologue64,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx,
-		     int *u_err,
+		     int __user *u_err,
 		     unsigned int timed,
 		     struct __kernel_timespec __user *u_ts));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index fbd2b7f79..a6cf218ea 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -278,7 +278,7 @@ COBALT_SYSCALL32emu(mutex_timedlock64, primary,
 COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx,
-		     int *u_err,
+		     int __user *u_err,
 		     unsigned int timed,
 		     struct old_timespec32 __user *u_ts))
 {
@@ -289,7 +289,7 @@ COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 COBALT_SYSCALL32emu(cond_wait_prologue64, nonrestartable,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx,
-		     int *u_err,
+		     int __user *u_err,
 		     unsigned int timed,
 		     struct __kernel_timespec __user *u_ts))
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index cdaa903ea..a64d100e7 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -105,14 +105,14 @@ COBALT_SYSCALL32emu_DECL(mutex_timedlock64,
 COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			 (struct cobalt_cond_shadow __user *u_cnd,
 			  struct cobalt_mutex_shadow __user *u_mx,
-			  int *u_err,
+			  int __user *u_err,
 			  unsigned int timed,
 			  struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(cond_wait_prologue64,
 			 (struct cobalt_cond_shadow __user *u_cnd,
 			  struct cobalt_mutex_shadow __user *u_mx,
-			  int *u_err,
+			  int __user *u_err,
 			  unsigned int timed,
 			  struct __kernel_timespec __user *u_ts));
 
-- 
2.30.2


