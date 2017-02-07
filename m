From: Michael Thalmeier <michael.thalmeier@hale.at>
Date: Tue,  7 Feb 2017 08:19:38 +0100
Message-Id: <20170207071938.17419-1-michael.thalmeier@hale.at>
Subject: [Xenomai] FCSE not working correctly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: michael@thalmeier.at

Hi,
I am currently working on porting the FCSE patch to kernel 4.9 for our
custom i.MX28 based board. While investigating a kernel segfault I digged
deeper into this patchset and also re-tested our currently working 3.12
kernel (with FCSE).
What I found, left me wondering if the FCSE patchset was correctly working
since the beginning. Here follow my findings:

To make the findings reproducible I used the ipipe-3.18 branch from the
xenomai ipipe repository.

root@target:~# uname -a
Linux target 3.18.20-00004-gdddadac #5 PREEMPT Mon Feb 6 15:58:35 CET 2017
armv5tejl GNU/Linux

When looking at the memory mapping of processes, one can see, that with
FCSE enabled e.g. shared library mappings are allocated after the stack
that is positioned up to 0x02000000 (32MB). As the FCSE code looks if
virtual addresses above 32MB are used, it needs to flag each process to
exceed the 32MB memory limit and either disallow memory allocation (in
GUARANTEED mode) or put the process in group 0 where more memory is allowed
(BEST EFFORT mode).

root@target:~# cat /proc/self/maps
00008000-00076000 r-xp 00000000 00:0b 4605        /bin/busybox.nosuid
00076000-00077000 rwxp 0006d000 00:0b 4605        /bin/busybox.nosuid
00077000-0007a000 rwxp 00000000 00:00 0           [heap]
01efb000-01efd000 rwxp 00000000 00:00 0
01fdf000-02000000 rw-p 00000000 00:00 0           [stack]
02000000-0201f000 r-xp 00000000 00:0b 4357        /lib/ld-2.21.so
0201f000-02020000 r-xp 00000000 00:00 0           [sigpage]
02026000-02027000 r-xp 0001e000 00:0b 4357        /lib/ld-2.21.so
02027000-02028000 rwxp 0001f000 00:0b 4357        /lib/ld-2.21.so
02028000-0202f000 r-xp 00000000 00:0b 4331        /lib/libcrypt-2.21.so
0202f000-02036000 ---p 00007000 00:0b 4331        /lib/libcrypt-2.21.so
02036000-02037000 r-xp 00006000 00:0b 4331        /lib/libcrypt-2.21.so
02037000-02038000 rwxp 00007000 00:0b 4331        /lib/libcrypt-2.21.so
02038000-0205f000 rwxp 00000000 00:00 0
0205f000-0218f000 r-xp 00000000 00:0b 4340        /lib/libc-2.21.so
0218f000-02196000 ---p 00130000 00:0b 4340        /lib/libc-2.21.so
02196000-02198000 r-xp 0012f000 00:0b 4340        /lib/libc-2.21.so
02198000-0219a000 rwxp 00131000 00:0b 4340        /lib/libc-2.21.so
0219a000-0219c000 rwxp 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0           [vectors]

As the kernel normally uses address space randomization, this behaviour may
not be immediately visible when not running with norandmaps cmdline option
to disable address space randomization.

I think that the root cause for this behaviour is in arch/arm/mm/mmap.c in
the function arch_get_unmapped_area_topdown. When the addr0 parameter is
set without the MAP_FIXED flag, for every allocation where it cannot find
an existing vma, the block that fills the info structure and gets a new
unmapped area via vm_unmapped_area is skipped with the goto found_addr.

With the below patch I have changed this logic to only trigger when a
vma is found. This way for me it seems to fix this behaviour.
Here is the memory layout of the same kernel (ipipe-3.18) with the patch
applied:

root@target:~# cat /proc/self/maps
00008000-00076000 r-xp 00000000 00:0b 4605        /bin/busybox.nosuid
00076000-00077000 rwxp 0006d000 00:0b 4605        /bin/busybox.nosuid
00077000-0007a000 rwxp 00000000 00:00 0           [heap]
01d64000-01e94000 r-xp 00000000 00:0b 4340        /lib/libc-2.21.so
01e94000-01e9b000 ---p 00130000 00:0b 4340        /lib/libc-2.21.so
01e9b000-01e9d000 r-xp 0012f000 00:0b 4340        /lib/libc-2.21.so
01e9d000-01e9f000 rwxp 00131000 00:0b 4340        /lib/libc-2.21.so
01e9f000-01ea1000 rwxp 00000000 00:00 0
01ea1000-01ea8000 r-xp 00000000 00:0b 4331        /lib/libcrypt-2.21.so
01ea8000-01eaf000 ---p 00007000 00:0b 4331        /lib/libcrypt-2.21.so
01eaf000-01eb0000 r-xp 00006000 00:0b 4331        /lib/libcrypt-2.21.so
01eb0000-01eb1000 rwxp 00007000 00:0b 4331        /lib/libcrypt-2.21.so
01eb1000-01ed8000 rwxp 00000000 00:00 0
01ed8000-01ef7000 r-xp 00000000 00:0b 4357        /lib/ld-2.21.so
01ef8000-01efa000 rwxp 00000000 00:00 0
01efd000-01efe000 r-xp 00000000 00:00 0           [sigpage]
01efe000-01eff000 r-xp 0001e000 00:0b 4357        /lib/ld-2.21.so
01eff000-01f00000 rwxp 0001f000 00:0b 4357        /lib/ld-2.21.so
01fdf000-02000000 rw-p 00000000 00:00 0           [stack]
ffff0000-ffff1000 r-xp 00000000 00:00 0           [vectors]

It would be helpful if someone could provide some guidance if this patch
looks good and how to further verify that everything still works.

Thanks in advance,
Michael

---
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index ababa17..4ce4dbb 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -154,7 +154,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
                        addr = PAGE_ALIGN(addr);
                vma = find_vma(mm, addr);
                if (TASK_SIZE - len > addr &&
-                               (!vma || addr + len <= vma->vm_start))
+                               (vma && addr + len <= vma->vm_start))
                        goto found_addr;
        }

