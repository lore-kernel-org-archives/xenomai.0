Message-ID: <51BEDC9B.6040603@gmail.com>
Date: Mon, 17 Jun 2013 11:53:31 +0200
From: Manuel Huber <manuel.h87@gmail.com>
MIME-Version: 1.0
References: <51BE2859.8000307@gmail.com> <51BE9E2C.9090204@web.de>
In-Reply-To: <51BE9E2C.9090204@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm: minimal patch for sys_rtdm_recvmsg
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

> Please post patches inline, makes reviewing easier. The explanatory
> part, like above, can be put after the "---" so that it won't show up in
> the commit log.
Oh, sorry; I forgot to send it plain-text...

> Let's just only copy back what can change, msg_flags and msg_controllen,
> just like the kernel does.
I have already implemented a version that does that, but then I looked at
rt_udp_recvmsg implementation (stack/ipv4/udp/udp.c) and saw that it also
sets msg_namelen field. This member will never be used in RTnet source
code, so I think it should be copied back to the user...
I mean it seems a little useless, because the user has to know the structur
anyway; I'm not sure if code really relies on this behaviour....

So if it's necessary to write back the msg_namelen field, I would need 3
__xn_put_user calls. I just though it looks ugly and probably does worse
then a single __xn_copy_to_user call.

Do you think it's necessary to write back msg_namelen? Because otherwise
I would definitely prefer using __xn_put_user twice.



 From ddb64a6eebcfc811187df3859f2e0092c0b6cfbd Mon Sep 17 00:00:00 2001
From: Manuel Huber <Manuel.h87@gmail.com>
Date: Mon, 17 Jun 2013 09:49:25 +0200
Subject: [PATCH] rtdm: Fix msghdr struct (cmsg) in sys_rtdm_recvmsg

Whenever a new control message is put into msg_control buffer
the actual address and the space left is saved to msg_control
and msg_controllen. This allows adding messages as long as
there is enough space left in the user-supplied buffer. Both
fields have to be fixed again before passing them to the user
by copying the original starting address of the buffer to
msg_control and saving the actual amount of bytes written to
the buffer to msg_controllen.

* Explicit use of __xn_put_user rather then __xn_copy_to_user
---
  ksrc/skins/rtdm/syscall.c |   19 +++++++++++++++----
  1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/ksrc/skins/rtdm/syscall.c b/ksrc/skins/rtdm/syscall.c
index 0ff5d40..1f3bccb 100644
--- a/ksrc/skins/rtdm/syscall.c
+++ b/ksrc/skins/rtdm/syscall.c
@@ -79,22 +79,33 @@ static int sys_rtdm_recvmsg(struct pt_regs *regs)
  {
      struct task_struct *p = current;
      struct msghdr krnl_msg;
+    void *cmsg_control;
+    struct msghdr __user *usr_msg;
      int ret;

-    if (unlikely(!access_wok(__xn_reg_arg2(regs),
+    usr_msg = (void __user *)__xn_reg_arg2(regs);
+
+    if (unlikely(!access_wok((void __user *)usr_msg,
                   sizeof(krnl_msg)) ||
               __xn_copy_from_user(&krnl_msg,
-                     (void __user *)__xn_reg_arg2(regs),
+                     (void __user *)usr_msg,
                       sizeof(krnl_msg))))
          return -EFAULT;

+    cmsg_control = krnl_msg.msg_control;
+
      ret = __rt_dev_recvmsg(p, __xn_reg_arg1(regs), &krnl_msg,
                     __xn_reg_arg3(regs));
      if (unlikely(ret < 0))
          return ret;

-    if (unlikely(__xn_copy_to_user((void __user *)__xn_reg_arg2(regs),
- &krnl_msg, sizeof(krnl_msg))))
+    if (unlikely(__xn_put_user(krnl_msg.msg_namelen,
+                   (void __user *)&(usr_msg->msg_namelen)) ||
+             __xn_put_user((typeof(krnl_msg.msg_controllen))(
+                       krnl_msg.msg_control - cmsg_control),
+                   (void __user *)&usr_msg->msg_controllen) ||
+             __xn_put_user(krnl_msg.msg_flags,
+                   (void __user *)&(usr_msg->msg_flags))))
          return -EFAULT;

      return ret;
-- 
1.7.0.4


