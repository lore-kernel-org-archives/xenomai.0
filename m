Message-ID: <49BFED6E.4090009@domain.hid>
Date: Tue, 17 Mar 2009 19:35:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] posix: Fix error checks when copying user
	strings
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Obviously a conversion error while switching to __xn_safe*.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/skins/posix/syscall.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 16303b3..0eca3d0 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -1663,7 +1663,7 @@ static int __mq_open(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))
@@ -1736,7 +1736,7 @@ static int __mq_unlink(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))
@@ -2440,7 +2440,7 @@ static int __shm_open(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))
@@ -2487,7 +2487,7 @@ static int __shm_unlink(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))

