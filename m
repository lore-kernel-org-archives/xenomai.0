Message-ID: <4734995E.7090105@domain.hid>
Date: Fri, 09 Nov 2007 12:31:10 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <473391B0.5040809@domain.hid> <4733A2B8.8070100@domain.hid>
	<47344759.4020505@domain.hid> <473484C6.6050101@domain.hid>
	<473492EF.6090309@domain.hid>
In-Reply-To: <473492EF.6090309@domain.hid>
Content-Type: multipart/mixed; boundary="------------010102060104040906010501"
Subject: Re: [Xenomai-core] User space drivers on PPC440
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
--------------010102060104040906010501
Content-Type: multipart/alternative;
 boundary="------------020808050305030706040703"


--------------020808050305030706040703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Solved.  As you pointed out, Xenomai inverts the returned value from 
request_region.  So, that was a bug in my application.

However, turns out that instead of request_region, I have to use 
request_mem_region.  This is because the I/O region only goes up to 
2^32, but the mem region goes up to 2^64.

So, attached is a patch to add two new syscalls: rt_misc_get_mem_region 
and rt_misc_put_mem_region.

    Steve


Philippe Gerum wrote:
> Steven A. Falco wrote:
>   
>> Your patch makes sense.
>>
>> I have some results, but I'm not sure I understand what they mean.  I've
>> attached the test program that I am using.  Here is what it outputs:
>>
>> bash-3.00# ./o2
>> Trying to free nonexistent resource <0000000000000000-00000000c0000001>
>> get leds: -16 Device or resource busy
>> put leds: 0 Success
>>
>> Trying to free nonexistent resource <0000000000000000-ffffffffffffffff>
>> get low_mem: -16 Device or resource busy
>> put low_mem: 0 Success
>>     
>
> Actually, we should define rt_misc_put_io_region() as a void routine,
> since the kernel does not return any status from release_region(). At
> this chance, I've fixed this, since returning 0 albeit a failure message
> is dumped to the kernel log upon error is disturbing.
>
>   
>> I am a little unclear on request_resource() - the return code is
>> backwards of what I would have expected.  Looking at examples in the
>> kernel, it appears that request_resource() returns EBUSY when things go
>> well, and it returns 0 when things go badly.  Like I said, that seems
>> backwards, but I guess it makes sense - EBUSY apparently means that the
>> resource is _now_ busy?
>>
>>     
>
> request_resource() should return a valid resource descriptor address
> upon success, which Xenomai converts to zero. Conversely, -EBUSY is
> returned if request_region() sends us back a NULL value, since this is
> how check_region() behaves.
>
>   
>> Anyway, following the kernel examples, my program considers a non-zero
>> return as success.  At that point I release the region.  If instead, I
>> get a zero return, then I treat that as a failure, and don't release the
>> region.
>>
>> The part I don't understand is why I get the "Trying to free nonexistent
>> resource" messages.  Since I am getting an EBUSY, I thought that meant I
>> owned the resource, and that I should release it...
>>
>>     
>
> I suspect request_region() did actually fail.
>
>   
>> Also, the addresses printed above are a bit strange.  For example, I
>> would have thought that instead of
>> "<0000000000000000-00000000c0000001>", it would print
>> "<00000001c0000000-00000001c0000013>".  Perhaps that is a clue - maybe
>> the start and length are not being passed correctly.
>>
>> One more question.  It appears that if my program crashes, that the
>> region will never be released.  So, the normal behavior of an exiting
>> process freeing all its resources doesn't seem to be guaranteed.
>>
>>     
>
> As a matter of fact, we track all common objects like sema4s, mutexes,
> queues, and so on, but not I/O regions. Consider this as an illustration
> of our absolute laziness, since we do have the proper infrastructure to
> handle I/O regions in the auto-cleanup process too.
>
>   
>>     Steve
>>
>>
>> Philippe Gerum wrote:
>>     
>>> Philippe Gerum wrote:
>>>   
>>>       
>>>> Steven A. Falco wrote:
>>>>     
>>>>         
>>>>> The rt_misc_get_io_region() has the "start" argument as an unsigned 
>>>>> long.  On the PPC440, we have a 36-bit address space, where the I/O 
>>>>> registers are generally above the 4GB area.  For example, the UART is at 
>>>>> address 0x1ef600300.
>>>>>
>>>>> The Linux request_region call has "start" typed as a resource_size_t, 
>>>>> which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
>>>>> though this is a 23-bit processor).
>>>>>
>>>>> Is this something that should be handled by xeno-config?  It could 
>>>>> append a CFLAG indicating the size of a resource.
>>>>>       
>>>>>           
>>>> Or use a 64bit long unconditionally, to keep the same kernel-based
>>>> implementation, since there is no performance issue for this call. In
>>>> any case, we need to fix the API before 2.4 final is out -- which will
>>>> also affect the ABI, but it already changed during the 2.4 development
>>>> phase anyway.
>>>>
>>>>     
>>>>         
>>> Does this patch work for you?
>>>
>>>   
>>>       
>
>
>   

--------------020808050305030706040703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>Solved.&nbsp; As you pointed out, Xenomai inverts the returned value
from request_region.&nbsp; So, that was a bug in my application.<br>
<br>
However, turns out that instead of request_region, I have to use
request_mem_region.&nbsp; This is because the I/O region only goes up to
2^32, but the mem region goes up to 2^64.<br>
<br>
So, attached is a patch to add two new syscalls: rt_misc_get_mem_region
and rt_misc_put_mem_region.<br>
<br>
&nbsp;&nbsp;&nbsp; Steve<br>
<br>
</tt><br>
Philippe Gerum wrote:
<blockquote cite="mid:473492EF.6090309@domain.hid" type="cite">
  <pre wrap="">Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Your patch makes sense.

I have some results, but I'm not sure I understand what they mean.  I've
attached the test program that I am using.  Here is what it outputs:

bash-3.00# ./o2
Trying to free nonexistent resource &lt;0000000000000000-00000000c0000001&gt;
get leds: -16 Device or resource busy
put leds: 0 Success

Trying to free nonexistent resource &lt;0000000000000000-ffffffffffffffff&gt;
get low_mem: -16 Device or resource busy
put low_mem: 0 Success
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Actually, we should define rt_misc_put_io_region() as a void routine,
since the kernel does not return any status from release_region(). At
this chance, I've fixed this, since returning 0 albeit a failure message
is dumped to the kernel log upon error is disturbing.

  </pre>
  <blockquote type="cite">
    <pre wrap="">I am a little unclear on request_resource() - the return code is
backwards of what I would have expected.  Looking at examples in the
kernel, it appears that request_resource() returns EBUSY when things go
well, and it returns 0 when things go badly.  Like I said, that seems
backwards, but I guess it makes sense - EBUSY apparently means that the
resource is _now_ busy?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
request_resource() should return a valid resource descriptor address
upon success, which Xenomai converts to zero. Conversely, -EBUSY is
returned if request_region() sends us back a NULL value, since this is
how check_region() behaves.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Anyway, following the kernel examples, my program considers a non-zero
return as success.  At that point I release the region.  If instead, I
get a zero return, then I treat that as a failure, and don't release the
region.

The part I don't understand is why I get the "Trying to free nonexistent
resource" messages.  Since I am getting an EBUSY, I thought that meant I
owned the resource, and that I should release it...

    </pre>
  </blockquote>
  <pre wrap=""><!---->
I suspect request_region() did actually fail.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Also, the addresses printed above are a bit strange.  For example, I
would have thought that instead of
"&lt;0000000000000000-00000000c0000001&gt;", it would print
"&lt;00000001c0000000-00000001c0000013&gt;".  Perhaps that is a clue - maybe
the start and length are not being passed correctly.

One more question.  It appears that if my program crashes, that the
region will never be released.  So, the normal behavior of an exiting
process freeing all its resources doesn't seem to be guaranteed.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
As a matter of fact, we track all common objects like sema4s, mutexes,
queues, and so on, but not I/O regions. Consider this as an illustration
of our absolute laziness, since we do have the proper infrastructure to
handle I/O regions in the auto-cleanup process too.

  </pre>
  <blockquote type="cite">
    <pre wrap="">    Steve


Philippe Gerum wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Philippe Gerum wrote:
  
      </pre>
      <blockquote type="cite">
        <pre wrap="">Steven A. Falco wrote:
    
        </pre>
        <blockquote type="cite">
          <pre wrap="">The rt_misc_get_io_region() has the "start" argument as an unsigned 
long.  On the PPC440, we have a 36-bit address space, where the I/O 
registers are generally above the 4GB area.  For example, the UART is at 
address 0x1ef600300.

The Linux request_region call has "start" typed as a resource_size_t, 
which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
though this is a 23-bit processor).

Is this something that should be handled by xeno-config?  It could 
append a CFLAG indicating the size of a resource.
      
          </pre>
        </blockquote>
        <pre wrap="">Or use a 64bit long unconditionally, to keep the same kernel-based
implementation, since there is no performance issue for this call. In
any case, we need to fix the API before 2.4 final is out -- which will
also affect the ABI, but it already changed during the 2.4 development
phase anyway.

    
        </pre>
      </blockquote>
      <pre wrap="">Does this patch work for you?

  
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
</body>
</html>

--------------020808050305030706040703--

--------------010102060104040906010501
Content-Type: text/x-patch;
 name="rt_misc_get_mem_region.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_misc_get_mem_region.patch"

Index: include/native/misc.h
===================================================================
--- include/native/misc.h	(revision 3101)
+++ include/native/misc.h	(working copy)
@@ -39,6 +39,13 @@
 int rt_misc_put_io_region(unsigned long start,
 			  unsigned long len);
 
+int rt_misc_get_mem_region(uint64_t start,
+			  unsigned long len,
+			  const char *label);
+
+int rt_misc_put_mem_region(uint64_t start,
+			  unsigned long len);
+
 #ifdef __cplusplus
 }
 #endif
Index: include/native/syscall.h
===================================================================
--- include/native/syscall.h	(revision 3101)
+++ include/native/syscall.h	(working copy)
@@ -119,6 +119,8 @@
 #define __native_timer_tsc2ns       93
 #define __native_queue_write        94
 #define __native_queue_read         95
+#define __native_misc_get_mem_region 96
+#define __native_misc_put_mem_region 97
 
 struct rt_arg_bulk {
 
Index: src/skins/native/misc.c
===================================================================
--- src/skins/native/misc.c	(revision 3101)
+++ src/skins/native/misc.c	(working copy)
@@ -35,3 +35,17 @@
 	return XENOMAI_SKINCALL2(__native_muxid,
 				 __native_misc_put_io_region, start, len);
 }
+
+int rt_misc_get_mem_region(uint64_t start,
+			  unsigned long len, const char *label)
+{
+	return XENOMAI_SKINCALL3(__native_muxid,
+				 __native_misc_get_mem_region, &start, len,
+				 label);
+}
+
+int rt_misc_put_mem_region(uint64_t start, unsigned long len)
+{
+	return XENOMAI_SKINCALL2(__native_muxid,
+				 __native_misc_put_mem_region, &start, len);
+}
Index: ksrc/skins/native/syscall.c
===================================================================
--- ksrc/skins/native/syscall.c	(revision 3101)
+++ ksrc/skins/native/syscall.c	(working copy)
@@ -3692,6 +3692,64 @@
 	return 0;
 }
 
+/*
+ * int __rt_misc_get_mem_region(uint64_t *start,
+ *                             unsigned long len,
+ *                             const char *label)
+ */
+
+static int __rt_misc_get_mem_region(struct task_struct *curr,
+				   struct pt_regs *regs)
+{
+	unsigned long len;
+	uint64_t start;
+	char label[64];
+
+	if (!__xn_access_ok
+	    (curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(start)))
+		return -EFAULT;
+
+	if (!__xn_access_ok
+	    (curr, VERIFY_READ, __xn_reg_arg3(regs), sizeof(label)))
+		return -EFAULT;
+
+	__xn_copy_from_user(curr, &start, (void __user *)__xn_reg_arg1(regs),
+			    sizeof(start));
+
+	__xn_strncpy_from_user(curr, label,
+			       (const char __user *)__xn_reg_arg3(regs),
+			       sizeof(label) - 1);
+	label[sizeof(label) - 1] = '\0';
+
+	len = __xn_reg_arg2(regs);
+
+	return request_mem_region(start, len, label) ? 0 : -EBUSY;
+}
+
+/*
+ * int __rt_misc_put_mem_region(uint64_t *start,
+ *                             unsigned long len)
+ */
+
+static int __rt_misc_put_mem_region(struct task_struct *curr,
+				   struct pt_regs *regs)
+{
+	unsigned long len;
+	uint64_t start;
+
+	if (!__xn_access_ok
+	    (curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(start)))
+		return -EFAULT;
+
+	__xn_copy_from_user(curr, &start, (void __user *)__xn_reg_arg1(regs),
+			    sizeof(start));
+
+	len = __xn_reg_arg2(regs);
+	release_mem_region(start, len);
+
+	return 0;
+}
+
 static __attribute__ ((unused))
 int __rt_call_not_available(struct task_struct *curr, struct pt_regs *regs)
 {
@@ -3852,6 +3910,10 @@
 	    {&__rt_misc_put_io_region, __xn_exec_lostage},
 	[__native_timer_ns2tsc] = {&__rt_timer_ns2tsc, __xn_exec_any},
 	[__native_timer_tsc2ns] = {&__rt_timer_tsc2ns, __xn_exec_any},
+	[__native_misc_get_mem_region] =
+	    {&__rt_misc_get_mem_region, __xn_exec_lostage},
+	[__native_misc_put_mem_region] =
+	    {&__rt_misc_put_mem_region, __xn_exec_lostage},
 };
 
 extern xntbase_t *__native_tbase;

--------------010102060104040906010501--

