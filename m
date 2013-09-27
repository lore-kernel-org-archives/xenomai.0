Message-ID: <5245BB62.4000000@axelsw.it>
Date: Fri, 27 Sep 2013 19:07:46 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>,
	<51DDB5C3.7010307@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F268F@MAIL-SINTERS-01.sinters-int.fr>,
	<51DEF6FB.6080403@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F3724@MAIL-SINTERS-01.sinters-int.fr>
	<51E43CE5.5020103@xenomai.org> <52457550.2050501@axelsw.it>
	<979a2ecdb54e79afe900ef6a07f21ce9.squirrel@127.0.0.1>
	<52457ED1.8050509@axelsw.it>
	<f7ebedb749132eb26e223704346b0bbe.squirrel@127.0.0.1>
	<52458F08.6050306@axelsw.it> <5245AB75.3040709@axelsw.it>
	<ba7aec05249fb25be79a1eeee55f17cf.squirrel@127.0.0.1>
In-Reply-To: <ba7aec05249fb25be79a1eeee55f17cf.squirrel@127.0.0.1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : RE : RE : No boot kernel with xenomai on
 i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

HI,

the local timer are active.

Here is the log:

Linux version 3.0.35-2666-gbdde708 (axel@axc25vm) (gcc version 4.6.2 
20110630 (prerelease) (Freescale MAD -- Linaro 2011.07 -- Built at 
2011/08/10 09:20) ) #13 SMP PREEMPT Fri Sep 27 19:01:47 CEST 2013
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale i.MX 6Quad/DualLite/Solo Sabre-SD Board
Ignoring unrecognised tag 0x54410008
Memory policy: ECC disabled, Data cache writealloc
CPU identified as i.MX6Q, silicon rev 1.2
PERCPU: Embedded 10 pages/cpu @8c008000 s17088 r8192 d15680 u40960
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 194560
Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk1p1 rootwait 
ro vide o=mxcfb1:dev=ldb,LDB-XGA,if=RGB666 
video=mxcfb0:dev=ldb,LDB-XGA,if=RGB565
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512MB 256MB = 768MB total
Memory: 764852k/764852k available, 283724k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     DMA     : 0xf4600000 - 0xffe00000   ( 184 MB)
     vmalloc : 0xc0800000 - 0xf2000000   ( 792 MB)
     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
       .init : 0x80008000 - 0x80048000   ( 256 kB)
       .text : 0x80048000 - 0x80b395b8   (11206 kB)
       .data : 0x80b3a000 - 0x80ba1e80   ( 416 kB)
        .bss : 0x80ba1ea4 - 0x80c1cb0c   ( 492 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:624
MXC GPIO hardware
sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655ms
arm_max_freq=1GHz
MXC_Early serial console at MMIO 0x2020000 (options '115200')
bootconsole [ttymxc0] enabled
I-pipe 1.18-11: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 1581.05 BogoMIPS (lpj=7905280)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
I-pipe, 396.000 MHz timer
I-pipe, 396.000 MHz clocksource
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters available
CPU1: Booted secondary processor
I-pipe, 396.000 MHz timer
CPU2: Booted secondary processor
I-pipe, 396.000 MHz timer
CPU3: Booted secondary processor
I-pipe, 396.000 MHz timer
Brought up 4 CPUs
SMP: Total of 4 processors activated (6324.22 BogoMIPS).
print_constraints: dummy:
NET: Registered protocol family 16
print_constraints: vddpu: 725 <--> 1300 mV at 700 mV fast normal
print_constraints: vddcore: 725 <--> 1300 mV at 1100 mV fast normal
print_constraints: vddsoc: 725 <--> 1300 mV at 1200 mV fast normal
print_constraints: vdd2p5: 2000 <--> 2775 mV at 2400 mV fast normal
print_constraints: vdd1p1: 800 <--> 1400 mV at 1100 mV fast normal
print_constraints: vdd3p0: 2625 <--> 3400 mV at 3000 mV fast normal
hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
hw-breakpoint: 1 breakpoint(s) reserved for watchpoint single-step.
hw-breakpoint: maximum watchpoint size is 4 bytes.
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x02070000, Cache size: 
1048576 B
bio: create slab <bio-0> at 0
mxs-dma mxs-dma-apbh: initialized
print_constraints: SPKVDD: 4200 mV
print_constraints: vmmc: 3300 mV
SCSI subsystem initialized
spi_imx imx6q-ecspi.0: probed
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Freescale USB OTG Driver loaded, $Revision: 1.55 $
mc_pfuze 1-0008: ID: 0,Full lay: 1 ,Metal lay: 1
mc_pfuze 1-0008: FAB: 0 ,FIN: 0
print_constraints: PFUZE100_SW1A: 300 <--> 1875 mV at 1300 mV
print_constraints: PFUZE100_SW1B: 300 <--> 1875 mV at 300 mV
print_constraints: PFUZE100_SW1C: 300 <--> 1875 mV at 1300 mV
print_constraints: PFUZE100_SW2: 800 <--> 3950 mV at 3300 mV
print_constraints: PFUZE100_SW3A: 400 <--> 1975 mV at 1500 mV
print_constraints: PFUZE100_SW3B: 400 <--> 1975 mV at 1500 mV
print_constraints: PFUZE100_SW4: 800 <--> 3950 mV at 3150 mV
print_constraints: PFUZE100_SWBST: 5000 <--> 5150 mV at 5000 mV
print_constraints: PFUZE100_VSNVS: 1200 <--> 3000 mV at 1800 mV
print_constraints: PFUZE100_VREFDDR: at 750 mV
print_constraints: PFUZE100_VGEN1: 800 <--> 1550 mV at 1500 mV
print_constraints: PFUZE100_VGEN2: 800 <--> 1550 mV at 1500 mV
print_constraints: PFUZE100_VGEN3: 1800 <--> 3300 mV at 2800 mV
print_constraints: PFUZE100_VGEN4: 1800 <--> 3300 mV at 1800 mV
print_constraints: PFUZE100_VGEN5: 1800 <--> 3300 mV at 3000 mV
print_constraints: PFUZE100_VGEN6: 1800 <--> 3300 mV at 3300 mV
imx-ipuv3 imx-ipuv3.0: IPU DMFC NORMAL mode: 1(0~1), 5B(4,5), 5F(6,7)
imx-ipuv3 imx-ipuv3.1: IPU DMFC NORMAL mode: 1(0~1), 5B(4,5), 5F(6,7)
mxc_mipi_csi2 mxc_mipi_csi2: i.MX MIPI CSI2 driver probed
mxc_mipi_csi2 mxc_mipi_csi2: i.MX MIPI CSI2 dphy version is 0x3130302a
MIPI CSI2 driver module loaded
Advanced Linux Sound Architecture Driver Version 1.0.24.
Bluetooth: Core ver 2.16
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
cfg80211: Calling CRDA to update world regulatory domain
max17135 2-0048: PMIC MAX17135 for eInk display
i2c-core: driver [max17135] using legacy suspend method
i2c-core: driver [max17135] using legacy resume method
Switching to clocksource ipipe_tsc

Il 27/09/2013 18:01, Gilles Chanteperdrix ha scritto:
> Roberto Bielli wrote:
>> hi,
>>
>> i try with the defconfig and the result is the same.
>> Any ideas ?
> Do you have local timer enabled in kernel configuration?
> What is the revision of the chip (appears in the first few lines of the
> kernel logs)?
>


-- 
+------------------------------------------------------------------------------------------------+
							
Roberto Bielli
Sviluppo Software					
Axel S.r.l.					
							
Via Del Cannino, 3 				
21020 Crosio Della Valle			
Varese - Italy					
							
Telefono: +39 0332 949600			
Fax:      +39 0332 969315			
							
E-mail:   roberto.bielli@axelsw.it	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@axelsw.it

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


