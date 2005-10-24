Message-ID: <435CA17B.8010303@domain.hid>
Date: Mon, 24 Oct 2005 11:55:23 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060300000800060605030805"
Subject: [Xenomai-core] [PATCH: 3/3] powerpc merge
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

This is a multi-part message in MIME format.
--------------060300000800060605030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alter makefiles to accomodate the new powerpc arch and forget the old 
ppc and ppc64 ones. This is based on guesswork and will probably need 
some clean(s)ing up by somebody more knowledgeable on the Xenomai 
makefile system. The problem is that the makefiles need to map three 
kernel archs (ppc,ppc64 and the future powerpc) to one xenomai arch 
(powerpc).

-- Heikki Lindholm


--------------060300000800060605030805
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-powerpc-merge-051023-makefiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="xenomai-powerpc-merge-051023-makefiles.patch"

diff -Nru --exclude=.svn xenomai-orig/arch/GNUmakefile.am xenomai-devel/arch/GNUmakefile.am
--- xenomai-orig/arch/GNUmakefile.am	2005-10-11 10:32:31.000000000 +0300
+++ xenomai-devel/arch/GNUmakefile.am	2005-10-23 11:32:19.000000000 +0300
@@ -3,10 +3,10 @@
 endif
 
 if CONFIG_PPC64
-ARCHDIR = ppc64
+ARCHDIR = powerpc
 else
 if CONFIG_PPC
-ARCHDIR = ppc
+ARCHDIR = powerpc
 endif
 endif
 
diff -Nru --exclude=.svn xenomai-orig/config/kconfig/Makefile.kconfig xenomai-devel/config/kconfig/Makefile.kconfig
--- xenomai-orig/config/kconfig/Makefile.kconfig	2005-10-11 10:32:11.000000000 +0300
+++ xenomai-devel/config/kconfig/Makefile.kconfig	2005-10-23 15:58:12.000000000 +0300
@@ -32,33 +32,40 @@
 endif
 endif
 
+ifeq ($(ARCH), ppc)
+	XENO_ARCH := powerpc
+endif
+ifeq ($(ARCH), ppc64)
+	XENO_ARCH := powerpc
+endif
+
 LXDIALOG_OBJS := lxdialog/checklist.o lxdialog/menubox.o \
 		 lxdialog/textbox.o lxdialog/yesno.o lxdialog/inputbox.o \
 		 lxdialog/util.o lxdialog/lxdialog.o lxdialog/msgbox.o
 
 xconfig: qconf
-	@./qconf $(srctree)/arch/$(ARCH)/Kconfig
+	@./qconf $(srctree)/arch/$(XENO_ARCH)/Kconfig
 
 gconfig: gconf
-	@./gconf $(srctree)/arch/$(ARCH)/Kconfig
+	@./gconf $(srctree)/arch/$(XENO_ARCH)/Kconfig
 
 menuconfig mconfig: mconf
-	@./mconf $(srctree)/arch/$(ARCH)/Kconfig
+	@./mconf $(srctree)/arch/$(XENO_ARCH)/Kconfig
 
 config: conf
-	@./conf $(srctree)/arch/$(ARCH)/Kconfig
+	@./conf $(srctree)/arch/$(XENO_ARCH)/Kconfig
 
 oldconfig: conf
-	@./conf -o $(srctree)/arch/$(ARCH)/Kconfig
+	@./conf -o $(srctree)/arch/$(XENO_ARCH)/Kconfig
 
 qconf: .qtinst
-	$(MAKE) -f $(srcdir)/Makefile.kconfig qbuild srctree=$(srctree) ARCH=$(ARCH)
+	$(MAKE) -f $(srcdir)/Makefile.kconfig qbuild srctree=$(srctree) ARCH=$(ARCH) XENO_ARCH=$(XENO_ARCH)
 
 qbuild: qconf.o kconfig_load.o libkconfig.so
 	$(CXX) -o qconf $^ -Wl,-rpath,$(this_dir) -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) -ldl
 
 gconf: .gtkinst
-	$(MAKE) -f $(srcdir)/Makefile.kconfig gbuild srctree=$(srctree) ARCH=$(ARCH)
+	$(MAKE) -f $(srcdir)/Makefile.kconfig gbuild srctree=$(srctree) ARCH=$(ARCH) XENO_ARCH=$(XENO_ARCH)
 
 gbuild: gconf.o kconfig_load.o libkconfig.so
 	$(CC) -o gconf $^ -Wl,-rpath,$(this_dir) $(GLIBS)
diff -Nru --exclude=.svn xenomai-orig/configure.in xenomai-devel/configure.in
--- xenomai-orig/configure.in	2005-10-23 11:00:14.000000000 +0300
+++ xenomai-devel/configure.in	2005-10-23 15:58:41.000000000 +0300
@@ -48,21 +48,25 @@
 case "$host" in
  i*86*-*)
 	XENO_TARGET_ARCH=i386
+	XENO_KERNEL_TARGET_ARCH=i386
 	wanted_kernel_arch=CONFIG_X86
 	arch_have_sim=y
         ;;
  powerpc-*|ppc-*)
-	XENO_TARGET_ARCH=ppc
+	XENO_TARGET_ARCH=powerpc
+	XENO_KERNEL_TARGET_ARCH=ppc
 	wanted_kernel_arch=CONFIG_PPC
 	arch_have_sim=y
         ;;
  powerpc64-*|ppc64-*)
-	XENO_TARGET_ARCH=ppc64
+	XENO_TARGET_ARCH=powerpc
+	XENO_KERNEL_TARGET_ARCH=ppc64
 	wanted_kernel_arch=CONFIG_PPC64
 	arch_have_sim=y
         ;;
  ia64-*)
 	XENO_TARGET_ARCH=ia64
+	XENO_KERNEL_TARGET_ARCH=ia64
 	wanted_kernel_arch=CONFIG_IA64
 	arch_have_sim=y
         ;;
@@ -226,7 +230,7 @@
 AC_MSG_CHECKING([for interrupt pipeline extension])
 
 if test -r $XENO_LINUX_SRCDIR/include/linux/ipipe.h; then
-   v=`grep '^#define.*IPIPE_ARCH_STRING.*"' $XENO_LINUX_SRCDIR/include/asm-$XENO_TARGET_ARCH/ipipe.h|sed -e 's,.*"\(.*\)"$,\1,'`
+   v=`grep '^#define.*IPIPE_ARCH_STRING.*"' $XENO_LINUX_SRCDIR/include/asm-$XENO_KERNEL_TARGET_ARCH/ipipe.h|sed -e 's,.*"\(.*\)"$,\1,'`
    AC_MSG_RESULT([Adeos newgen (I-pipe $v)])
    if test x${CONFIG_IPIPE} = x; then
       AC_MSG_ERROR([Please activate the Adeos support in $XENO_LINUX_DIR and rebuild your kernel])
@@ -235,7 +239,7 @@
       AC_MSG_ERROR([Please re-patch your kernel with the Adeos support])
    fi
 elif test -r $XENO_LINUX_SRCDIR/include/linux/adeos.h; then
-   v=`grep '^#define.*ADEOS_ARCH_STRING.*"' $XENO_LINUX_SRCDIR/include/asm-$XENO_TARGET_ARCH/adeos.h|sed -e 's,.*"\(.*\)"$,\1,'`
+   v=`grep '^#define.*ADEOS_ARCH_STRING.*"' $XENO_LINUX_SRCDIR/include/asm-$XENO_KERNEL_TARGET_ARCH/adeos.h|sed -e 's,.*"\(.*\)"$,\1,'`
    AC_MSG_RESULT([Adeos oldgen ($v)])
    if test x${CONFIG_ADEOS_CORE} = x; then
       AC_MSG_ERROR([Please activate the Adeos support in $XENO_LINUX_DIR and rebuild your kernel])
@@ -309,7 +313,7 @@
 
 HOST_EXTRACFLAGS += -DXENO_CFLAGS="\"\$(CC) \$(CFLAGS)\""
 EOF
-CC="$CC" make -s -C $XENO_LINUX_DIR ARCH=$XENO_TARGET_ARCH \
+CC="$CC" make -s -C $XENO_LINUX_DIR XENO_ARCH=$XENO_TARGET_ARCH ARCH=$XENO_KERNEL_TARGET_ARCH \
         CROSS_COMPILE=$CROSS_COMPILE M=$PWD/.xeno_display_archflags >& /dev/null
 for flag in `.xeno_display_archflags/display_archflags`; do case $flag in
     -march*|-mcpu*|-mtune*|-m32|-Wa,-me500|-EB|-EL)
@@ -757,7 +761,7 @@
 	AC_MSG_RESULT(${CONFIG_XENO_HW_X86_SEP:-no})
 	test \! x$CONFIG_XENO_HW_X86_SEP = x && AC_DEFINE(CONFIG_XENO_HW_X86_SEP,1,[Kconfig])
         ;;
- ppc|ppc64)
+ powerpc)
 	timer_type=decrementer
         ;;
  ia64)
@@ -1320,7 +1324,7 @@
 XENO_MODULE_EXT=.ko
 XENO_KBUILD_ENV='src2obj = $(patsubst %.$(1),%.o,$(filter %.$(1),$(call notdir,$(2))))'
 XENO_KBUILD_CMD="@for src in \$(filter-out FORCE, \$^); do if test \\! -r \`basename \$\$src\`; then \$(LN_S) \$\$src; fi; done; \
-                    CC=\"$CC\" \$(MAKE) -C $XENO_LINUX_DIR CROSS_COMPILE=\$(CROSS_COMPILE) ARCH=$XENO_TARGET_ARCH \
+                    CC=\"$CC\" \$(MAKE) -C $XENO_LINUX_DIR CROSS_COMPILE=\$(CROSS_COMPILE) XENO_ARCH=$XENO_TARGET_ARCH ARCH=$XENO_KERNEL_TARGET_ARCH \
 		    M=\$\$PWD xeno_srctree=\`cd \$(top_srcdir) && pwd\` xeno_srcdir=\`cd \$(srcdir) && pwd\` V=\$(V) MODVERDIR=$top_builddir/symbols modules \
 		    xeno_objs='\$(call src2obj,c,\$^) \$(call src2obj,S,\$^) \$(call src2obj,cc,\$^) \$(call src2obj,cpp,\$^)' xeno_target=\$(basename \$@)"
 
@@ -1365,16 +1369,11 @@
 	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe -fstrict-aliasing $gcc_w_noalias"
 	XENO_FP_CFLAGS="-ffast-math -mhard-float"
         ;;
- ppc)
+ powerpc)
 	XENO_TARGET_SUBARCH=
 	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
 	XENO_FP_CFLAGS="-ffast-math -mhard-float"
         ;;
- ppc64)
-	XENO_TARGET_SUBARCH=
-	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -Wstrict-prototypes -pipe"
-	XENO_FP_CFLAGS="-ffast-math -mhard-float"
-        ;;
  ia64)
 	XENO_TARGET_SUBARCH=
 	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
@@ -1460,18 +1459,15 @@
 	arch/GNUmakefile \
         arch/i386/GNUmakefile \
 	arch/i386/hal/GNUmakefile \
-        arch/ppc/GNUmakefile \
-	arch/ppc/hal/GNUmakefile \
-        arch/ppc64/GNUmakefile \
-	arch/ppc64/hal/GNUmakefile \
+        arch/powerpc/GNUmakefile \
+	arch/powerpc/hal/GNUmakefile \
         arch/ia64/GNUmakefile \
 	arch/ia64/hal/GNUmakefile \
 	include/GNUmakefile \
 	include/nucleus/GNUmakefile \
 	include/nucleus/asm-generic/GNUmakefile \
 	include/nucleus/asm-i386/GNUmakefile \
-	include/nucleus/asm-ppc/GNUmakefile \
-	include/nucleus/asm-ppc64/GNUmakefile \
+	include/nucleus/asm-powerpc/GNUmakefile \
 	include/nucleus/asm-ia64/GNUmakefile \
 	include/nucleus/asm-uvm/GNUmakefile \
 	doc/man/GNUmakefile \
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/GNUmakefile.am xenomai-devel/include/nucleus/GNUmakefile.am
--- xenomai-orig/include/nucleus/GNUmakefile.am	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-devel/include/nucleus/GNUmakefile.am	2005-10-23 11:23:10.000000000 +0300
@@ -5,11 +5,11 @@
 endif
 
 if CONFIG_PPC
-ARCHDIR = asm-ppc
+ARCHDIR = asm-powerpc
 endif
 
 if CONFIG_PPC64
-ARCHDIR = asm-ppc64
+ARCHDIR = asm-powerpc
 endif
 
 if CONFIG_IA64

--------------060300000800060605030805--

