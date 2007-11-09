Message-ID: <47344759.4020505@domain.hid>
Date: Fri, 09 Nov 2007 12:41:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <473391B0.5040809@domain.hid> <4733A2B8.8070100@domain.hid>
In-Reply-To: <4733A2B8.8070100@domain.hid>
Content-Type: multipart/mixed; boundary="------------030700000004000300070100"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] User space drivers on PPC440
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030700000004000300070100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Steven A. Falco wrote:
>> The rt_misc_get_io_region() has the "start" argument as an unsigned 
>> long.  On the PPC440, we have a 36-bit address space, where the I/O 
>> registers are generally above the 4GB area.  For example, the UART is at 
>> address 0x1ef600300.
>>
>> The Linux request_region call has "start" typed as a resource_size_t, 
>> which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
>> though this is a 23-bit processor).
>>
>> Is this something that should be handled by xeno-config?  It could 
>> append a CFLAG indicating the size of a resource.
> 
> Or use a 64bit long unconditionally, to keep the same kernel-based
> implementation, since there is no performance issue for this call. In
> any case, we need to fix the API before 2.4 final is out -- which will
> also affect the ABI, but it already changed during the 2.4 development
> phase anyway.
> 

Does this patch work for you?

-- 
Philippe.

--------------030700000004000300070100
Content-Type: text/x-patch;
 name="io-region-64bit-start-address.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io-region-64bit-start-address.patch"

Index: include/native/misc.h
===================================================================
--- include/native/misc.h	(revision 3162)
+++ include/native/misc.h	(working copy)
@@ -32,11 +32,11 @@
 
 /* Public interface. */
 
-int rt_misc_get_io_region(unsigned long start,
+int rt_misc_get_io_region(uint64_t start,
 			  unsigned long len,
 			  const char *label);
 
-int rt_misc_put_io_region(unsigned long start,
+int rt_misc_put_io_region(uint64_t start,
 			  unsigned long len);
 
 #ifdef __cplusplus
Index: src/skins/native/misc.c
===================================================================
--- src/skins/native/misc.c	(revision 3162)
+++ src/skins/native/misc.c	(working copy)
@@ -22,16 +22,16 @@
 
 extern int __native_muxid;
 
-int rt_misc_get_io_region(unsigned long start,
+int rt_misc_get_io_region(uint64_t start,
 			  unsigned long len, const char *label)
 {
 	return XENOMAI_SKINCALL3(__native_muxid,
-				 __native_misc_get_io_region, start, len,
+				 __native_misc_get_io_region, &start, len,
 				 label);
 }
 
-int rt_misc_put_io_region(unsigned long start, unsigned long len)
+int rt_misc_put_io_region(uint64_t start, unsigned long len)
 {
 	return XENOMAI_SKINCALL2(__native_muxid,
-				 __native_misc_put_io_region, start, len);
+				 __native_misc_put_io_region, &start, len);
 }
Index: ksrc/skins/native/syscall.c
===================================================================
--- ksrc/skins/native/syscall.c	(revision 3163)
+++ ksrc/skins/native/syscall.c	(working copy)
@@ -3656,7 +3656,7 @@
 #endif /* CONFIG_XENO_OPT_NATIVE_PIPE */
 
 /*
- * int __rt_misc_get_io_region(unsigned long start,
+ * int __rt_misc_get_io_region(uint64_t *start,
  *                             unsigned long len,
  *                             const char *label)
  */
@@ -3664,35 +3664,49 @@
 static int __rt_misc_get_io_region(struct task_struct *curr,
 				   struct pt_regs *regs)
 {
-	unsigned long start, len;
+	unsigned long len;
+	uint64_t start;
 	char label[64];
 
 	if (!__xn_access_ok
+	    (curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(start)))
+		return -EFAULT;
+
+	if (!__xn_access_ok
 	    (curr, VERIFY_READ, __xn_reg_arg3(regs), sizeof(label)))
 		return -EFAULT;
 
+	__xn_copy_from_user(curr, &start, (void __user *)__xn_reg_arg1(regs),
+			    sizeof(start));
+
 	__xn_strncpy_from_user(curr, label,
 			       (const char __user *)__xn_reg_arg3(regs),
 			       sizeof(label) - 1);
 	label[sizeof(label) - 1] = '\0';
 
-	start = __xn_reg_arg1(regs);
 	len = __xn_reg_arg2(regs);
 
 	return request_region(start, len, label) ? 0 : -EBUSY;
 }
 
 /*
- * int __rt_misc_put_io_region(unsigned long start,
+ * int __rt_misc_put_io_region(uint64_t *start,
  *                             unsigned long len)
  */
 
 static int __rt_misc_put_io_region(struct task_struct *curr,
 				   struct pt_regs *regs)
 {
-	unsigned long start, len;
+	unsigned long len;
+	uint64_t start;
 
-	start = __xn_reg_arg1(regs);
+	if (!__xn_access_ok
+	    (curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(start)))
+		return -EFAULT;
+
+	__xn_copy_from_user(curr, &start, (void __user *)__xn_reg_arg1(regs),
+			    sizeof(start));
+
 	len = __xn_reg_arg2(regs);
 	release_region(start, len);
 

--------------030700000004000300070100--

