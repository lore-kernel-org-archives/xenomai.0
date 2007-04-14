From: Stelian Pop <stelian@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 14 Apr 2007 23:16:11 +0200
Message-Id: <1176585372.15994.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PATCH] Support EABI enabled kernels on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

The attached patch adds an option to make Xenomai userspace issue EABI
syscalls. This is needed to make Xenomai work with kernels compiled with
CONFIG_EABI.

Note that due to a change in syscall handling when the EABI layer was
added in the kernel, this patch is needed for all EABI enabled kernels,
even if the CONFIG_OABI_COMPAT compatibility layer has been enabled.

All sensible combinations should be supported: old ABI userspace with
old ABI kernel, old ABI userspace with CONFIG_OABI_COMPAT kernels, EABI
userspace with EABI kernels. The other combinations will fail with a
SIGILL signal.

Don't forget to run 'scripts/bootstrap' after applying this patch...

Signed-off-by: Stelian Pop <stelian@domain.hid>

Index: include/asm-arm/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/syscall.h	(r=E9vision 2385)
+++ include/asm-arm/syscall.h	(copie de travail)
@@ -24,11 +24,12 @@
 #define _XENO_ASM_ARM_SYSCALL_H
=20
 #include <asm-generic/xenomai/syscall.h>
+#include <asm/xenomai/features.h>
=20
 #define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0xffff))
 #define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000)
=20
-#define XENO_ARM_SYSCALL        0x009F0042	/* carefully chosen... */
+#define XENO_ARM_SYSCALL        0x000F0042	/* carefully chosen... */
=20
 #ifdef __KERNEL__
=20
@@ -46,7 +47,13 @@
 #define __xn_reg_arg4(regs)     ((regs)->ARM_r4)
 #define __xn_reg_arg5(regs)     ((regs)->ARM_r5)
=20
-#define __xn_reg_mux_p(regs)    ((regs)->ARM_r7 =3D=3D XENO_ARM_SYSCALL)
+/* In OABI_COMPAT mode, handle both OABI and EABI userspace syscalls */
+#ifdef CONFIG_OABI_COMPAT
+#define __xn_reg_mux_p(regs)    ( ((regs)->ARM_r7 =3D=3D __NR_OABI_SYSCA=
LL_BASE + XENO_ARM_SYSCALL) || \
+                                  ((regs)->ARM_r7 =3D=3D __NR_SYSCALL_BA=
SE + XENO_ARM_SYSCALL) )
+#else
+#define __xn_reg_mux_p(regs)      ((regs)->ARM_r7 =3D=3D __NR_SYSCALL_BA=
SE + XENO_ARM_SYSCALL)
+#endif
=20
 #define __xn_mux_id(regs)       ((__xn_reg_mux(regs) >> 16) & 0xff)
 #define __xn_mux_op(regs)       ((__xn_reg_mux(regs) >> 24) & 0xff)
@@ -134,17 +141,28 @@
 #define __sys2(x)	#x
 #define __sys1(x)	__sys2(x)
=20
+#ifdef CONFIG_XENO_ARM_EABI
+#define __SYS_REG register unsigned long __r7 __asm__ ("r7") =3D XENO_AR=
M_SYSCALL;
+#define __SYS_REG_LIST ,"r" (__r7)
+#define __syscall "swi\t0"
+#else
+#define __SYS_REG
+#define __SYS_REG_LIST
+#define __syscall "swi\t" __sys1(XENO_ARM_SYSCALL) ""
+#endif
+
 #define XENOMAI_DO_SYSCALL(nr, shifted_id, op, args...)	\
   ({								\
         unsigned long __res;					\
 	register unsigned long __res_r0 __asm__ ("r0");		\
    	ASM_INDECL_##nr;					\
+    __SYS_REG;                          \
 								\
 	LOADARGS_##nr(__xn_mux_code(shifted_id,op), args);	\
-	__asm__ __volatile__ (					\
-"       swi " __sys1(XENO_ARM_SYSCALL)				\
+	__asm__ __volatile__ (				\
+        __syscall                       \
 		: "=3Dr" (__res_r0)				\
-		: ASM_INPUT_##nr				\
+		: ASM_INPUT_##nr __SYS_REG_LIST	\
 		: "memory");					\
    	__res =3D __res_r0;					\
    	(int) __res;						\
Index: include/asm-arm/features.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/features.h	(r=E9vision 2385)
+++ include/asm-arm/features.h	(copie de travail)
@@ -30,12 +30,17 @@
 #define CONFIG_XENO_ARM_SA1000	1
 #endif
=20
+#ifdef CONFIG_AEABI
+#define CONFIG_XENO_ARM_EABI    1
+#endif
+
 #else /* !__KERNEL__ */
 #define __LINUX_ARM_ARCH__  CONFIG_XENO_ARM_ARCH
 #endif /* __KERNEL__ */
=20
 #define __xn_feat_arm_atomic_xchg	0x00000001
 #define __xn_feat_arm_atomic_atomic	0x00000002
+#define __xn_feat_arm_eabi          0x00000004
=20
 /* The ABI revision level we use on this arch. */
 #define XENOMAI_ABI_REV   1UL
@@ -53,10 +58,12 @@
 #endif
 #define __xn_feat_arm_atomic_atomic_mask	0
 #endif
+#define __xn_feat_arm_eabi_mask	__xn_feat_arm_eabi
=20
-#define XENOMAI_FEAT_DEP  ( __xn_feat_generic_mask | \
-			    __xn_feat_arm_atomic_xchg_mask |		\
-			    __xn_feat_arm_atomic_atomic_mask)
+#define XENOMAI_FEAT_DEP  ( __xn_feat_generic_mask              | \
+                            __xn_feat_arm_atomic_xchg_mask      | \
+                            __xn_feat_arm_atomic_atomic_mask    | \
+                            __xn_feat_arm_eabi_mask )
=20
 #define XENOMAI_FEAT_MAN  0
=20
@@ -72,6 +79,8 @@
 	    return "sa1100";
 	case __xn_feat_arm_atomic_atomic:
 	    return "v6";
+    case __xn_feat_arm_eabi:
+        return "eabi";
     default:
 	    return get_generic_feature_label(feature);
     }
Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in	(r=E9vision 2385)
+++ configure.in	(copie de travail)
@@ -159,6 +159,7 @@
   AC_MSG_CHECKING(for ARM architecture version)
   CONFIG_XENO_ARM_ARCH=3D4
   CONFIG_XENO_ARM_SA1100=3D
+  CONFIX_XENO_ARM_EABI=3D
   AC_ARG_ENABLE(arm-arch,
     AS_HELP_STRING([--enable-arm-arch=3D<version>], [Select ARM architec=
ture version]),
     [
@@ -178,6 +179,14 @@
 	*) unset CONFIG_XENO_ARM_SA1100 ;;
 	esac])
   AC_MSG_RESULT(${CONFIG_XENO_ARM_SA1100:-no})
+  AC_MSG_CHECKING(for ARM EABI interface)
+  AC_ARG_ENABLE(arm-eabi,
+	AS_HELP_STRING([--enable-arm-eabi], [Enable ARM EABI interface]),
+	[case "$enableval" in
+	y | yes) CONFIG_XENO_ARM_EABI=3Dy ;;
+	*) unset CONFIG_XENO_ARM_EABI ;;
+	esac])
+  AC_MSG_RESULT(${CONFIG_XENO_ARM_EABI:-no})
 fi
=20
 dnl Flags for building Linux in Xenomai build tree.
@@ -418,6 +427,7 @@
 test x$CONFIG_X86_TSC =3D xy && AC_DEFINE(CONFIG_X86_TSC,1,[config])
 test -n "$CONFIG_XENO_ARM_ARCH" && AC_DEFINE_UNQUOTED(CONFIG_XENO_ARM_AR=
CH,$CONFIG_XENO_ARM_ARCH,[config])
 test x$CONFIG_XENO_ARM_SA1100 =3D xy && AC_DEFINE(CONFIG_XENO_ARM_SA1100=
,1,[config])
+test x$CONFIG_XENO_ARM_EABI =3D xy && AC_DEFINE(CONFIG_XENO_ARM_EABI,1,[=
config])
=20
 dnl CAUTION: We need to have the CONFIG_XENO_XX symbols always
 dnl defined when the configuration header is read, but we want the
Index: README.INSTALL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- README.INSTALL	(r=E9vision 2385)
+++ README.INSTALL	(copie de travail)
@@ -164,6 +164,8 @@
 --enable-arm-sa1100 Enable SA1100 specific           strong,disabled
                     workarounds
=20
+--enable-arm-eabi   Enable ARM EABI interface        weak,disabled
+
 (*) Each option enabled by default can be forcibly disabled by passing
 --disable-<option> to the configure script.
=20

--=20
Stelian Pop <stelian@domain.hid>


