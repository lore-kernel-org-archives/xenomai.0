Message-ID: <49C0BDE8.4050400@domain.hid>
Date: Wed, 18 Mar 2009 10:24:56 +0100
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

Do not return -EFAULT when the passed string has zero-length. Instead,
return -EINVAL when trying to create objects with empty names.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/skins/posix/syscall.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 16303b3..c7950a6 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -600,6 +600,8 @@ static int __sem_open(struct pt_regs *regs)
 
 	if (len >= sizeof(name))
 		return -ENAMETOOLONG;
+	if (len == 0)
+		return -EINVAL;
 
 	oflags = __xn_reg_arg3(regs);
 
@@ -1663,11 +1665,13 @@ static int __mq_open(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))
 		return -ENAMETOOLONG;
+	if (len == 0)
+		return -EINVAL;
 
 	oflags = __xn_reg_arg2(regs);
 	mode = __xn_reg_arg3(regs);
@@ -1736,7 +1740,7 @@ static int __mq_unlink(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))
@@ -2440,11 +2444,13 @@ static int __shm_open(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))
 		return -ENAMETOOLONG;
+	if (len == 0)
+		return -EINVAL;
 
 	oflag = (int)__xn_reg_arg2(regs);
 	mode = (mode_t) __xn_reg_arg3(regs);
@@ -2487,7 +2493,7 @@ static int __shm_unlink(struct pt_regs *regs)
 	len = __xn_safe_strncpy_from_user(name,
 					  (const char __user *)__xn_reg_arg1(regs),
 					  sizeof(name));
-	if (len <= 0)
+	if (len < 0)
 		return -EFAULT;
 
 	if (len >= sizeof(name))

