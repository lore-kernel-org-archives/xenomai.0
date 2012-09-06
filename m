MIME-Version: 1.0
In-Reply-To: <50485E80.6050800@xenomai.org>
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>
	<5022B5E4.7040101@xenomai.org>
	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>
	<50339840.1070202@xenomai.org>
	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
	<504503DC.4040908@xenomai.org>
	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>
	<50453DCE.5020601@xenomai.org>
	<CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>
	<50485E80.6050800@xenomai.org>
Date: Thu, 6 Sep 2012 15:31:09 +0200
Message-ID: <CAHue_TX6R8i_8HSNNeBi-JLBv4MGMjtQH6JxGvgj5xqWzU3kkQ@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>
> Like what, no kernel message ?
>

Sory it must have been pasted wrong:

/usr/xenomai/bin # ./xeno-test -l "dohell -s 10.76.16.117 -m /mnt" -t 2
Started child 461: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper
./xeno-test -t 2
+ echo 0
+ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 0.000 ns, rejected 9999/10000
inlined llimd: 0x79364d9364d9362f: 3979.800 ns, rejected 4/10000
inlined llmulshft: 0x79364d92ffffffe1: 750.000 ns, rejected 9996/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 500.000 ns, rejected 9998/10000
out of line calibration: 0x0000000000000000: 800.000 ns, rejected 9995/1000=
0
out of line llimd: 0x79364d9364d9362f: 3180.200 ns, rejected 4/10000
out of line llmulshft: 0x79364d92ffffffe1: -300.000 ns, rejected 9998/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 33.300 ns, rejected 9994/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 750.000 ns, rejected 9996/10000
inlined llimd: 0x86c9b26c9b26c9d1: 3253.600 ns, rejected 5/10000
inlined llmulshft: 0x86c9b26d0000001e: -250.000 ns, rejected 9998/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: -250.000 ns, rejected 9998/10000
out of line calibration: 0x0000000000000000: 800.000 ns, rejected 9995/1000=
0
out of line llimd: 0x86c9b26c9b26c9d1: 3203.300 ns, rejected 4/10000
out of line llmulshft: 0x86c9b26d0000001e: -800.000 ns, rejected 9999/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 33.300 ns, rejected 9994/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 666.600 ns, rejected 9997/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 133.400 ns, rejected 9995/10000
out of line calibration: 0x0000000000000000: 500.000 ns, rejected 9998/1000=
0
out of line nodiv_ullimd: 0x79364d9364d9362f: 0.000 ns, rejected 9998/10000
+ /usr/xenomai/bin/clocktest -C 42 -T 30
=3D=3D Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  2.0            0.000          0            0.0
  1                  2.0            0.000          0            0.0
  2                  2.0            0.000          0            0.0
  3                  2.0            0.000          0            0.0
+ /usr/xenomai/bin/switchtest -T 30
=3D=3D Testing FPU check routines...
d0: 1 !=3D 2
d1: 1 !=3D 2
d2: 1 !=3D 2
d3: 1 !=3D 2
d4: 1 !=3D 2
d5: 1 !=3D 2
d6: 1 !=3D 2
d7: 1 !=3D 2
d8: 1 !=3D 2
d9: 1 !=3D 2
d10: 1 !=3D 2
d11: 1 !=3D 2
d12: 1 !=3D 2
d13: 1 !=3D 2
d14: 1 !=3D 2
d15: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9

Another test with no parameters

/usr/xenomai/bin # ./xeno-test
Started child 467: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper
./xeno-test
+ echo 0
+ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 500.000 ns, rejected 9998/10000
inlined llimd: 0x79364d9364d9362f: 3478.500 ns, rejected 6/10000
inlined llmulshft: 0x79364d92ffffffe1: 333.300 ns, rejected 9994/10000
inlined nodiv_llimd: 0x79364d9364d9362f: -500.000 ns, rejected 9999/10000
out of line calibration: 0x0000000000000000: 800.000 ns, rejected 9995/1000=
0
out of line llimd: 0x79364d9364d9362f: 3180.500 ns, rejected 5/10000
out of line llmulshft: 0x79364d92ffffffe1: -133.400 ns, rejected 9997/10000
out of line nodiv_llimd: 0x79364d9364d9362f: -300.000 ns, rejected
9998/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 0.000 ns, rejected 9999/10000
inlined llimd: 0x86c9b26c9b26c9d1: 4000.600 ns, rejected 3/10000
inlined llmulshft: 0x86c9b26d0000001e: 666.600 ns, rejected 9997/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 800.000 ns, rejected 9995/10000
out of line calibration: 0x0000000000000000: 500.000 ns, rejected 9998/1000=
0
out of line llimd: 0x86c9b26c9b26c9d1: 3510.400 ns, rejected 1/10000
out of line llmulshft: 0x86c9b26d0000001e: 250.000 ns, rejected 9996/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 166.600 ns, rejected 9997/1000=
0

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 500.000 ns, rejected 9998/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 0.000 ns, rejected 9998/10000
out of line calibration: 0x0000000000000000: 666.600 ns, rejected 9997/1000=
0
out of line nodiv_ullimd: 0x79364d9364d9362f: -166.600 ns, rejected
9998/10000
+ /usr/xenomai/bin/clocktest -C 42 -T 30
=3D=3D Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  2.0            0.000          0            0.0
  1                  2.0            0.000          0            0.0
  2                  2.0            0.000          0            0.0
  3                  2.0            0.000          0            0.0
+ /usr/xenomai/bin/switchtest -T 30
=3D=3D Testing FPU check routines...
d0: 1 !=3D 2
d1Xenomai: suspending kernel thread c9502128 ('rtk4/0') at 0xc00672ac after
exception #0x0
: 1 !=3D 2
d2: 1 !=3D 2
d3: 1 !=3D 2
d4: 1 !=3D 2
d5: 1 !=3D 2
d6: 1 !=3D 2
d7: 1 !=3D 2
d8: 1 !=3D 2
d9: 1 !=3D 2
d10: 1 !=3D 2
d11: 1 !=3D 2
d12: 1 !=3D 2
d13: 1 !=3D 2
d14: 1 !=3D 2
d15: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21
rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4
rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10
rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16 Xenomai:
suspending kernel thread c95010c8 ('rtk2/0') at 0xc00672ac after exception
#0x0
rtuBoU_Gu:f pMAX_LOCK_DEPTH too low!
p1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21
rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3 rtk_fp2-4
rtk_fp_ufpp2-5 rtk_fp_ufpp2-6 rtup2-7 rtup2-8 rtup_ufpp2-9 rtup_ufpp2-10
rtus2-11 rtus2-12 rtus_ufps2-13 rtus_ufps2-14 rtuo2-15 rtuo2-16
rtuo_ufpp2-17 rtuo_ufpp2-18 rtuo_ufps2-19 rtuo_ufps2-20 rtuo_ufpp_ufps2-21
rtuo_ufpp_ufps2-22 sleeper_ufps3-0 rtk3-1 rtk3-2 rtk_fp3-3 rtk_fp3-4
rtk_fp_ufpp3-5 rtk_fp_ufpp3-6 rtup3-7 rtup3-8 rtup_ufpp3-9 rtup_ufpp3-10
rtus3-11 rtus3-12 rtus_ufps3-13 rtus_ufps3-14 rtuo3-15 rtuo3-16
rtuo_ufpp3-17 rtuo_ufpp3-18 rtuo_ufps3-19 rtuo_ufps3-20 rtuo_ufpp_ufps3-21
rtuo_ufpp_ufps3-22
turning off the locking correctness validator.
[<c001568c>] (unwind_backtrace+0x0/0x104) from [<c042ac84>]
(dump_stack+0x20/0x24)
[<c042ac84>] (dump_stack+0x20/0x24) from [<c006aa58>]
(__lock_acquire+0x139c/0x1a9c)
[<c006aa58>] (__lock_acquire+0x139c/0x1a9c) from [<c006b69c>]
(lock_acquire+0x9c/0x124)
[<c006b69c>] (lock_acquire+0x9c/0x124) from [<c0432dc4>]
(_raw_spin_lock+0x3c/0x4c)
[<c0432dc4>] (_raw_spin_lock+0x3c/0x4c) from [<c0031f68>]
(vprintk+0x78/0x540)
[<c0031f68>] (vprintk+0x78/0x540) from [<c042b384>] (printk+0x194/0x268)
[<c042b384>] (printk+0x194/0x268) from [<c042ae70>]
(__do_kernel_fault.part.4+0x48/0x84)
[<c042ae70>] (__do_kernel_fault.part.4+0x48/0x84) from [<c001b1a0>]
(do_page_fault.part.5+0x310/0x378)
[<c001b1a0>] (do_page_fault.part.5+0x310/0x378) from [<c001b24c>]
(do_page_fault+0x44/0x4c)
[<c001b24c>] (do_page_fault+0x44/0x4c) from [<c0008600>]
(do_DataAbort+0x44/0x108)
[<c0008600>] (do_DataAbort+0x44/0x108) from [<c000e61c>]
(__dabt_svc+0x3c/0x60)

Another one:

/usr/xenomai/bin # ./xeno-test -l "dohell -s 10.76.16.117" -t 2
Started child 460: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper
./xeno-test -t 2
+ echo 0
+ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 800.000 ns, rejected 9995/10000
inlined llimd: 0x79364d9364d9362f: 3182.900 ns, rejected 18/10000
inlined llmulshft: 0x79364d92ffffffe1: -300.000 ns, rejected 9998/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 33.300 ns, rejected 9994/10000
out of line calibration: 0x0000000000000000: 500.000 ns, rejected 9998/1000=
0
out of line llimd: 0x79364d9364d9362f: 3480.800 ns, rejected 10/10000
out of line llmulshft: 0x79364d92ffffffe1: 250.000 ns, rejected 9996/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 166.600 ns, rejected 9997/1000=
0

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 0.000 ns, rejected 9999/10000
inlined llimd: 0x86c9b26c9b26c9d1: 4000.500 ns, rejected 22/10000
inlined llmulshft: 0x86c9b26d0000001e: 833.300 ns, rejected 9994/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 833.300 ns, rejected 9994/10000
out of line calibration: 0x0000000000000000: 500.000 ns, rejected 9998/1000=
0
out of line llimd: 0x86c9b26c9b26c9d1: 3502.100 ns, rejected 13/10000
out of line llmulshft: 0x86c9b26d0000001e: 166.600 ns, rejected 9997/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 400.000 ns, rejected 9990/1000=
0

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 500.000 ns, rejected 9998/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 0.000 ns, rejected 9998/10000
out of line calibration: 0x0000000000000000: 500.000 ns, rejected 9998/1000=
0
out of line nodiv_ullimd: 0x79364d9364d9362f: -500.000 ns, rejected
9999/10000
+ /usr/xenomai/bin/clocktest -C 42 -T 30
=3D=3D Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  2.0            0.000          0            0.0
  1                  2.0            0.000          0            0.0
  2                  2.0            0.000          0            0.0
  3                  2.0            0.000          0            0.0
+ /usr/xenomai/bin/switchtest -T 30
=3D=3D Testing FPU check routines...
d0: 1 !=3D 2
d1: 1 !=3D 2
d2: 1 !=3D 2
d3: 1 !=3D 2
d4: 1 !=3D 2
d5: 1 !=3D 2
d6: 1 !=3D 2
d7: 1 !=3D 2
d8: 1 !=3D 2
d9: 1 !=3D 2
d10: 1 !=3D 2
d11: 1 !=3D 2
d12: 1 !=3D 2
d13: 1 !=3D 2
d14: 1 !=3D 2
d15: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
rtuo_ufpp0-17 rtuo_ufpp0-Xenomai: suspending kernel thread c94f2958
('rtk5/2') at 0xc00672ac after exception #0x0
Xenomai: suspending kernel thread c9502958 ('rtk5/3') at 0xc00672ac after
exception #0x0
18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-2

I guess you should re-enable the debug
> then. And please do not forget what I asked you:
> - what of the SLAB issue?
>
>
The message was:
WARNING: at mm/slab.c:2264 kmem_cache_create+0x6a4/0x6f4()

In the slab.c:2264 line there is

#if DEBUG
WARN_ON(strchr(name, ' '));    /* It confuses parsers */

where @name: "A string which is used in /proc/slabinfo to identify this
cache." So i put debug code before that warning:

printk(KERN_ERR"kmem_cache_create: Cache name=3D  %s\n", name);

#if DEBUG
WARN_ON(strchr(name, ' '));    /* It confuses parsers */
(...)

 And the result:

JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
kmem_cache_create: Cache name=3D  jffs2_i
kmem_cache_create: Cache name=3D  jffs2_full_dnode
kmem_cache_create: Cache name=3D  jffs2_raw_dirent
kmem_cache_create: Cache name=3D  jffs2_raw_inode
kmem_cache_create: Cache name=3D  jffs2_tmp_dnode
kmem_cache_create: Cache name=3D  jffs2_refblock
kmem_cache_create: Cache name=3D  jffs2_node_frag
kmem_cache_create: Cache name=3D  jffs2_inode_cache
msgmni has been set to 482
io scheduler noop registered (default)
start plist test
end plist test
kmem_cache_create: Cache name=3D  sd_ext_cdb
smsc911x: Driver version 2008-10-21
smsc911x-mdio: probed
smsc911x smsc911x: eth0: attached PHY driver [Generic PHY]
(mii_bus:phy_addr=3Dffffffff:01, irq=3D-1)
smsc911x smsc911x: eth0: MAC Address: 00:02:f7:00:40:9c
kmem_cache_create: Cache name=3D  isp1760 urb_listitem
------------[ cut here ]------------
WARNING: at mm/slab.c:2264 kmem_cache_create+0x6dc/0x774()
Modules linked in:
[<c001568c>] (unwind_backtrace+0x0/0x104) from [<c0464464>]
(dump_stack+0x20/0x24)
[<c0464464>] (dump_stack+0x20/0x24) from [<c0031050>]
(warn_slowpath_common+0x5c/0x74)
[<c0031050>] (warn_slowpath_common+0x5c/0x74) from [<c0031094>]
(warn_slowpath_null+0x2c/0x34)
[<c0031094>] (warn_slowpath_null+0x2c/0x34) from [<c01974e4>]
(kmem_cache_create+0x6dc/0x774)
[<c01974e4>] (kmem_cache_create+0x6dc/0x774) from [<c060c2c8>]
(init_kmem_once+0x30/0xb4)
[<c060c2c8>] (init_kmem_once+0x30/0xb4) from [<c060c35c>]
(isp1760_init+0x10/0x30)
[<c060c35c>] (isp1760_init+0x10/0x30) from [<c00088b4>]
(do_one_initcall+0x48/0x190)
[<c00088b4>] (do_one_initcall+0x48/0x190) from [<c05f78f4>]
(kernel_init+0xd4/0x17c)
[<c05f78f4>] (kernel_init+0xd4/0x17c) from [<c000f8cc>]
(kernel_thread_exit+0x0/0x8)
---[ end trace b843230cdc8e6578 ]---
kmem_cache_create: Cache name=3D  isp1760_qtd
kmem_cache_create: Cache name=3D  isp1760_qh
isp1760 isp1760: NXP ISP1760 USB Host Controller
isp1760 isp1760: new USB bus registered, assigned bus number 1

So the isp1760 urb_listitem does have a space in its name and that's all
warning. That's not serious is it?

>> - what of the disassembly of the address where the fault happens?

Speaking of that faults - I'm working on printks, it will take some time.


2MHz ? Normally the clock runs at half the core frequency, your ARM core
> is running at 4MHz?
>

You're right - it runs 400MHz

Good, what about the call to gt_setup ?
>
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_Cortex_A9_cas=
e
>
> It will allow you to use the global timer as clocksource instead of the
> sp804. In order to check the tsc emulation, you can run the xenomai
> regression test named "tsc".
>


I'm not really sure about physical address of the global timer (the first
parameter of gt_setup). In mach-versatile/include/mach/platform.h file I
can find defines but using for example gt_setup(VERSATILE_WATCHDOG_BASE -
0x400,64) it ends up with a kernel panic:

CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
local timer: 200.00MHz.
I-pipe, 200.000 MHz timer
Unhandled fault: imprecise external abort (0xc06) at 0x0001f6c5
Internal error: : c06 [#1] SMP
Modules linked in:
CPU: 0    Not tainted  (3.2.21-ipipe #69)
PC is at __ipipe_tsc_register+0x0/0x280
LR is at gt_setup+0x94/0xa0
pc : [<c001978c>]    lr : [<c0461284>]    psr: 60000013
sp : cf905f70  ip : cf905eb0  fp : cf905f8c
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000001  r6 : 101e0c00  r5 : 00000040  r4 : c0679670
r3 : ffffffff  r2 : ffffffff  r1 : 00000000  r0 : c0679680
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 6000404a  DAC: 00000017
Process swapper/0 (pid: 1, stack limit =3D 0xcf9042f0)
Stack: (0xcf905f70 to 0xcf906000)
5f60:                                     00000001 c0e99060 00000004
c064b934
5f80: cf905f9c cf905f90 c0461868 c04611fc cf905fb4 cf905fa0 c046104c
c046184c
5fa0: 00000000 00000004 cf905fd4 cf905fb8 c05f97ac c0460ffc c06839c4
c063daa8
5fc0: c063dac8 cf904000 cf905ff4 cf905fd8 c05f78a4 c05f9744 00000000
c05f7820
5fe0: c000f8cc 00000013 00000000 cf905ff8 c000f8cc c05f782c aaaaaaaa
aaaaaaaa
Code: e3a00009 e5832898 eb01d0d7 e89da800 (e1a0c00d)
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Attempted to kill init!
[<c001568c>] (unwind_backtrace+0x0/0x104) from [<c04643f4>]
(dump_stack+0x20/0x24)
[<c04643f4>] (dump_stack+0x20/0x24) from [<c0464828>] (panic+0x6c/0x1a4)
[<c0464828>] (panic+0x6c/0x1a4) from [<c00356f4>] (do_exit+0x5ec/0x6fc)
[<c00356f4>] (do_exit+0x5ec/0x6fc) from [<c0012ad8>] (die+0x12c/0x1e4)
[<c0012ad8>] (die+0x12c/0x1e4) from [<c0012bb8>] (arm_notify_die+0x28/0x60)
[<c0012bb8>] (arm_notify_die+0x28/0x60) from [<c0008670>]
(do_DataAbort+0xb4/0x108)
[<c0008670>] (do_DataAbort+0xb4/0x108) from [<c000e61c>]
(__dabt_svc+0x3c/0x60)
Exception stack(0xcf905f28 to 0xcf905f70)
5f20:                   c0679680 00000000 ffffffff ffffffff c0679670
00000040
5f40: 101e0c00 00000001 00000000 00000000 00000000 cf905f8c cf905eb0
cf905f70
5f60: c0461284 c001978c 60000013 ffffffff
[<c000e61c>] (__dabt_svc+0x3c/0x60) from [<c001978c>]
(__ipipe_tsc_register+0x0/0x280)

And using 0x00 offset (or PERIPH_BASE_ADDR + 0x0200) following the
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0407f/DDI0407F_cortex_a=
9_r2p2_mpcore_trm.pdfdocument
(4.4 Global timers) results:

SMP: Total of 4 processors activated (3176.03 BogoMIPS).
I-pipe, 200.000 MHz timer
CPU3: Unknown IPI message 0x1
BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
Modules linked in:
irq event stamp: 34937
hardirqs last  enabled at (34936): [<c000e6d0>]
__ipipe_fast_svc_irq_exit+0x0/0x30
hardirqs last disabled at (34937): [<c000e674>] __irq_svc+0x34/0x90
softirqs last  enabled at (34935): [<c0038800>] __do_softirq+0x178/0x23c
softirqs last disabled at (34930): [<c0038dbc>] irq_exit+0x6c/0x74

Pid: 1, comm:            swapper/0
CPU: 0    Not tainted  (3.2.21-ipipe #68)
PC is at clocksource_enqueue+0x4c/0x70
LR is at 0x0
pc : [<c00606b8>]    lr : [<00000000>]    psr: 20000013
sp : 00000000  ip : 00000000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 6000404a  DAC: 00000017
[<c001568c>] (unwind_backtrace+0x0/0x104) from [<c04643f0>]
(dump_stack+0x20/0x24)
[<c04643f0>] (dump_stack+0x20/0x24) from [<c000ff98>] (show_regs+0x54/0x58)
[<c000ff98>] (show_regs+0x54/0x58) from [<c0083d50>]
(watchdog_timer_fn+0x1ac/0x21c)
[<c0083d50>] (watchdog_timer_fn+0x1ac/0x21c) from [<c0058270>]
(__run_hrtimer+0x84/0x1d0)
[<c0058270>] (__run_hrtimer+0x84/0x1d0) from [<c0059450>]
(hrtimer_run_queues+0xd8/0x19c)
[<c0059450>] (hrtimer_run_queues+0xd8/0x19c) from [<c004157c>]
(run_local_timers+0x18/0x24)
[<c004157c>] (run_local_timers+0x18/0x24) from [<c00415c4>]
(update_process_times+0x3c/0x6c)
[<c00415c4>] (update_process_times+0x3c/0x6c) from [<c0041650>]
(update_root_process_times+0x5c/0x60)
[<c0041650>] (update_root_process_times+0x5c/0x60) from [<c0064384>]
(tick_periodic+0x48/0xbc)
[<c0064384>] (tick_periodic+0x48/0xbc) from [<c00644c8>]
(tick_handle_periodic+0x34/0x98)
[<c00644c8>] (tick_handle_periodic+0x34/0x98) from [<c0014b94>]
(twd_handler+0x50/0x5c)
[<c0014b94>] (twd_handler+0x50/0x5c) from [<c0087630>]
(handle_percpu_devid_irq+0xa4/0x174)
[<c0087630>] (handle_percpu_devid_irq+0xa4/0x174) from [<c008423c>]
(generic_handle_irq+0x2c/0x40)
[<c008423c>] (generic_handle_irq+0x2c/0x40) from [<c000f628>]
(handle_IRQ+0x6c/0xdc)
[<c000f628>] (handle_IRQ+0x6c/0xdc) from [<c0018c10>]
(__ipipe_do_IRQ+0x40/0x48)
[<c0018c10>] (__ipipe_do_IRQ+0x40/0x48) from [<c008ec30>]
(__ipipe_dispatch_irq_fast+0x2b4/0x300)
[<c008ec30>] (__ipipe_dispatch_irq_fast+0x2b4/0x300) from [<c008ed88>]
(__ipipe_dispatch_irq+0x10c/0x388)
[<c008ed88>] (__ipipe_dispatch_irq+0x10c/0x388) from [<c0008574>]
(__ipipe_grab_irq+0xa4/0xec)
[<c0008574>] (__ipipe_grab_irq+0xa4/0xec) from [<c000e67c>]
(__irq_svc+0x3c/0x90)
Exception stack(0xcf905ee8 to 0xcf905f30)
5ee0:                   c0656100 c064feb0 c064feb0 c0656030 00000001
cf904000
5f00: 8e778000 00000006 70a3d70a a3d70a3d 00000000 cf905f44 c064feb0
cf905f30
5f20: 7fffffff c00606b8 20000013 ffffffff
[<c000e67c>] (__irq_svc+0x3c/0x90) from [<c00606b8>]
(clocksource_enqueue+0x4c/0x70)
[<c00606b8>] (clocksource_enqueue+0x4c/0x70) from [<c0060af4>]
(clocksource_register+0x98/0xfc)
[<c0060af4>] (clocksource_register+0x98/0xfc) from [<c05fe8c8>]
(init_jiffies_clocksource+0x14/0x1c)
[<c05fe8c8>] (init_jiffies_clocksource+0x14/0x1c) from [<c00088b4>]
(do_one_initcall+0x48/0x190)
[<c00088b4>] (do_one_initcall+0x48/0x190) from [<c05f78f4>]
(kernel_init+0xd4/0x17c)
[<c05f78f4>] (kernel_init+0xd4/0x17c) from [<c000f8cc>]
(kernel_thread_exit+0x0/0x8)

Probably you noticed that I managed to run all 4 cores - as it turned out
that was trivial, simply include asm/smp_twd.h in mach/irqs.h according to
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting.

--=20
Marcin Ku=B6ka
