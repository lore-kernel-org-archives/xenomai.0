From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 7/7] cobalt: Protect __xn_get_user() by access_ok()
Date: Wed,  5 Jan 2022 15:06:50 +0100
Message-Id: <20220105140650.1033850-8-florian.bezdeka@siemens.com>
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

According to the doctype provided by __get_user (which is used by the
__xn_get_user() macro) each call should be protected by access_ok().
We missed such a protection at some places.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/internal.h  | 4 ++++
 kernel/cobalt/posix/nsem.c      | 3 ++-
 kernel/cobalt/posix/syscall32.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/internal.h b/kernel/cobalt/posix/internal.h
index 8b134d0a7..36fbc9eb5 100644
--- a/kernel/cobalt/posix/internal.h
+++ b/kernel/cobalt/posix/internal.h
@@ -52,6 +52,10 @@ extern struct xnptree posix_ptree;
 static inline xnhandle_t cobalt_get_handle_from_user(xnhandle_t *u_h)
 {
 	xnhandle_t handle;
+
+	if (unlikely(!access_ok(u_h, sizeof(*u_h))))
+		return 0;
+
 	return __xn_get_user(handle, u_h) ? 0 : handle;
 }
 
diff --git a/kernel/cobalt/posix/nsem.c b/kernel/cobalt/posix/nsem.c
index 89cf62b6f..a6481c092 100644
--- a/kernel/cobalt/posix/nsem.c
+++ b/kernel/cobalt/posix/nsem.c
@@ -222,7 +222,8 @@ COBALT_SYSCALL(sem_open, lostage,
 {
 	struct cobalt_sem_shadow __user *usm;
 
-	if (__xn_get_user(usm, u_addrp))
+	if (!access_ok(u_addrp, sizeof(*u_addrp)) ||
+	    __xn_get_user(usm, u_addrp))
 		return -EFAULT;
 
 	usm = __cobalt_sem_open(usm, u_name, oflags, mode, value);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a6cf218ea..0c3f50a81 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -113,7 +113,8 @@ COBALT_SYSCALL32emu(sem_open, lostage,
 	struct cobalt_sem_shadow __user *usm;
 	compat_uptr_t cusm;
 
-	if (__xn_get_user(cusm, u_addrp))
+	if (!access_ok(u_addrp, sizeof(*u_addrp)) ||
+	    __xn_get_user(cusm, u_addrp))
 		return -EFAULT;
 
 	usm = __cobalt_sem_open(compat_ptr(cusm), u_name, oflags, mode, value);
-- 
2.30.2


