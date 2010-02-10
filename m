From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Wed, 10 Feb 2010 13:11:42 -0500
Message-ID: <245373446233674495BCA5CA2FC1EB173713B4D0CD@RCexchangeSVR1.ruggedcom.local>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Kernel oops when reading /proc/xenomai/stats
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I consistently get a Kernel oops when I do a 'cat /proc/xenomai/stats' afte=
r killing the Xenomai user-space application which registers for several in=
terrupts.

It's definitely Xenomai related as we are trying to allocate -784bytes of m=
emory (~4GBytes) in nucleus/module.c:stat_seq_open() and we just hv 512MByt=
es :)

It seems that xnintr_count gets decremented twice when killing the applicat=
ion. The application itself doesn't delete the RT_INTR. We rely on the clea=
nup which
is done by the xenomai library (?) before exiting the application.

Best regards,
Andreas


That's the kernel oops with additional debugging info (starts with 'HUHU' -=
 see code below the oops):

HUHU count=3D1 xnintr_count=3D-12
HUHU stat_seq_open: size=3D-784 count=3D-11
------------[ cut here ]------------
Badness at c007f28c [verbose debug info unavailable]
NIP: c007f28c LR: c007ef4c CTR: 00000014
REGS: db309c70 TRAP: 0700   Not tainted  (2.6.32-trunk-8360e)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24002444  XER: 00000000
TASK =3D db3cc860[3414] 'cat' THREAD: db308000
GPR00: 00000001 db309d20 db3cc860 00000000 00000001 00000000 db309ca8 00000=
041=20
GPR08: 00000041 c0440000 00019ce4 00000000 24002448 1001cb7c 100042bc 100df=
49c=20
GPR16: 00000002 c0380000 c0438434 c0440000 10014b50 db3b8380 000240d0 c0438=
d2c=20
GPR24: 00000000 00000014 00000000 00000000 00000001 00000010 c0438d28 00004=
0d0=20
NIP [c007f28c] __alloc_pages_nodemask+0x418/0x4ac
LR [c007ef4c] __alloc_pages_nodemask+0xd8/0x4ac
Call Trace:
[db309d20] [c007ef4c] __alloc_pages_nodemask+0xd8/0x4ac (unreliable)
[db309d90] [c007f33c] __get_free_pages+0x1c/0x4c
[db309da0] [c00a57bc] __kmalloc+0xfc/0x11c
[db309dc0] [c0068d6c] stat_seq_open+0xf8/0x448
[db309e20] [c00ebf14] proc_reg_open+0x74/0x100
[db309e40] [c00a7e24] __dentry_open+0xd0/0x280
[db309e60] [c00b65dc] do_filp_open+0x250/0x874
[db309f10] [c00a7c60] do_sys_open+0x64/0x130
[db309f40] [c0013eec] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff508a8
    LR =3D 0xff50848
Instruction dump:
419dfdb8 8011000c 540b016f 40a2fdac 61d30050 4bfffda4 73e00200 4082fd00=20
3d20c044 8009261c 7c000034 5400d97e <0f000000> 2f800000 419efce4 38000001=20

Message from syslogd@domain.hid at Wed Feb 10 13:02:26 2010 ...
ruggedcom kernel: ------------[ cut here ]------------
cat: /proc/xenomai/stat: Cannot allocate memory



diff -ruN   ../../../linux-2.6.30-8RR11/kernel/xenomai/nucleus/module.c nuc=
leus/module.c
--- ../../../linux-2.6.30-8RR11/kernel/xenomai/nucleus/module.c	2009-12-08 =
18:30:05.000000000 -0500
+++ nucleus/module.c	2010-02-10 12:58:23.000000000 -0500
@@ -348,7 +348,7 @@
 	struct seq_file *seq;
 	xnholder_t *holder;
 	struct stat_seq_info *stat_info;
-	int err, count, thrq_rev, intr_rev, irq;
+	int err, count, thrq_rev, intr_rev, irq, size;
 	spl_t s;
=20
 	if (!xnpod_active_p())
@@ -373,15 +373,20 @@
 	 * fact later.  Should xnintr_list_rev change later,
 	 * xnintr_query() will trigger an appropriate error below. */
=20
+	printk("HUHU count=3D%d xnintr_count=3D%d\n", count, xnintr_count);
+
 	intr_rev =3D xnintr_list_rev;
 	xnarch_memory_barrier();
 	count +=3D xnintr_count * RTHAL_NR_CPUS;
=20
 	if (iter)
 		kfree(iter);
-	iter =3D kmalloc(sizeof(*iter)
-		       + (count - 1) * sizeof(struct stat_seq_info),
-		       GFP_KERNEL);
+
+	size =3D sizeof(*iter) + (count - 1) * sizeof(struct stat_seq_info);
+	printk("HUHU stat_seq_open: size=3D%d count=3D%d\n", size, count);
+
+	iter =3D kmalloc(size, GFP_KERNEL);
+
 	if (!iter)
 		return -ENOMEM;

