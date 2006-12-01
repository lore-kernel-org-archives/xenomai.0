Message-ID: <45708CA5.8040004@domain.hid>
Date: Fri, 01 Dec 2006 14:12:21 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080908050402060108010806"
Subject: [Xenomai-help] sem_timedwait return value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080908050402060108010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In my userspace POSIX program, I get a '-1' return value from sem_timedwait, even when the function succeeds.  When the function succeeds, errno is '-1' as well.  I am using this workaround at the moment:

      result = sem_timedwait(&cas_sem, &wake_time);
      if (result < 0 && errno > 0) /* errno > 0 to work around xenomai bug */
        {
          print_msg(WARN_MSG, "sem_wait returned with error code %d\n",
                    errno);
          continue;
        }

I am using xenomai 2.2.4, but I think the problem exists in other branches as well.  I believe the attached patch against the trunk should fix the problem.  Do you agree?

Thanks,

Jeff

--------------080908050402060108010806
Content-Type: text/x-patch;
 name="sem_timedwait.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sem_timedwait.patch"

Index: ksrc/skins/posix/syscall.c
===================================================================
--- ksrc/skins/posix/syscall.c	(revision 1911)
+++ ksrc/skins/posix/syscall.c	(working copy)
@@ -492,7 +492,7 @@
 			    &ts,
 			    (void __user *)__xn_reg_arg2(regs), sizeof(ts));
 
-	return sem_timedwait(&sm.native_sem, &ts) == 0 ? : -thread_get_errno();
+	return sem_timedwait(&sm.native_sem, &ts) == 0 ? 0 : -thread_get_errno();
 }
 
 static int __sem_trywait(struct task_struct *curr, struct pt_regs *regs)

--------------080908050402060108010806--

