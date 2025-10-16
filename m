Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696B2DE1E3
	for <xenomai@lists.linux.dev>; Thu, 16 Oct 2025 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596352; cv=none; b=lsWOroyNXbeClds4Rb53wdAvnCk1vkXUZMJtomfDMTkneOnWGffuevDAAtlbnLI7PaVEL+78tq3qHvEzXAW+8R/apkOgMtHXv4QXKZwtpTsJLGu0P/t6vhMTKU7TZE8lOOnwyvOQv4HjWVxhrP31fvYg75RLZECqLoLu7Hv0i/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596352; c=relaxed/simple;
	bh=2nYI4qNidBZuzmWuoBP458EI/mrkTVo9rS9pLL5cPiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqriK23r25hlK27RClv8W6h3YWxwSt1LA2WbO0J0jL62aAktH8baNHeYoK5IVgqBgobFLLMEK6oRR3ISL4gy1oUJXktoFmhj03Ji2WxHbtXwKXXZVZUocBFGpdGFjNuLGA+WdLmAsdW9lKataVve6frAe23CZh0/BYkHvGBG218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=LF3/bnru; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LF3/bnru"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251016063226182cae46200002076a
        for <xenomai@lists.linux.dev>;
        Thu, 16 Oct 2025 08:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aQ0EghxcLUE8wVwT4Ob0svRoxJYJqu5VAjYkzvamfQA=;
 b=LF3/bnruYQscrJdx6bABXdLTzwWTmGgufxu0701LQFkc7PpWNYv5hf2gBzH9kRBesUTiYx
 RM7wtx/djHji8yF2r1PAfWumSRYc95b6jL9bP1yc2WQKRzwTD/hLLd+xkC5/srD9VIlB6AGP
 hPwlPEo087yxuMuUc+YR43kBFoYIg+kFxESyrE0NnSjK9UPZsIXuZEZvs3vpsL3u1Wmtfp+8
 dkljbxjIhTUr+IEMgFgSSxd26qbC2uqKmJvFkefQVMYzwTmdhgCIG+eRcEPdBJFzgDIWso0O
 QQmREEV/CYh4HohpBtbOLUn/tz0WfAmPcE+Xn3wFpErvi/55+mcvaMiQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2 6/7] lib/cobalt: x86: Fix and simplify 32-bit syscall argument setup
Date: Thu, 16 Oct 2025 08:32:23 +0200
Message-ID: <66fd9ced384ca8b4afb79ee6872ef214cd235486.1760596344.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760596344.git.jan.kiszka@siemens.com>
References: <cover.1760596344.git.jan.kiszka@siemens.com>
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

