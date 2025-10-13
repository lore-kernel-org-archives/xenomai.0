Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461722AE65
	for <xenomai@lists.linux.dev>; Mon, 13 Oct 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375474; cv=none; b=YoQEIIFZzuVs8u54hvJsDkDEBoerBlwkAQbpRzhNCD7SXHLSije5th9X78UgaLcQriRZ35b80FjHVSk9QOHnZGeG0BPm0C9ixud54WFLvvxdOm7kSQAe1v6qfng+6aavmolk5jIlsKIzutxxQWoS8K5nzKRGyvPDi0aw0x/x6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375474; c=relaxed/simple;
	bh=2nYI4qNidBZuzmWuoBP458EI/mrkTVo9rS9pLL5cPiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZYHeMTCDBPgvDY/ODrqO+Xzj2ehIC07V749VIF0nFYySKNzi7SoiwP4GvKfQB9dhE3wWRcbjHKnpLZx7dZxZCNWjkY1Ln6pBeyaeSogWLFZzcG5rlHw7SvxAyME38UZQeCKjhaoEC2tcxWyNOLZurqjAp58URXeQxCsQfwX0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=U3iuNDCO; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="U3iuNDCO"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251013170101f7e44b27fd000207b9
        for <xenomai@lists.linux.dev>;
        Mon, 13 Oct 2025 19:01:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aQ0EghxcLUE8wVwT4Ob0svRoxJYJqu5VAjYkzvamfQA=;
 b=U3iuNDCOhunKiCFDcSxiP/bFqE+zqXDVbAo44JxW0UT5LTs3mZJLcjPhdJ/zl80oaQxd/v
 CQYST+zywwrv8GWM50Hn4hP6b5Ry6YKe+oAR2503hx7kBtkJOA3gp5tUjOrw8e4729jLptqh
 jDD835R0DTZmtUGsv+NLoIoh/Xzj6ySWRlHNdjotWUq9wz8SZ2HsJet9W10bJsA89Vst9IGD
 2l3E97xqREuy5UH9SiZvEZYid655K7Ag4ewP1l5CVZnuouopdqmKjJ33zNy/EGSq+jpOwpXh
 uOpOBIidVk+JjFqV+dkf8jGjF0GRW/bwKC2JXakJHDsjGE7HvJ4l1RYw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 6/6] lib/cobalt: x86: Fix and simplify 32-bit syscall argument setup
Date: Mon, 13 Oct 2025 19:01:00 +0200
Message-ID: <f7f09fec1e92730da837efb27d0c72da659aabe3.1760374860.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This ancient code to constructing the argument setup of 32-bit syscalls
now fail with recent compilers plus debug settings. Why the code was
once designed in such a complex way is 20 years+ later no longer clear,
but it seems that simply stating which register should contain which
argument as assembler constraints is just working today.

Fixes assembly sequences like these (__cobalt_timer_gettime):
   ...
   1395d:       c7 45 f4 75 00 00 00    movl   $0x75,-0xc(%ebp)
   13964:       8b 45 f4                mov    -0xc(%ebp),%eax
   13967:       0d 00 00 00 10          or     $0x10000000,%eax
   1396c:       89 c3                   mov    %eax,%ebx
   1396e:       8b 45 08                mov    0x8(%ebp),%eax
   13971:       8b 4d 0c                mov    0xc(%ebp),%ecx
   13974:       53                      push   %ebx
   13975:       89 c3                   mov    %eax,%ebx
   13977:       89 d8                   mov    %ebx,%eax
   13979:       65 ff 15 10 00 00 00    call   *%gs:0x10

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../arch/x86/include/asm/xenomai/syscall.h    | 71 ++-----------------
 1 file changed, 7 insertions(+), 64 deletions(-)

diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
index 79bf17ee75..d00bd287e3 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -41,50 +41,13 @@
 /* The one that cannot fail. */
 #define DOSYSCALLSAFE  "int $0x80\n\t"
 
-asm (".L__X'%ebx = 1\n\t"
-     ".L__X'%ecx = 2\n\t"
-     ".L__X'%edx = 2\n\t"
-     ".L__X'%eax = 3\n\t"
-     ".L__X'%esi = 3\n\t"
-     ".L__X'%edi = 3\n\t"
-     ".L__X'%ebp = 3\n\t"
-     ".L__X'%esp = 3\n\t"
-     ".macro bpushl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "pushl %ebx\n\t"
-     ".else\n\t"
-     "xchgl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t"
-     ".macro bpopl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "popl %ebx\n\t"
-     ".else\n\t"
-     "xchgl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t"
-     ".macro bmovl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "movl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t");
-
 #define XENOMAI_DO_SYSCALL(nr, op, args...)			\
 ({								\
 	unsigned __resultvar;					\
 	asm volatile (						\
-		LOADARGS_##nr					\
-		"movl %1, %%eax\n\t"				\
 		DOSYSCALL					\
-		RESTOREARGS_##nr				\
 		: "=a" (__resultvar)				\
-		: "g" (__xn_syscode(op)) ASMFMT_##nr(args)	\
+		: "a" (__xn_syscode(op)) ASMFMT_##nr(args)	\
 		: "memory", "cc");				\
 	(int) __resultvar;					\
 })
@@ -93,44 +56,24 @@ asm (".L__X'%ebx = 1\n\t"
 ({								\
 	unsigned __resultvar;					\
 	asm volatile (						\
-		LOADARGS_##nr					\
-		"movl %1, %%eax\n\t"				\
 		DOSYSCALLSAFE					\
-		RESTOREARGS_##nr				\
 		: "=a" (__resultvar)				\
-		: "g" (__xn_syscode(op)) ASMFMT_##nr(args)	\
+		: "a" (__xn_syscode(op)) ASMFMT_##nr(args)	\
 		: "memory", "cc");				\
 	(int) __resultvar;					\
 })
 
-#define LOADARGS_0
-#define LOADARGS_1 \
-	"bpushl .L__X'%k2, %k2\n\t" \
-	"bmovl .L__X'%k2, %k2\n\t"
-#define LOADARGS_2	LOADARGS_1
-#define LOADARGS_3	LOADARGS_1
-#define LOADARGS_4	LOADARGS_1
-#define LOADARGS_5	LOADARGS_1
-
-#define RESTOREARGS_0
-#define RESTOREARGS_1 \
-	"bpopl .L__X'%k2, %k2\n\t"
-#define RESTOREARGS_2	RESTOREARGS_1
-#define RESTOREARGS_3	RESTOREARGS_1
-#define RESTOREARGS_4	RESTOREARGS_1
-#define RESTOREARGS_5	RESTOREARGS_1
-
 #define ASMFMT_0()
 #define ASMFMT_1(arg1) \
-	, "acdSD" (arg1)
+	ASMFMT_0(), "b" (arg1)
 #define ASMFMT_2(arg1, arg2) \
-	, "adSD" (arg1), "c" (arg2)
+	ASMFMT_1(arg1), "c" (arg2)
 #define ASMFMT_3(arg1, arg2, arg3) \
-	, "aSD" (arg1), "c" (arg2), "d" (arg3)
+	ASMFMT_2(arg1, arg2), "d" (arg3)
 #define ASMFMT_4(arg1, arg2, arg3, arg4) \
-	, "aD" (arg1), "c" (arg2), "d" (arg3), "S" (arg4)
+	ASMFMT_3(arg1, arg2, arg3), "S" (arg4)
 #define ASMFMT_5(arg1, arg2, arg3, arg4, arg5) \
-	, "a" (arg1), "c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+	ASMFMT_4(arg1, arg2, arg3, arg4), "D" (arg5)
 
 #define XENOMAI_SYSBIND(breq) \
 	XENOMAI_DO_SYSCALL_SAFE(1, sc_cobalt_bind, breq)
-- 
2.51.0

