Message-ID: <433D0A28.7040603@domain.hid>
Date: Fri, 30 Sep 2005 17:49:28 +0800
From: Wen-chien Jesse Sung <jesse@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050005060904020209050502"
Subject: [Adeos-main] PATCH: compilation fix for 2.6.13-i386-1.0-04
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------050005060904020209050502
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit

Hi,

I got this error message with 2.6.13-i386-1.0-04:

  CC      arch/i386/kernel/ipipe-core.o
arch/i386/kernel/ipipe-core.c: In function '__ipipe_if_fixup_root':
arch/i386/kernel/ipipe-core.c:549: warning: 'flags' is used
uninitialized in this function
arch/i386/kernel/ipipe-core.c: In function '__ipipe_kpreempt_root':
arch/i386/kernel/ipipe-core.c:585: warning: 'flags' is used
uninitialized in this function
arch/i386/kernel/ipipe-core.c: In function '__ipipe_syscall_root':
arch/i386/kernel/ipipe-core.c:549: warning: 'flags' is used
uninitialized in this function
arch/i386/kernel/ipipe-core.c:549: warning: 'flags' is used
uninitialized in this function
arch/i386/kernel/ipipe-core.c: In function '__ipipe_handle_exception':
arch/i386/kernel/ipipe-core.c:549: warning: 'flags' is used
uninitialized in this function
arch/i386/kernel/ipipe-core.c: In function '__ipipe_divert_exception':
arch/i386/kernel/ipipe-core.c:549: warning: 'flags' is used
uninitialized in this function
/bin/sh: line 1: 23642 Done                    gcc -m32 -E
-D__GENKSYMS__ -Wp,-MD,arch/i386/kernel/.ipipe-core.o.d -nostdinc
-isystem /usr/lib/gcc/i486-linux-gnu/4.0.2/include -D__KERNEL__
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -pipe -msoft-float
-mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i486 -mregparm=3
-Iinclude/asm-i386/mach-default -Wdeclaration-after-statement
-Wno-pointer-sign -DKBUILD_BASENAME=ipipe_core
-DKBUILD_MODNAME=ipipe_core arch/i386/kernel/ipipe-core.c
     23644 Segmentation fault      | scripts/genksyms/genksyms
>arch/i386/kernel/.tmp_ipipe-core.vermake[1]: ***
[arch/i386/kernel/ipipe-core.o] Error 139
make: *** [arch/i386/kernel] Error 2


Place the fastcall qualifier in front of "void" then genksyms does not
fail with Segmentation fault again. :)

-- 
Best Regards,
Wen-chien Jesse Sung

--------------050005060904020209050502
Content-Type: text/x-patch;
 name="30_adeos-compilation-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="30_adeos-compilation-fix.patch"

Index: linux-2.6.13-js1-opnet/arch/i386/kernel/ipipe-core.c
===================================================================
--- linux-2.6.13-js1-opnet.orig/arch/i386/kernel/ipipe-core.c	2005-09-30 16:00:01.000000000 +0800
+++ linux-2.6.13-js1-opnet/arch/i386/kernel/ipipe-core.c	2005-09-30 16:02:11.000000000 +0800
@@ -694,7 +694,7 @@
 fastcall void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 fastcall void do_iret_error(struct pt_regs *regs, long error_code);
 
-static void (fastcall *__ipipe_std_extable[])(struct pt_regs *, long) = {
+static fastcall void (*__ipipe_std_extable[])(struct pt_regs *, long) = {
 
 	[ex_do_divide_error] = &do_divide_error,
 	[ex_do_overflow] = &do_overflow,

--------------050005060904020209050502--

