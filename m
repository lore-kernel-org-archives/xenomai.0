From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 25/25] lib/cobalt: dovetail: use clock_gettime() vcall for
 reading timestamps
Date: Thu, 20 May 2021 23:44:35 +0200
Message-Id: <f8cd2923b0b0c8e0bd9dbef84b24686b4984e61e.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Dovetail enables out-of-band access to the vDSO-based clock_gettime()
vcall from applications. If present, select this method instead of
relying on the hardware tick counter for CLOCK_MONOTONIC,
CLOCK_MONOTONIC_RAW, CLOCK_REALTIME and CLOCK_HOST_REALTIME.

At binding time, receiving a null hardware clock frequency from the
core means that we should obtain timestamps directly from the
vDSO-based clock_gettime() vcall (see cobalt_use_legacy_tsc()).

In this mode, Cobalt shares the in-band kernel's idea of time for all
common clocks such as CLOCK_MONOTONIC* and CLOCK_REALTIME. As a
result, CLOCK_HOST_REALTIME refers to the common CLOCK_REALTIME clock.
Furthermore, libcobalt's clock_settime(CLOCK_REALTIME) is delegated to
the underlying *libc, which means the caller may switch to secondary
mode.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/Makefile.am                        |   1 +
 .../arch/arm/include/asm/xenomai/time.h       |  16 +
 .../arch/arm64/include/asm/xenomai/time.h     |  16 +
 .../arch/powerpc/include/asm/xenomai/time.h   |  16 +
 .../arch/x86/include/asm/xenomai/time.h       |  16 +
 lib/cobalt/clock.c                            | 107 ++++---
 lib/cobalt/internal.h                         |   6 +
 lib/cobalt/parse_vdso.c                       | 281 ++++++++++++++++++
 lib/cobalt/ticks.c                            |  22 +-
 9 files changed, 445 insertions(+), 36 deletions(-)
 create mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/time.h
 create mode 100644 lib/cobalt/parse_vdso.c

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index ae408b863a..b3003cd957 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -22,6 +22,7 @@ libcobalt_la_SOURCES =		\
 	internal.c		\
 	mq.c			\
 	mutex.c			\
+	parse_vdso.c		\
 	printf.c		\
 	rtdm.c			\
 	sched.c			\
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
new file mode 100644
index 0000000000..34df7e9dff
--- /dev/null
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2021 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_ARM_TIME_H
+#define _LIB_COBALT_ARM_TIME_H
+
+#define COBALT_VDSO_VERSION	"LINUX_2.6"
+#define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
+
+#endif /* !_LIB_COBALT_ARM_TIME_H */
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
new file mode 100644
index 0000000000..d0dad6d888
--- /dev/null
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2021 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_ARM64_TIME_H
+#define _LIB_COBALT_ARM64_TIME_H
+
+#define COBALT_VDSO_VERSION	"LINUX_2.6.39"
+#define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
+
+#endif /* !_LIB_COBALT_ARM64_TIME_H */
diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/time.h b/lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
new file mode 100644
index 0000000000..92ba44b5a1
--- /dev/null
+++ b/lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2021 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_POWERPC_TIME_H
+#define _LIB_COBALT_POWERPC_TIME_H
+
+#define COBALT_VDSO_VERSION	"LINUX_2.6.15"
+#define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
+
+#endif /* !_LIB_COBALT_POWERPC_TIME_H */
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/time.h b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
new file mode 100644
index 0000000000..693be87361
--- /dev/null
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2021 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_X86_TIME_H
+#define _LIB_COBALT_X86_TIME_H
+
+#define COBALT_VDSO_VERSION	"LINUX_2.6"
+#define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
+
+#endif /* !_LIB_COBALT_X86_TIME_H */
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 11fd1aa29c..a0673d1fc9 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -149,6 +149,65 @@ static int __do_clock_host_realtime(struct timespec *ts)
 	return 0;
 }
 
+static int gettime_via_tsc(clockid_t clock_id, struct timespec *tp)
+{
+	unsigned long rem;
+	xnticks_t ns;
+	int ret;
+
+	switch (clock_id) {
+	case CLOCK_HOST_REALTIME:
+		ret = __do_clock_host_realtime(tp);
+		break;
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		ns = cobalt_ticks_to_ns(cobalt_read_tsc());
+		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
+		tp->tv_nsec = rem;
+		return 0;
+	case CLOCK_REALTIME:
+		ns = cobalt_ticks_to_ns(cobalt_read_tsc());
+		ns += cobalt_vdso->wallclock_offset;
+		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
+		tp->tv_nsec = rem;
+		return 0;
+	default:
+		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+	}
+
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int gettime_via_vdso(clockid_t clock_id, struct timespec *tp)
+{
+	int ret;
+
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+	case CLOCK_HOST_REALTIME:
+		ret = __cobalt_vdso_gettime(CLOCK_REALTIME, tp);
+		break;
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		ret = __cobalt_vdso_gettime(clock_id, tp);
+		break;
+	default:
+		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+	}
+
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	return 0;
+}
+
 /**
  * Read the specified clock.
  *
@@ -180,63 +239,43 @@ static int __do_clock_host_realtime(struct timespec *ts)
  */
 COBALT_IMPL(int, clock_gettime, (clockid_t clock_id, struct timespec *tp))
 {
-	unsigned long rem;
-	xnticks_t ns;
-	int ret;
+	if (cobalt_use_legacy_tsc())
+		return gettime_via_tsc(clock_id, tp);
 
-	switch (clock_id) {
-	case CLOCK_HOST_REALTIME:
-		ret = __do_clock_host_realtime(tp);
-		break;
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-		ns = cobalt_ticks_to_ns(cobalt_read_tsc());
-		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
-		tp->tv_nsec = rem;
-		return 0;
-	case CLOCK_REALTIME:
-		ns = cobalt_ticks_to_ns(cobalt_read_tsc());
-		ns += cobalt_vdso->wallclock_offset;
-		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
-		tp->tv_nsec = rem;
-		return 0;
-	default:
-		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
-	}
-
-	if (ret) {
-		errno = ret;
-		return -1;
-	}
-
-	return 0;
+	return gettime_via_vdso(clock_id, tp);
 }
 
 /**
  * Set the specified clock.
  *
- * This allow setting the CLOCK_REALTIME clock.
+ * Set the CLOCK_REALTIME or Cobalt-specific clocks.
  *
- * @param clock_id the id of the clock to be set, only CLOCK_REALTIME is
- * supported.
+ * @param clock_id the id of the clock to be set. CLOCK_REALTIME,
+ * and Cobalt-specific clocks are supported.
  *
  * @param tp the address of a struct timespec specifying the new date.
  *
  * @retval 0 on success;
  * @retval -1 with @a errno set if:
- * - EINVAL, @a clock_id is not CLOCK_REALTIME;
+ * - EINVAL, @a clock_id is undefined;
  * - EINVAL, the date specified by @a tp is invalid.
  *
  * @see
  * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_settime.html">
  * Specification.</a>
  *
- * @apitags{unrestricted}
+ * @note Setting CLOCK_REALTIME may cause the caller to switch to
+ * secondary mode.
+ *
+ * @apitags{unrestricted, switch-secondary}
  */
 COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
 {
 	int ret;
 
+	if (clock_id == CLOCK_REALTIME && !cobalt_use_legacy_tsc())
+		return __STD(clock_settime(CLOCK_REALTIME, tp));
+
 	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
 	if (ret) {
 		errno = ret;
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index 4d81b70c2e..acb3989f1b 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -20,6 +20,7 @@
 
 #include <limits.h>
 #include <stdbool.h>
+#include <time.h>
 #include <boilerplate/ancillaries.h>
 #include <cobalt/sys/cobalt.h>
 #include "current.h"
@@ -87,6 +88,8 @@ int cobalt_xlate_schedparam(int policy,
 			    struct sched_param *param);
 int cobalt_init(void);
 
+void *cobalt_lookup_vdso(const char *version, const char *name);
+
 extern struct sigaction __cobalt_orig_sigdebug;
 
 extern int __cobalt_std_fifo_minpri,
@@ -95,6 +98,9 @@ extern int __cobalt_std_fifo_minpri,
 extern int __cobalt_std_rr_minpri,
 	   __cobalt_std_rr_maxpri;
 
+extern int (*__cobalt_vdso_gettime)(clockid_t clk_id,
+				    struct timespec *tp);
+
 extern unsigned int cobalt_features;
 
 struct cobalt_featinfo;
diff --git a/lib/cobalt/parse_vdso.c b/lib/cobalt/parse_vdso.c
new file mode 100644
index 0000000000..339e4d5645
--- /dev/null
+++ b/lib/cobalt/parse_vdso.c
@@ -0,0 +1,281 @@
+/*
+ * parse_vdso.c: Linux reference vDSO parser
+ * Written by Andrew Lutomirski, 2011-2014.
+ *
+ * This code is meant to be linked in to various programs that run on Linux.
+ * As such, it is available with as few restrictions as possible.  This file
+ * is licensed under the Creative Commons Zero License, version 1.0,
+ * available at http://creativecommons.org/publicdomain/zero/1.0/legalcode
+ *
+ * The vDSO is a regular ELF DSO that the kernel maps into user space when
+ * it starts a program.  It works equally well in statically and dynamically
+ * linked binaries.
+ *
+ * This code is tested on x86.  In principle it should work on any
+ * architecture that has a vDSO.
+ */
+
+#include <sys/types.h>
+#include <sys/auxv.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <limits.h>
+#include <pthread.h>
+#include <error.h>
+#include <errno.h>
+#include <elf.h>
+#include "internal.h"
+
+/*
+ * To use this vDSO parser, first call one of the vdso_init_* functions.
+ * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
+ * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
+ * Then call lookup_vdso for each symbol you want.  For example, to look up
+ * gettimeofday on x86_64, use:
+ *
+ *     <some pointer> = lookup_vdso("LINUX_2.6", "gettimeofday");
+ * or
+ *     <some pointer> = lookup_vdso("LINUX_2.6", "__vdso_gettimeofday");
+ *
+ * lookup_vdso will return 0 if the symbol doesn't exist or if the init function
+ * failed or was not called.  lookup_vdso is a little slow, so its return value
+ * should be cached.
+ *
+ * lookup_vdso is threadsafe; the init functions are not.
+ */
+
+
+/* And here's the code. */
+#ifndef ELF_BITS
+# if ULONG_MAX > 0xffffffffUL
+#  define ELF_BITS 64
+# else
+#  define ELF_BITS 32
+# endif
+#endif
+
+#define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
+#define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
+#define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
+
+static struct vdso_info
+{
+	bool valid;
+
+	/* Load information */
+	uintptr_t load_addr;
+	uintptr_t load_offset;  /* load_addr - recorded vaddr */
+
+	/* Symbol table */
+	ELF(Sym) *symtab;
+	const char *symstrings;
+	ELF(Word) *bucket, *chain;
+	ELF(Word) nbucket, nchain;
+
+	/* Version table */
+	ELF(Versym) *versym;
+	ELF(Verdef) *verdef;
+} vdso_info;
+
+/* Straight from the ELF specification. */
+static unsigned long elf_hash(const char *name)
+{
+	unsigned long h = 0, g;
+	while (*name)
+	{
+		h = (h << 4) + *name++;
+		if ((g = h & 0xf0000000))
+			h ^= g >> 24;
+		h &= ~g;
+	}
+	return h;
+}
+
+static void vdso_init_from_sysinfo_ehdr(uintptr_t base)
+{
+	size_t i;
+	bool found_vaddr = false;
+
+	vdso_info.valid = false;
+
+	vdso_info.load_addr = base;
+
+	ELF(Ehdr) *hdr = (ELF(Ehdr)*)base;
+	if (hdr->e_ident[EI_CLASS] !=
+	    (ELF_BITS == 32 ? ELFCLASS32 : ELFCLASS64)) {
+		return;  /* Wrong ELF class -- check ELF_BITS */
+	}
+
+	ELF(Phdr) *pt = (ELF(Phdr)*)(vdso_info.load_addr + hdr->e_phoff);
+	ELF(Dyn) *dyn = 0;
+
+	/*
+	 * We need two things from the segment table: the load offset
+	 * and the dynamic table.
+	 */
+	for (i = 0; i < hdr->e_phnum; i++)
+	{
+		if (pt[i].p_type == PT_LOAD && !found_vaddr) {
+			found_vaddr = true;
+			vdso_info.load_offset =	base
+				+ (uintptr_t)pt[i].p_offset
+				- (uintptr_t)pt[i].p_vaddr;
+		} else if (pt[i].p_type == PT_DYNAMIC) {
+			dyn = (ELF(Dyn)*)(base + pt[i].p_offset);
+		}
+	}
+
+	if (!found_vaddr || !dyn)
+		return;  /* Failed */
+
+	/*
+	 * Fish out the useful bits of the dynamic table.
+	 */
+	ELF(Word) *hash = 0;
+	vdso_info.symstrings = 0;
+	vdso_info.symtab = 0;
+	vdso_info.versym = 0;
+	vdso_info.verdef = 0;
+	for (i = 0; dyn[i].d_tag != DT_NULL; i++) {
+		switch (dyn[i].d_tag) {
+		case DT_STRTAB:
+			vdso_info.symstrings = (const char *)
+				((uintptr_t)dyn[i].d_un.d_ptr
+				 + vdso_info.load_offset);
+			break;
+		case DT_SYMTAB:
+			vdso_info.symtab = (ELF(Sym) *)
+				((uintptr_t)dyn[i].d_un.d_ptr
+				 + vdso_info.load_offset);
+			break;
+		case DT_HASH:
+			hash = (ELF(Word) *)
+				((uintptr_t)dyn[i].d_un.d_ptr
+				 + vdso_info.load_offset);
+			break;
+		case DT_VERSYM:
+			vdso_info.versym = (ELF(Versym) *)
+				((uintptr_t)dyn[i].d_un.d_ptr
+				 + vdso_info.load_offset);
+			break;
+		case DT_VERDEF:
+			vdso_info.verdef = (ELF(Verdef) *)
+				((uintptr_t)dyn[i].d_un.d_ptr
+				 + vdso_info.load_offset);
+			break;
+		}
+	}
+	if (!vdso_info.symstrings || !vdso_info.symtab || !hash)
+		return;  /* Failed */
+
+	if (!vdso_info.verdef)
+		vdso_info.versym = 0;
+
+	/* Parse the hash table header. */
+	vdso_info.nbucket = hash[0];
+	vdso_info.nchain = hash[1];
+	vdso_info.bucket = &hash[2];
+	vdso_info.chain = &hash[vdso_info.nbucket + 2];
+
+	/* That's all we need. */
+	vdso_info.valid = true;
+}
+
+static bool vdso_match_version(ELF(Versym) ver,
+			       const char *name, ELF(Word) hash)
+{
+	/*
+	 * This is a helper function to check if the version indexed by
+	 * ver matches name (which hashes to hash).
+	 *
+	 * The version definition table is a mess, and I don't know how
+	 * to do this in better than linear time without allocating memory
+	 * to build an index.  I also don't know why the table has
+	 * variable size entries in the first place.
+	 *
+	 * For added fun, I can't find a comprehensible specification of how
+	 * to parse all the weird flags in the table.
+	 *
+	 * So I just parse the whole table every time.
+	 */
+
+	/* First step: find the version definition */
+	ver &= 0x7fff;  /* Apparently bit 15 means "hidden" */
+	ELF(Verdef) *def = vdso_info.verdef;
+	while(true) {
+		if ((def->vd_flags & VER_FLG_BASE) == 0
+		    && (def->vd_ndx & 0x7fff) == ver)
+			break;
+
+		if (def->vd_next == 0)
+			return false;  /* No definition. */
+
+		def = (ELF(Verdef) *)((char *)def + def->vd_next);
+	}
+
+	/* Now figure out whether it matches. */
+	ELF(Verdaux) *aux = (ELF(Verdaux)*)((char *)def + def->vd_aux);
+	return def->vd_hash == hash
+		&& !strcmp(name, vdso_info.symstrings + aux->vda_name);
+}
+
+static void *lookup_vdso(const char *version, const char *name)
+{
+	unsigned long ver_hash;
+
+	if (!vdso_info.valid)
+		return 0;
+
+	ver_hash = elf_hash(version);
+	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+
+	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
+		ELF(Sym) *sym = &vdso_info.symtab[chain];
+
+		/* Check for a defined global or weak function w/ right name. */
+		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
+			continue;
+		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
+		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
+			continue;
+		if (sym->st_shndx == SHN_UNDEF)
+			continue;
+		if (strcmp(name, vdso_info.symstrings + sym->st_name))
+			continue;
+
+		/* Check symbol version. */
+		if (vdso_info.versym
+		    && !vdso_match_version(vdso_info.versym[chain],
+					   version, ver_hash))
+			continue;
+
+		return (void *)(vdso_info.load_offset + sym->st_value);
+	}
+
+	return 0;
+}
+
+static void parse_vdso(void)
+{
+	uintptr_t vdso = (uintptr_t)getauxval(AT_SYSINFO_EHDR);
+
+	if (!vdso)
+		error(1, ENOENT, "vDSO signature not found");
+
+	vdso_init_from_sysinfo_ehdr(vdso);
+}
+
+void *cobalt_lookup_vdso(const char *version, const char *name)
+{
+	static pthread_once_t parse_vdso_once = PTHREAD_ONCE_INIT;
+	void *sym;
+
+	pthread_once(&parse_vdso_once, parse_vdso);
+
+	sym = lookup_vdso(version, name);
+	if (!sym)
+		error(1, ENOENT, "%s not found in vDSO", name);
+
+	return sym;
+}
diff --git a/lib/cobalt/ticks.c b/lib/cobalt/ticks.c
index 8313258117..94e0c1b0d3 100644
--- a/lib/cobalt/ticks.c
+++ b/lib/cobalt/ticks.c
@@ -18,10 +18,23 @@
 #include <cobalt/arith.h>
 #include <cobalt/ticks.h>
 #include <asm/xenomai/tsc.h>
+#include <asm/xenomai/time.h>
 #include "internal.h"
 
 unsigned long long __cobalt_tsc_clockfreq;
 
+/*
+ * If we have no fast path via the vDSO for reading timestamps, ask
+ * the Cobalt core.
+ */
+static int gettime_fallback(clockid_t clk_id, struct timespec *tp)
+{
+	return __RT(clock_gettime(clk_id, tp));
+}
+
+int (*__cobalt_vdso_gettime)(clockid_t clk_id,
+			struct timespec *tp) = gettime_fallback;
+
 #ifdef XNARCH_HAVE_LLMULSHFT
 
 static unsigned int tsc_scale, tsc_shift;
@@ -102,14 +115,19 @@ unsigned long long cobalt_divrem_billion(unsigned long long value,
 void cobalt_ticks_init(unsigned long long freq)
 {
 	__cobalt_tsc_clockfreq = freq;
-#ifdef XNARCH_HAVE_LLMULSHFT
 	if (freq) {
+#ifdef XNARCH_HAVE_LLMULSHFT
 		xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
 #ifdef XNARCH_HAVE_NODIV_LLIMD
 		xnarch_init_u32frac(&tsc_frac, 1 << tsc_shift, tsc_scale);
 #endif
-	}
 #endif
+	} else {
+		void *vcall = cobalt_lookup_vdso(COBALT_VDSO_VERSION,
+						 COBALT_VDSO_GETTIME);
+		if (vcall)
+			__cobalt_vdso_gettime = vcall;
+	}
 #ifdef XNARCH_HAVE_NODIV_LLIMD
 	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
 #endif
-- 
2.26.2


