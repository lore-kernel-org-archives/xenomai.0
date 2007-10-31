Message-ID: <47285858.3030204@domain.hid>
Date: Wed, 31 Oct 2007 11:26:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172B790@domain.hid>
	<47285666.4080108@domain.hid>
In-Reply-To: <47285666.4080108@domain.hid>
Content-Type: multipart/mixed; boundary="------------070400050004070603000201"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] xntbase_get_jiffies in user space?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070400050004070603000201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Thomas Necker wrote:
>> A few weeks ago I was asking about a global variable available that just
>> counts the system ticks (for pSOS skin) and that could be read by the
>> application. Philippe suggested xntbase_get_jiffies for that purpose.
>> Now it seems to me that this function can only be called in kernel
>> space. Is that correct? And if so, is there a way to get this
>> information in user space? Basically I want to get rid of kernel code in
>> this context completely if possible.
>>
> 
> The pSOS skin supports tm_get() which converts the current count of
> jiffies to calendar date and time, but this may not be handy for your
> calculations.
> 
> The other option would be to extend this skin with a Xenomai-specific
> syscall returning this value, in a similar way than tm_getm(), which
> returns the TSC converted to nanoseconds.
> 

Like the attached patch does.

-- 
Philippe.

--------------070400050004070603000201
Content-Type: text/x-patch;
 name="tm_getc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tm_getc.patch"

Index: include/psos+/syscall.h
===================================================================
--- include/psos+/syscall.h	(revision 3133)
+++ include/psos+/syscall.h	(working copy)
@@ -71,6 +71,8 @@
 /* Xenomai extension: send a Linux signal after a specified time */
 #define __psos_tm_signal    44
 #define __psos_as_send      45
+/* Xenomai extension: get raw count of jiffies */
+#define __psos_tm_getc      46
 
 #ifdef __KERNEL__
 
Index: include/psos+/psos.h
===================================================================
--- include/psos+/psos.h	(revision 3133)
+++ include/psos+/psos.h	(working copy)
@@ -419,6 +419,8 @@
 		 int signo,
 		 u_long *tmid_r);
 
+u_long tm_getc(unsigned long long *ticks_r); /* Xenomai extension. */
+
 #ifdef __cplusplus
 };
 #endif /* __cplusplus */
Index: src/skins/psos+/tm.c
===================================================================
--- src/skins/psos+/tm.c	(revision 3133)
+++ src/skins/psos+/tm.c	(working copy)
@@ -83,3 +83,8 @@
 {
 	return XENOMAI_SKINCALL4(__psos_muxid, __psos_tm_signal, value, interval, signo, tmid_r);
 }
+
+u_long tm_getc(unsigned long long *ticks_r) /* Xenomai extension. */
+{
+	return XENOMAI_SKINCALL1(__psos_muxid, __psos_tm_getc, ticks_r);
+}
Index: ksrc/skins/psos+/syscall.c
===================================================================
--- ksrc/skins/psos+/syscall.c	(revision 3133)
+++ ksrc/skins/psos+/syscall.c	(working copy)
@@ -1071,6 +1071,26 @@
 }
 
 /*
+ * u_long tm_getc(u_long_long *ticks_r)
+ */
+
+static int __tm_getc(struct task_struct *curr, struct pt_regs *regs)
+{
+	xnticks_t ticks;
+
+	if (!__xn_access_ok
+	    (curr, VERIFY_WRITE, __xn_reg_arg1(regs), sizeof(ticks)))
+		return -EFAULT;
+
+	ticks = xntbase_get_jiffies(&psos_tbase);
+
+	__xn_copy_to_user(curr, (void __user *)__xn_reg_arg1(regs), &ticks,
+			  sizeof(ticks));
+
+	return 0;
+}
+
+/*
  * u_long tm_signal(u_long value, u_long interval, int signo, u_long *tmid_r)
  */
 
@@ -1503,6 +1523,7 @@
 	[__psos_tm_getm] = {&__tm_getm, __xn_exec_any},
 	[__psos_tm_signal] = {&__tm_signal, __xn_exec_primary},
 	[__psos_as_send] = {&__as_send, __xn_exec_conforming},
+	[__psos_tm_getc] = {&__tm_getc, __xn_exec_any},
 };
 
 extern xntbase_t *psos_tbase;

--------------070400050004070603000201--

