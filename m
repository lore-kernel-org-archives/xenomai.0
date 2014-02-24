References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
 <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530A862C.1060805@xenomai.org>
Message-ID: <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
Date: Sun, 23 Feb 2014 17:11:27 -0800 (PST)
From: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
In-Reply-To: <530A862C.1060805@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] User Space Problems
Reply-To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,=0A=0AI did the changes, but the kernel is not booting. I got the=
 message from serial:=0AU-Boot 2013.01-00058-g5957f6d (Feb 11 2013 - 08:42:=
43)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =0ACPU:=A0=A0 Freescale i.MX6Q rev1.2 at 792 MHz=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =0AReset cause: POR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =0ABoard: SABRE Lite=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0ADRAM:=A0 1 GiB=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0AWARNING: Ca=
ches not enabled=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0AMMC:=A0=A0 FSL_SDHC=
: 0, FSL_SDHC: 1=A0=A0=A0=A0=A0=A0=A0=A0 =0ASF: Detected SST25VF016B with p=
age size 4 KiB, total 2 MiB=0A*** Warning - bad CRC, using default environm=
ent=0A=0Aauto-detected panel HDMI=0Aenable_hdmi: setup HDMI monitor=0ADispl=
ay: HDMI (1024x768)=0AIn:=A0=A0=A0 serial=0AOut:=A0=A0 serial=0AErr:=A0=A0 =
serial=0ANet:=A0=A0 using phy at 6=0AFEC [PRIME]=0AWarning: FEC using MAC a=
ddress from net device=0A=0AHit any key to stop autoboot:=A0 0 =0AAHCI 0001=
.0300 32 slots 1 ports 3 Gbps 0x1 impl SATA mode=0Aflags: ncq stag pm led c=
lo only pmp pio slum part =0ANo port device detected!=0A** Bad device size =
- sata 0 **=0A** Bad device size - sata 0 **=0A=0ASATA device 1: unknown de=
vice=0A** Bad device sata 1 **=0A** Bad device sata 1 **=0AMMC: no card pre=
sent=0Ammc0(part 0) is current device=0AMMC: no card present=0A** Bad devic=
e mmc 0 **=0AMMC: no card present=0A** Bad device mmc 0 **=0Ammc1 is curren=
t device=0A** Unrecognized filesystem type **=0A2627 bytes read in 30 ms (8=
5 KiB/s)=0A## Executing script at 10008000=0ASetting bus to 2=0AValid chip =
addresses:=0A------ no Freescale display=0AValid chip addresses:=0A------ n=
o ft5x06 touch controller=0AValid chip addresses:=0A------ no 800x480 displ=
ay=0A** File not found /boot/imx6q-sabrelite.dtb **=0Aonly CEA modes allowe=
d on HDMI port=0A3997932 bytes read in 378 ms (10.1 MiB/s)=0A## Booting ker=
nel from Legacy Image at 10800000 ...=0A=A0=A0 Image Name:=A0=A0 Linux-3.0.=
35-ipipe=0A=A0=A0 Image Type:=A0=A0 ARM Linux Kernel Image (uncompressed)=
=0A=A0=A0 Data Size:=A0=A0=A0 3997868 Bytes =3D 3.8 MiB=0A=A0=A0 Load Addre=
ss: 10008000=0A=A0=A0 Entry Point:=A0 10008000=0A=A0=A0 Verifying Checksum =
... OK=0A=A0=A0 Loading Kernel Image ... OK=0AOK=0A=0AStarting kernel ...=
=0A=0AUncompressing Linux... done, booting the kernel.=0ALinux version 3.0.=
35-ipipe (bruno@bruno-Inspiron-N5010) (gcc version 4.8.2 20131014 (prerelea=
se) (crosstool-NG linaro-1.13.1-4.8-2013.10 - Lina4=0ACPU: ARMv7 Processor =
[412fc09a] revision 10 (ARMv7), cr=3D10c53c7d=0ACPU: VIPT nonaliasing data =
cache, VIPT aliasing instruction cache=0AMachine: Boundary Devices Nitrogen=
6X/SABRE Lite Board=0AMemory policy: ECC disabled, Data cache writealloc=0A=
CPU identified as i.MX6Q, silicon rev 1.2=0APERCPU: Embedded 10 pages/cpu @=
8c008000 s16640 r8192 d16128 u40960=0ABuilt 1 zonelists in Zone order, mobi=
lity grouping on.=A0 Total pages: 227328=0AKernel command line: enable_wait=
_mode=3Doff video=3Dmxcfb0:dev=3Dhdmi,1280x720M@60,if=3DRGB24,bpp=3D32 vide=
o=3Dmxcfb1:off video=3Dmxcfb2:off video=3Dmxcfb3:off1=0APID hash table entr=
ies: 4096 (order: 2, 16384 bytes)=0ADentry cache hash table entries: 131072=
 (order: 7, 524288 bytes)=0AInode-cache hash table entries: 65536 (order: 6=
, 262144 bytes)=0AMemory: 640MB 256MB =3D 896MB total=0AMemory: 899816k/899=
816k available, 148760k reserved, 0K highmem=0AVirtual kernel memory layout=
:=0A=A0=A0=A0 vector=A0 : 0xffff0000 - 0xffff1000=A0=A0 (=A0=A0 4 kB)=0A=A0=
=A0=A0 fixmap=A0 : 0xfff00000 - 0xfffe0000=A0=A0 ( 896 kB)=0A=A0=A0=A0 DMA=
=A0=A0=A0=A0 : 0xf4600000 - 0xffe00000=A0=A0 ( 184 MB)=0A=A0=A0=A0 vmalloc =
: 0xc0800000 - 0xf2000000=A0=A0 ( 792 MB)=0A=A0=A0=A0 lowmem=A0 : 0x8000000=
0 - 0xc0000000=A0=A0 (1024 MB)=0A=A0=A0=A0 pkmap=A0=A0 : 0x7fe00000 - 0x800=
00000=A0=A0 (=A0=A0 2 MB)=0A=A0=A0=A0 modules : 0x7f000000 - 0x7fe00000=A0=
=A0 (=A0 14 MB)=0A=A0=A0=A0=A0=A0 .init : 0x80008000 - 0x80046000=A0=A0 ( 2=
48 kB)=0A=A0=A0=A0=A0=A0 .text : 0x80046000 - 0x8077fdec=A0=A0 (7400 kB)=0A=
=A0=A0=A0=A0=A0 .data : 0x80780000 - 0x807ddba0=A0=A0 ( 375 kB)=0A=A0=A0=A0=
=A0=A0=A0 .bss : 0x807ddbc4 - 0x8084f644=A0=A0 ( 455 kB)=0ASLUB: Genslabs=
=3D13, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1=0APre=
emptible hierarchical RCU implementation.=0ANR_IRQS:624=0AMXC GPIO hardware=
=0Asched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655ms=
=0Aarm_max_freq=3D1GHz=0AMXC_Early serial console at MMIO 0x21e8000 (option=
s '115200')=0Abootconsole [ttymxc1] enabled=0AI-pipe 1.18-13: pipeline enab=
led.=0AConsole: colour dummy device 80x30=0ACalibrating delay loop... 1581.=
05 BogoMIPS (lpj=3D7905280)=0Apid_max: default: 32768 minimum: 301=0AMount-=
cache hash table entries: 512=0ACPU: Testing write buffer coherency: ok=0AI=
-pipe, 396.000 MHz timer=0AI-pipe, 396.000 MHz clocksource=0Ahw perfevents:=
 enabled with ARMv7 Cortex-A9 PMU driver, 7 counters available=0ACPU1: Boot=
ed secondary processor=0ACPU2: Booted secondary processor=0ACPU3: Booted se=
condary processor=0ABrought up 4 CPUs=0ASMP: Total of 4 processors activate=
d (6324.22 BogoMIPS).=0Adevtmpfs: initialized=0Aprint_constraints: dummy: =
=0ANET: Registered protocol family 16=0Aprint_constraints: vddpu: 725 <--> =
1300 mV at 1150 mV fast normal =0Aprint_constraints: vddcore: 725 <--> 1300=
 mV at 1150 mV fast normal =0Aprint_constraints: vddsoc: 725 <--> 1300 mV a=
t 1200 mV fast normal =0Aprint_constraints: vdd2p5: 2000 <--> 2775 mV at 24=
00 mV fast normal =0Aprint_constraints: vdd1p1: 800 <--> 1400 mV at 1100 mV=
 fast normal =0Aprint_constraints: vdd3p0: 2625 <--> 3400 mV at 3000 mV fas=
t normal =0Alcd_disable_pins=0A------------ Board type Sabre Lite=0Aimx_add=
_mxc_pwm:pdata=3D=A0 (null)=0Aimx_add_mxc_pwm:pdata=3D=A0 (null)=0Aimx_add_=
mxc_pwm:pdata=3D807a82d0=0Aimx_add_mxc_pwm:pdata=3D=A0 (null)=0AFlexcan NXP=
 tja1040=0Ahw-breakpoint: found 6 breakpoint and 1 watchpoint registers.=0A=
hw-breakpoint: 1 breakpoint(s) reserved for watchpoint single-step.=0Ahw-br=
eakpoint: maximum watchpoint size is 4 bytes.=0AL310 cache controller enabl=
ed=0AInternal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP=0AMod=
ules linked in:=0ACPU: 1=A0=A0=A0 Not tainted=A0 (3.0.35-ipipe #6)=0APC is =
at 0xbffac2f0=0ALR is at update_process_times+0x44/0x70=0Apc : [<bffac2f0>]=
=A0=A0=A0 lr : [<8008d230>]=A0=A0=A0 psr: 00000193=0Asp : bffadef8=A0 ip : =
00000001=A0 fp : 00000000=0Ar10: bffac010=A0 r9 : 40063ff0=A0 r8 : 00000001=
=0Ar7 : 8c012040=A0 r6 : 8004496c=A0 r5 : 8079aae0=A0 r4 : 20000013=0Ar3 : =
80041838=A0 r2 : bff8e1c0=A0 r1 : 20000193=A0 r0 : 00000001=0AFlags: nzcv=
=A0 IRQs off=A0 FIQs on=A0 Mode SVC_32=A0 ISA ARM=A0 Segment kernel=0AContr=
ol: 10c53c7d=A0 Table: 1000404a=A0 DAC: 00000015=0AProcess swapper (pid: 0,=
 stack limit =3D 0xbffac2f0)=0AStack: (0xbffadef8 to 0xbffae000)=0Adee0:=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 00000001 00000001=0Adf00: 8079aae0 8004496c 00000000 00000001 807=
9aae0 8c01283c 00000000 800461e4=0Adf20: 800411b8 00000020 807ea400 807ea3e=
0 00000001 800bef80 807ea404 80056940=0Adf40: 807abea0 80041838 80044518 80=
7ea3e0 00000000 bffadf80 f2a00100 0000001d=0Adf60: 805b2cec 8079e1ec bffac0=
00 00000000 00000000 80056a8c ffffffff 8004bc00=0Adf80: 20000000 0000001d 2=
0000000 f40dc010 8c012838 bffac000 807ddc84 805b2cec=0Adfa0: 8079e1ec 412fc=
09a 00000000 00000000 00000001 bffadfc8 8005cdb4 8005b56c=0Adfc0: 20000013 =
ffffffff 805b2cec 00000001 412fc09a 8004cee0 bffac000 8004d04c=0Adfe0: 4ffb=
006a 00000015 10c03c7d 807dde38 1000406a 105a4614 00000000 00000000=0AUnabl=
e to handle kernel paging request at virtual address 00303068=0Apgd =3D 800=
04000=0A[00303068] *pgd=3D00000000=0AUnable to handle kernel NULL pointer d=
ereference at virtual address 00000000=0AUnable to handle kernel NULL point=
er dereference at virtual address 00000000=0Apgd =3D 80004000=0Apgd =3D 800=
04000=0A[00000000] *pgd=3D00000000=0A[00000000] *pgd=3D00000000=0A=0AUnable=
 to handle kernel paging request at virtual address f0000000=0Apgd =3D 8000=
4000=0A[f0000000] *pgd=3D00000000=0A=0AThanks,=0ABruno=0A=0A=0A=0A=0A=0AEm =
Domingo, 23 de Fevereiro de 2014 20:37, Gilles Chanteperdrix <gilles.chante=
perdrix@xenomai.org> escreveu:=0A =0AOn 02/24/2014 12:32 AM, Bruno Tunes de=
 Mello wrote:=0A> ^C---|-----------|-----------|-----------|--------|------=
|-------------------------=0A> RTS|=A0 =A0 =A0 3.636|=A0 =A0  12.446|=A0  1=
383.499|=A0 =A0 =A0  5|=A0 =A0  0|=A0 =A0 00:00:39/00:00:39=0A> =0A> Could =
you say if these results are right or not.=0A=0AThey are not right. Could y=
ou try the following (kernel) patch?=0A=0Adiff --git a/arch/arm/mach-mx6/mm=
.c b/arch/arm/mach-mx6/mm.c=0Aindex 3cf6b22..d1b74e9 100644=0A--- a/arch/ar=
m/mach-mx6/mm.c=0A+++ b/arch/arm/mach-mx6/mm.c=0A@@ -97,7 +97,7 @@ void __i=
nit mx6_map_io(void)=0A#ifdef CONFIG_CACHE_L2X0=0Aint mxc_init_l2x0(void)=
=0A{=0A-=A0=A0=A0 unsigned int val;=0A+=A0=A0=A0 unsigned int val, aux_ctrl=
;=0A=0A=A0=A0=A0 #define IOMUXC_GPR11_L2CACHE_AS_OCRAM 0x00000002=0A=0A@@ -=
114,12 +114,24 @@ int mxc_init_l2x0(void)=0A=A0=A0=A0 val =3D readl(IO_ADDR=
ESS(L2_BASE_ADDR + L2X0_PREFETCH_CTRL));=0A=A0=A0=A0 val |=3D 0x40800000;=
=0A=A0=A0=A0 writel(val, IO_ADDRESS(L2_BASE_ADDR + L2X0_PREFETCH_CTRL));=0A=
+#ifndef CONFIG_IPIPE=0A=A0=A0=A0 val =3D readl(IO_ADDRESS(L2_BASE_ADDR + L=
2X0_POWER_CTRL));=0A=A0=A0=A0 val |=3D L2X0_DYNAMIC_CLK_GATING_EN;=0A=A0=A0=
=A0 val |=3D L2X0_STNDBY_MODE_EN;=0A=A0=A0=A0 writel(val, IO_ADDRESS(L2_BAS=
E_ADDR + L2X0_POWER_CTRL));=0A+#endif=0A+=0A+=A0=A0=A0 aux_ctrl =3D ((1 << =
L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |=0A+=A0=A0=A0 =A0=A0=A0 (0x1 << L2X0_AU=
X_CTRL_NS_LOCKDOWN_SHIFT) |=0A+=A0=A0=A0 =A0=A0=A0 (0x1 << L2X0_AUX_CTRL_NS=
_INT_CTRL_SHIFT) |=0A+=A0=A0=A0 =A0=A0=A0 (1 << 23) |=0A+=A0=A0=A0 =A0=A0=
=A0 (1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |=0A+=A0=A0=A0 =A0=A0=A0 (1 <=
< L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |=0A+=A0=A0=A0 =A0=A0=A0 (1 << L2X0_AU=
X_CTRL_INSTR_PREFETCH_SHIFT) |=0A+=A0=A0=A0 =A0=A0=A0 (1 << L2X0_AUX_CTRL_E=
ARLY_BRESP_SHIFT));=0A+=0A+=A0=A0=A0 l2x0_init(IO_ADDRESS(L2_BASE_ADDR), au=
x_ctrl, L2X0_AUX_CTRL_MASK);=0A=0A-=A0=A0=A0 l2x0_init(IO_ADDRESS(L2_BASE_A=
DDR), 0x0, ~0x00000000);=0A=A0=A0=A0 return 0;=0A}=0A=0Adiff --git a/arch/a=
rm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c=0Aindex 1e2c52d..27550b3 1006=
44=0A--- a/arch/arm/mm/cache-l2x0.c=0A+++ b/arch/arm/mm/cache-l2x0.c=0A@@ -=
421,6 +421,9 @@ void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux=
_mask)=0A=A0=A0=A0 =A0=A0=A0 writel_relaxed(1, l2x0_base + L2X0_CTRL);=0A=
=A0=A0=A0 }=0A=0A+=A0=A0=A0 /* Re-read it in case some bits are reserved. *=
/=0A+=A0=A0=A0 aux =3D readl_relaxed(l2x0_base + L2X0_AUX_CTRL);=0A+=0A=A0=
=A0=A0 outer_cache.inv_range =3D l2x0_inv_range;=0A=A0=A0=A0 outer_cache.cl=
ean_range =3D l2x0_clean_range;=0A=A0=A0=A0 outer_cache.flush_range =3D l2x=
0_flush_range;=0A=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 Gilles.
