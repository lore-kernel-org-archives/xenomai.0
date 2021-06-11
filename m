From: Richard Weinberger <richard@nod.at>
Subject: [PATCH][3.x] kernel: syscall: Correctly check for x32
Date: Fri, 11 Jun 2021 09:57:06 +0200
Message-Id: <20210611075706.29544-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>

Since 10.2 gcc it sets __ILP32__ even for i386.
To check for x32 we need to check for __x86_64__ being set too.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
While x32 is gone in master, 3.x stable still has it.
Without this patch it is not possible to build Xenomai for i386
with a recent gcc toolchain.
---
 kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h b/=
kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
index aa9936dfd..1626430c1 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
@@ -18,7 +18,7 @@
 #ifndef _COBALT_X86_ASM_UAPI_SYSCALL_H
 #define _COBALT_X86_ASM_UAPI_SYSCALL_H
=20
-#ifdef __ILP32__
+#if defined(__x86_64__) && defined(__ILP32__)
 #define __xn_syscall_base  __COBALT_X32_BASE
 #else
 #define __xn_syscall_base  0
--=20
2.17.1


