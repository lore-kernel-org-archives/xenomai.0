Message-ID: <57B42AB6.9090306@allwinnertech.com>
Date: Wed, 17 Aug 2016 17:13:26 +0800
From: xielinfei <xielinfei@allwinnertech.com>
MIME-Version: 1.0
References: <57B41CA5.5040103@allwinnertech.com>
In-Reply-To: <57B41CA5.5040103@allwinnertech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [help] porting I-pipe patch on linux-3.4
 ARM(cortex-a7) soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Add kernel message

---------------------------------------------------------------------------=
-------------------------
Starting kernel ...

[sun8i_fixup]: From boot, get meminfo:
Start: 0x40000000
Size: 64MB
ion_carveout reserve: 30m@0 30m@0
ion_reserve_common: ion reserve: [0x42200000, 0x44000000]!
[ 0.000000] Booting Linux on physical CPU 0
[ 0.000000] Linux version 3.4.39 (chris@a) (gcc version 4.6.3 20120201
(prerelease) (crosstool-NG linaro-1.13.1-2012.02-20120222 - Linaro GCC
2012.02) ) #256 Wed Aug 17 17:08:14 CST 2016
[ 0.000000] bootconsole [earlycon0] enabled
[ 0.000000] Memory policy: ECC disabled, Data cache writeback
[ 0.000000] On node 0 totalpages: 16384
[ 0.000000] free_area_init_node: node 0, pgdat c0660ca0, node_mem_map
c072b000
[ 0.000000] Normal zone: 128 pages used for memmap
[ 0.000000] Normal zone: 0 pages reserved
[ 0.000000] Normal zone: 16256 pages, LIFO batch:3
[ 0.000000] script_init enter!
[ 0.000000] script_init exit!
[ 0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[ 0.000000] pcpu-alloc: [0] 0
[ 0.000000] Built 1 zonelists in Zone order, mobility grouping on. Total
pages: 16256
[ 0.000000] Kernel command line: console=3DttyS0,115200 console=3Dtty0
earlyprintk root=3D/dev/mtdblock2 init=3D/init loglevel=3D8
partitions=3Dboot@mmcblk0p2:rootfs@mmcblk0p5:env@mmcblk0p6:bootlogo@mmcblk0=
p7:UDISK@mmcblk0p1
fb_base=3D0x43000000
[ 0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[ 0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[ 0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[ 0.000000] Memory: 64MB =3D 64MB total
[ 0.000000] Memory: 26816k/26816k available, 38720k reserved, 0K highmem
[ 0.000000] Virtual kernel memory layout:
[ 0.000000] vector : 0xffff0000 - 0xffff1000 ( 4 kB)
[ 0.000000] fixmap : 0xfff00000 - 0xfffe0000 ( 896 kB)
[ 0.000000] vmalloc : 0xc4800000 - 0xff000000 ( 936 MB)
[ 0.000000] lowmem : 0xc0000000 - 0xc4000000 ( 64 MB)
[ 0.000000] pkmap : 0xbfe00000 - 0xc0000000 ( 2 MB)
[ 0.000000] modules : 0xbf000000 - 0xbfe00000 ( 14 MB)
[ 0.000000] .text : 0xc0008000 - 0xc05ae000 (5784 kB)
[ 0.000000] .init : 0xc05ae000 - 0xc05d2000 ( 144 kB)
[ 0.000000] .data : 0xc05d2000 - 0xc06636c0 ( 582 kB)
[ 0.000000] .bss : 0xc06636e4 - 0xc072a6c0 ( 796 kB)
[ 0.000000] NR_IRQS:544
[ 0.000000] 532 ahb1 set parent pll_periph0d2
[ 0.000000] I-pipe, 24.000 MHz clocksource
[ 0.000000] Architected local timer running at 24.00MHz.
[ 0.000000] Switching to timer-based delay loop
[ 0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every
178956ms
[ 0.000000] Interrupt pipeline (release #4)
[ 0.000000] Console: colour dummy device 80x30
[ 0.000000] console [tty0] enabled, bootconsole disabled
---------------------------------------------------------------------------=
------------------------------------------
then system halt.



On 2016=E5=B9=B408=E6=9C=8817=E6=97=A5 16:13, xielinfei wrote:
> Hi Philippe,
>
> I try to port Xenomai-2.6.2 to ARM (cortex-a7) soc, Using:
> Linux version: linux-3.4.39
> I-pipe patch: ipipe-core-3.4.6-arm-4.patch
> Hardware: ARM (cortex-a7) single CPU
> Following the guild: Porting Xenomai dual kernel to a new ARM SoC -
> Xenomai<https://www.google.com.hk/url?sa=3Dt&rct=3Dj&q=3D&esrc=3Ds&source=
=3Dweb&cd=3D2&cad=3Drja&uact=3D8&ved=3D0ahUKEwiC5a-r8cfOAhWJRI8KHatQC_cQFgg=
mMAE&url=3Dhttps%3A%2F%2Fxenomai.org%2F2014%2F09%2Fporting-xenomai-dual-ker=
nel-to-a-new-arm-soc%2F&usg=3DAFQjCNF7_SLahZ2bEmhJokUuxzy44eH10A&sig2=3DzgL=
gf_uma3eALRUl5S9v3A&bvm=3Dbv.129759880,d.dGo>
>
> For I-pipe patch, I modified <ipipe_tsc.c> and <ipipe_tsc_asm.S> to
> add support for "IPIPE_TSC_TYPE_FREERUNNING_ARCH"
> (I have successfully running on linux-3.10 on the same ARM soc)
>
> After integrate I-pipe patch(without Xenomai), the kernel running for
> a while then halt, "__ipipe_tsc_update()" not update any more.
> I trace the code, the timer IRQ is always got by the gic controller,
> but ipipe not dispatch. the call trace is :
> __ipipe_grab_irq()--> __ipipe_dispatch_irq() --> __ipipe_sync_pipeline()
>
> static inline void __ipipe_sync_pipeline(struct ipipe_domain *top,
> unsigned int irq)
> {
> if (__ipipe_current_domain !=3D top) {
> __ipipe_do_sync_pipeline(top);
> return;
> }
> if (!test_bit(IPIPE_STALL_FLAG, &ipipe_this_cpu_context(top)->status)){
> __ipipe_sync_stage();
> }
> }
>
> While halt, the __ipipe_sync_pipeline will do nothing, if I hack it,
> force it calling "__ipipe_sync_stage"
> the kernel can goes on, but this should not be the solution.
> I don't know who set the IPIPE_STALL_FLAG, for I trace the code it
> seems to be ok,
> -------------------------------------------------------------------------=
------------------
> fun:ipipe_unstall_root,clear
> fun:__ipipe_dispatch_irq, line=3D1279, control=3D1, name =3DLinux
> fun:__ipipe_dispatch_irq, line=3D1285
> fun:__ipipe_spin_lock_irqsave,test and set
> fun:__ipipe_spin_unlock_irqrestore,clear
> fun:__ipipe_dispatch_irq, line=3D1319
> fun:__ipipe_spin_lock_irqsave,test and set
> fun:ipipe_unstall_root,clear
> fun:ipipe_unstall_root,clear
> fun:ipipe_unstall_root,clear
> fun:__ipipe_dispatch_irq, line=3D1279, control=3D1, name =3DLinux
> fun:__ipipe_dispatch_irq, line=3D1285
> fun:__ipipe_spin_lock_irqsave,test and set
> fun:__ipipe_spin_unlock_irqrestore,clear
> fun:__ipipe_dispatch_irq, line=3D1319
> fun:__ipipe_spin_lock_irqsave,test and set
> fun:ipipe_unstall_root,clear
> fun:ipipe_unstall_root,clear
> fun:ipipe_unstall_root,clear
> -------------------------------------------------------------------------=
-----------------
>
> Looking forward to get some suggestion! thank you!
>
>
>
>
>
>
>
>
>
>
> NOTICE: This e-mail and any included attachments are intended only for
> the sole use of named and intended recipient (s) only. If you are the
> named and intended recipient, please note that the information
> contained in this email and its embedded files are confidential and
> privileged. If you are neither the intended nor named recipient, you
> are hereby notified that any unauthorized review, use, disclosure,
> dissemination, distribution, or copying of this communication, or any
> of its contents, is strictly prohibited. Please reply to the sender
> and destroy the original message and all your records of this message
> (whether electronic or otherwise). Furthermore, you should not
> disclose to any other person, use, copy or disseminate the contents of
> this e-mail and/or the documents accompanying it.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> .
>

--

Best regards=EF=BC=81
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
=E8=B0=A2=E6=9E=97=E8=8F=B2
=E7=8F=A0=E6=B5=B7=E5=85=A8=E5=BF=97=E7=A7=91=E6=8A=80=E8=82=A1=E4=BB=BD=E6=
=9C=89=E9=99=90=E5=85=AC=E5=8F=B8     BU1-PSW
=E5=9C=B0=E5=9D=80=EF=BC=9A=E5=B9=BF=E4=B8=9C=E7=9C=81=E7=8F=A0=E6=B5=B7=E5=
=B8=82=E9=AB=98=E6=96=B0=E5=8C=BA=E5=94=90=E5=AE=B6=E6=B9=BE=E9=95=87=E7=A7=
=91=E6=8A=802=E8=B7=AF9=E5=8F=B7
=E9=82=AE=E7=BC=96=EF=BC=9A519000
TEL=EF=BC=9A15018321890
=E5=85=AC=E5=8F=B8=E7=BD=91=E5=9D=80=EF=BC=9A http://www.allwinnertech.com

NOTICE: This e-mail and any included attachments are intended only for the =
sole use of named and intended recipient (s) only. If you are the named and=
 intended recipient, please note that the information contained in this ema=
il and its embedded files are confidential and privileged. If you are neith=
er the intended nor named recipient, you are hereby notified that any unaut=
horized review, use, disclosure, dissemination, distribution, or copying of=
 this communication, or any of its contents, is strictly prohibited. Please=
 reply to the sender and destroy the original message and all your records =
of this message (whether electronic or otherwise). Furthermore, you should =
not disclose to any other person, use, copy or disseminate the contents of =
this e-mail and/or the documents accompanying it.

