Message-ID: <4786486C.1020907@domain.hid>
Date: Thu, 10 Jan 2008 17:31:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040301050205050104030008"
Subject: [Adeos-main] [PATCH] x86-32: micro-optimize mcount trampoline
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is a multi-part message in MIME format.
--------------040301050205050104030008
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Looking at the 64-bit variant and the implementation in glibc, I noticed
that we can still save some cycles in current mcount_32. With this patch
applied, the tracer still works and provides consistent output.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


--------------040301050205050104030008
Content-Type: text/x-patch;
 name="optimize-x86-32-mcount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="optimize-x86-32-mcount.patch"

---
 arch/x86/kernel/mcount_32.S |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6.24-rc6-xeno/arch/x86/kernel/mcount_32.S
===================================================================
--- linux-2.6.24-rc6-xeno.orig/arch/x86/kernel/mcount_32.S
+++ linux-2.6.24-rc6-xeno/arch/x86/kernel/mcount_32.S
@@ -9,17 +9,13 @@ mcount:
 	cmpl $0,ipipe_trace_enable
 	je out
 
-	pushl %ebp
-	movl %esp,%ebp
-
 	pushl %eax
 	pushl %ecx
 	pushl %edx
 
 	pushl $0		# no additional value (v)
-	movl (%ebp),%eax
-	movl 0x4(%ebp),%edx	# __CALLER_ADDR0
-	movl 0x4(%eax),%ecx	# __CALLER_ADDR1
+	movl 4(%ebp),%ecx	# __CALLER_ADDR1
+	movl 16(%esp),%edx	# __CALLER_ADDR0
 	movl $0,%eax		# IPIPE_TRACE_FUNC
 	call __ipipe_trace
 	popl %eax
@@ -27,6 +23,5 @@ mcount:
 	popl %edx
 	popl %ecx
 	popl %eax
-	popl %ebp
 out:
 	ret


--------------040301050205050104030008--

