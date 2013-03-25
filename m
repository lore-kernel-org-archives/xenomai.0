Message-ID: <515048EC.4020502@xenomai.org>
Date: Mon, 25 Mar 2013 13:54:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4808D1F1BD47644DA51DFECD4F7F5DD2178CCAB6@TQ-MAIL.tq-net.de>
In-Reply-To: <4808D1F1BD47644DA51DFECD4F7F5DD2178CCAB6@TQ-MAIL.tq-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe kernel core-3.5.7 does not boot on MX28
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Martin Krause <Martin.Krause@tqs.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/25/2013 12:01 PM, Martin Krause wrote:

> Hi,
> 
> I tried to boot an ipipe Kernel on an MX28 based board, but failed.
> Below are the boot messages I got for the ipipe-core-3.5.3-arm-2 
> release:
> 
> Booting Linux on physical CPU 0
> Linux version 3.5.3-ipipe-00079-g3b3b1d3 (tq@easypad) (gcc version 4.6.4 20120303 (prerelease) (GCC) ) #9 Mon Mar 25 11:04:14 CET 2013
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Freescale i.MX28 (Device Tree), model: Freescale i.MX28 Evaluation Kit
> Memory policy: ECC disabled, Data cachewriteback
> On node 0 totalpages: 32768
> free_area_init_node: node 0, pgdat c046eeec, node_mem_map c09e0000
> Normal zone: 256 pages used for memmap
> Normal zone: 0 pages reserved
> Normal zone: 32512 pages, LIFO batch:7
> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> pcpu-alloc: [0] 0
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> Kernel command line: fec_mac=00:d0:93:28:2c:c1 ip=172.21.5.73:172.21.10.56::::eth0:off root=/dev/nfs rw ramdisk_size=16384 nfsroot=172.21.10.56:/opt/eldk-5.2.1/armv5te/rootfs-lsb-sdk,v3,tcp console=ttyAPP3,115200 lcd_panel=FG0700 ssp1 panic=1
> PID hash table entries:512 (order: -1,2048 bytes)
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries:8192 (order: 3,32768 bytes)
> Memory: 128MB =128MB total
> Memory: 119748k/119748k available, 11324k reserved, 0K highmem
> Virtual kernel memory layout:
> 	vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap	: 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xc8800000 - 0xff000000   ( 872MB)
>     lowmem	: 0xc0000000 - 0xc8000000   ( 128 MB)
>     modules : 0xbf000000 - 0xc0000000   ( 16 MB)
>       .text	: 0xc0008000 - 0xc0413890(4143 kB)
> 	  .init : 0xc0414000 - 0xc0432ef0  ( 124 kB)
> 	  .data : 0xc0434000 - 0xc04715f0   ( 246 kB)
> 	   .bss : 0xc0471614 - 0xc09dfd00   (5562 kB)
> SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1,Nodes=1
> NR_IRQS:304
> I-pipe,0.032 MHz clocksource
> sched_clock: 32 bits at100 Hz, resolution 10000000ns, wraps every 4294967286ms
> I-pipe:ARM926EJ-S detected, disabling wfi instruction in idle loop
> Interrupt pipeline (release #2)
> 
> After that, nothing more happens. I have read the log output directly 
> from Memory after a reset (from __log_buf), since nothing is output 
> on the serial console.
> 
> I also tried top of core-3.5.7 tree, with the same result.
> 
> The clocksource of "0.032 MHz" looks very strange. Is this
> correct? Does anyone successfully has booted ipipe-3.5.7 on 
> MX28?


Hi,

The MX28 port was made on 3.4, at the time of moving to 3.5, things
seemed to have not changed much. Indeed the 0.032 MHz clock is wrong.
But one change got lost: the change which made the timer use the xbus
clock instead of the 32k clock. This should  probably be changed in the
dtb. But I do not see how the "timrot" clock frequency gets defined.

Regards.

-- 
                                                                Gilles.

