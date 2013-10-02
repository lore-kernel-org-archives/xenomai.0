From: Manuel Huber <manuel.h87@gmail.com>
Date: Wed,  2 Oct 2013 22:47:38 +0200
Message-Id: <1380746860-1409-2-git-send-email-manuel.h87@gmail.com>
In-Reply-To: <1380746860-1409-1-git-send-email-manuel.h87@gmail.com>
References: <1380746860-1409-1-git-send-email-manuel.h87@gmail.com>
Subject: [Xenomai] [PATCH 1/3] rtdm: Fix msghdr struct (cmsg) in
	sys_rtdm_recvmsg
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@web.de
Cc: xenomai@xenomai.org

From: Manuel Huber <Manuel.h87@gmail.com>

Whenever a new control message is put into msg_control buffer
the actual address and the space left is saved to msg_control
and msg_controllen. This allows adding messages as long as
there is enough space left in the user-supplied buffer. Both
fields have to be fixed again before passing them to the user
by copying the original starting address of the buffer to
msg_control and saving the actual amount of bytes written to
the buffer to msg_controllen.

Note: Changes of msg_namelen (in driver code) will not be
reflected to user-space anymore. This change could break
user-space applications that depend on the previous
implementation.

* Explicit use of __xn_put_user rather then __xn_copy_to_user
* Don't write back msg->msg_namelen
* Reset msg_flags before passing msg to driver code
---
 ksrc/skins/rtdm/syscall.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/ksrc/skins/rtdm/syscall.c b/ksrc/skins/rtdm/syscall.c
index 0ff5d40..055cf7c 100644
--- a/ksrc/skins/rtdm/syscall.c
+++ b/ksrc/skins/rtdm/syscall.c
@@ -79,22 +79,32 @@ static int sys_rtdm_recvmsg(struct pt_regs *regs)
 {
 	struct task_struct *p = current;
 	struct msghdr krnl_msg;
+	uintptr_t cmsg_ptr;
+	struct msghdr __user *usr_msg;
 	int ret;
 
-	if (unlikely(!access_wok(__xn_reg_arg2(regs),
+	usr_msg = (void __user *)__xn_reg_arg2(regs);
+
+	if (unlikely(!access_wok((void __user *)usr_msg,
 				 sizeof(krnl_msg)) ||
 		     __xn_copy_from_user(&krnl_msg,
-					 (void __user *)__xn_reg_arg2(regs),
+					 (void __user *)usr_msg,
 					 sizeof(krnl_msg))))
 		return -EFAULT;
 
+	cmsg_ptr = (uintptr_t)krnl_msg.msg_control;
+	krnl_msg.msg_flags = 0;
+
 	ret = __rt_dev_recvmsg(p, __xn_reg_arg1(regs), &krnl_msg,
 			       __xn_reg_arg3(regs));
 	if (unlikely(ret < 0))
 		return ret;
 
-	if (unlikely(__xn_copy_to_user((void __user *)__xn_reg_arg2(regs),
-				       &krnl_msg, sizeof(krnl_msg))))
+	if (unlikely(__xn_put_user((typeof(krnl_msg.msg_controllen))
+				   ((uintptr_t)krnl_msg.msg_control - cmsg_ptr),
+				   (void __user *)&usr_msg->msg_controllen) ||
+		     __xn_put_user(krnl_msg.msg_flags,
+				   (void __user *)&(usr_msg->msg_flags))))
 		return -EFAULT;
 
 	return ret;
-- 
1.8.3


