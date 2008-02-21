Message-ID: <47BD9C23.6000705@domain.hid>
Date: Thu, 21 Feb 2008 16:43:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000403020702090002000507"
Subject: [Xenomai-core] [PATCH] Fix POSIX skin build for 2.4.x
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------000403020702090002000507
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Gilles,

the backport from trunk was borken. This patch makes 2.4.x build again,
but - BIG-FAT-WARNING - I haven't tested the result.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


--------------000403020702090002000507
Content-Type: text/x-patch;
 name="fix-uaccess-tests.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-uaccess-tests.patch"

Index: xenomai-2.4.x/ksrc/skins/posix/syscall.c
===================================================================
--- xenomai-2.4.x/ksrc/skins/posix/syscall.c	(Revision 3513)
+++ xenomai-2.4.x/ksrc/skins/posix/syscall.c	(Arbeitskopie)
@@ -1847,7 +1847,7 @@ static int __mq_send(struct task_struct 
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if(__xn_copy_from_user(msg->data,
+	if(__xn_copy_from_user(curr, msg->data,
 			       (void __user *)__xn_reg_arg2(regs), len)) {
 		pse51_mq_finish_send(ufd->kfd, mq, msg);
 		return -EFAULT;
@@ -1903,7 +1903,7 @@ static int __mq_timedsend(struct task_st
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if(__xn_copy_from_user(msg->data,
+	if(__xn_copy_from_user(curr, msg->data,
 			       (void __user *)__xn_reg_arg2(regs), len)) {
 		pse51_mq_finish_send(ufd->kfd, mq, msg);
 		return -EFAULT;
@@ -1952,7 +1952,7 @@ static int __mq_receive(struct task_stru
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if (__xn_copy_to_user((void __user *)__xn_reg_arg2(regs),
+	if (__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs),
 			      msg->data, msg->len)) {
 		pse51_mq_finish_rcv(ufd->kfd, mq, msg);
 		return -EFAULT;
@@ -2029,7 +2029,7 @@ static int __mq_timedreceive(struct task
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if (__xn_copy_to_user((void __user *)__xn_reg_arg2(regs),
+	if (__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs),
 			      msg->data, msg->len)) {
 		pse51_mq_finish_rcv(ufd->kfd, mq, msg);
 		return -EFAULT;
@@ -2041,8 +2041,10 @@ static int __mq_timedreceive(struct task
 	if (err)
 		return err;
 
-	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
-				   &len, sizeof(len)))
+	if (!__xn_access_ok
+	    (curr, VERIFY_WRITE, __xn_reg_arg3(regs), sizeof(len)) ||
+	    __xn_copy_to_user(curr, (void __user *)__xn_reg_arg3(regs),
+			      &len, sizeof(len)))
 		return -EFAULT;
 
 	if (__xn_reg_arg4(regs))

--------------000403020702090002000507--

