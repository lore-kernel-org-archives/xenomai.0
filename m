Message-ID: <518BE26B.4080408@xenomai.org>
Date: Thu, 09 May 2013 19:52:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>	<CAPpP=rMLPeRAVCpdKQkLVD29pFUj8zPL5JRmTbrJkKEetJJbew@mail.gmail.com>	<CAPpP=rM6BTevvfoV+TT4ej6zkeyzdnY7yN_qVCUPkLFe38EUYA@mail.gmail.com>	<518BB895.3050208@xenomai.org>	<CAPpP=rNFf4qH0JPpR57i5qp1tmHbLb2k8X9qYjn+6dmZb_ckvA@mail.gmail.com>	<518BBFDC.7060102@xenomai.org>	<CAPpP=rOFw32ctFaLGtrPd-L0ZaTR_d38HhLZ9anSrk1tucv-xw@mail.gmail.com>	<518BC2C3.3080004@xenomai.org>	<CAPpP=rNCqAAiAzTviRxk7Oy1MRO4A6VGk5cJKVSGSa9q_Xp+Fg@mail.gmail.com>	<518BC59F.60208@xenomai.org>	<CAPpP=rPFd3h_aTBKoL6bUwAqbLT5yDp0G057h1PssUo8MVKxDg@mail.gmail.com>	<518BCB6B.5070908@xenomai.org>	<CAPpP=rNs37xZRsJRd3JvS4Pf16jhRWmxsS+Y6gVR=R9RQ6SWjQ@mail.gmail.com>	<518BCD6C.8060501@xenomai.org>	<CAPpP=rODvDuVjP+CfE=6jYTRP5nD5smumnAV3mj51YQm8mzw0Q@mail.gmail.com>	<CAPpP=rP1qoFzTHimu3hZA7fcR3dCqfQXYOKUpfsK__3pUPMB8A@mail.gmail.com>	<518BD2BF.3040801@xenomai.org>
	<CAPpP=rN8hCBkm17e4X_Oqpt9p306kSh_hQQW9LKifbkqzd6zOQ@mail.gmail.com>
In-Reply-To: <CAPpP=rN8hCBkm17e4X_Oqpt9p306kSh_hQQW9LKifbkqzd6zOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/09/2013 06:56 PM, alex alex wrote:

> vmlinux file
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: vmlinux
> Type: application/octet-stream
> Size: 11189780 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130509/0255686a/attachment.obj>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


Please try that one instead:

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 49ed764..6fbe4c4 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -435,11 +435,6 @@ static int __pthread_set_name_np(struct pt_regs *regs)
 	hkey.u_tid = __xn_reg_arg1(regs);
 	hkey.mm = current->mm;
 	k_tid = __pthread_find(&hkey);
-	if (k_tid) {
-		p = xnthread_user_task(&k_tid->threadbase);
-		strncpy(p->comm, name, sizeof(p->comm));
-		p->comm[sizeof(p->comm) - 1] = '\0';
-	}
 
 	return -pthread_set_name_np(k_tid, name);
 }
diff --git a/ksrc/skins/posix/thread.c b/ksrc/skins/posix/thread.c
index 01fc699..78f5634 100644
--- a/ksrc/skins/posix/thread.c
+++ b/ksrc/skins/posix/thread.c
@@ -715,6 +715,9 @@ int pthread_set_mode_np(int clrmask, int setmask)
  */
 int pthread_set_name_np(pthread_t thread, const char *name)
 {
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	struct task_struct *p;
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -727,6 +730,14 @@ int pthread_set_name_np(pthread_t thread, const char *name)
 	snprintf(xnthread_name(&thread->threadbase), XNOBJECT_NAME_LEN, "%s",
 		 name);
 
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	p = xnthread_user_task(&thread->threadbase);
+	if (p) {
+		strncpy(p->comm, name, sizeof(p->comm));
+		p->comm[sizeof(p->comm) - 1] = '\0';
+	}
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
 	xnlock_put_irqrestore(&nklock, s);
 
 	return 0;


-- 
                                                                Gilles.

