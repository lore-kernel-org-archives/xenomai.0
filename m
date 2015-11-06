In-Reply-To: <20151105204655.GA31487@hermes.click-hack.org>
References: <OF6134003B.3BB84DA5-ONC1257EF4.002BF1E4-C1257EF4.002EC9DB@zodiacaerospace.com>
 <20151105204655.GA31487@hermes.click-hack.org>
MIME-Version: 1.0
Message-ID: <OFBFA9BE57.158A3D72-ONC1257EF5.003A424B-C1257EF5.003B7241@zodiacaerospace.com>
From: Philippe.Corbel@zodiacaerospace.com
Date: Fri, 6 Nov 2015 11:49:18 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Sorry for the break in thread continuity but as I said I just subscribed 
to the mailing list and use the archive to find the needed informations... 
I tried to quote the last message to restart the discussion.

By the way, I merged the 3.0.1 release in my source tree and generated a 
new kernel as you requested but I observed the same behaviour with the 3 
freezes during the boot and random freezes in use...

For additional information, here are the messages from kernel boot (DEBUG 
is still enabled for both I-Pipe and Cobalt Core and no related message):

Booting Linux on physical CPU 0x0
Linux version 3.18.20-hg38f03e835e7e (corbel@andromeda) (gcc version 4.8.3 
20140131 (prerelease) (crosstool-NG 1.18.0) ) #1 SMP PREEMPT Fri Nov 6 
11:24:54 CET 2015
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: xlnx,zynq-7000
cma: Reserved 16 MiB at 0x1e000000
Memory policy: Data cache writealloc
PERCPU: Embedded 12 pages/cpu @5fbcf000 s19200 r8192 d21760 u49152
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
130048
Kernel command line: console=ttyPS0,115200 root=/dev/ram0 rw earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 495996K/524288K available (3296K kernel code, 233K rwdata, 1068K 
rodata, 256K init, 410K bss, 28292K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0x60800000 - 0xff000000   (2536 MB)
    lowmem  : 0x40000000 - 0x60000000   ( 512 MB)
    pkmap   : 0x3fe00000 - 0x40000000   (   2 MB)
    modules : 0x3f000000 - 0x3fe00000   (  14 MB)
      .text : 0x40008000 - 0x4044b400   (4365 kB)
      .init : 0x4044c000 - 0x4048c000   ( 256 kB)
      .data : 0x4048c000 - 0x404c66a0   ( 234 kB)
       .bss : 0x404c66a0 - 0x4052d294   ( 411 kB)
Preemptible hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
L2C: DT/platform modifies aux control register: 0x72360000 -> 0x72b60000
L2C-310 erratum 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 1 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 8 ways, 512 kB
L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76b60001
slcr mapped to 60804000
zynq_clock_init: clkc starts at 60804100
Zynq clock init
sched_clock: 64 bits at 333MHz, resolution 3ns, wraps every 
3298534883328ns
I-pipe, 333.333 MHz clocksource, wrap in 12884 ms
timer #0 at 60806000, irq=43
I-pipe, 333.333 MHz timer
Interrupt pipeline (release #6)
Console: colour dummy device 80x30
Calibrating delay loop... 1309.69 BogoMIPS (lpj=654848)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x31cb40 - 0x31cb74
CPU1: Booted secondary processor
I-pipe, 333.333 MHz timer
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
Brought up 2 CPUs
SMP: Total of 2 processors activated (2639.87 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint 
registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
zynq-ocm f800c000.ocmc: ZYNQ OCM pool: 256 KiB @ 0x60880000
SCSI subsystem initialized
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
<giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Switched to clocksource ipipe_tsc
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 1912K (5f139000 - 5f317000)
hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters 
available
futex hash table entries: 512 (order: 3, 32768 bytes)
[Xenomai] scheduling class idle registered.
[Xenomai] scheduling class rt registered.
I-pipe: head domain Xenomai registered.
[Xenomai] Cobalt v3.0 (Exact Zero)
fuse init (API version 7.23)
msgmni has been set to 1004
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
dma-pl330 f8003000.dmac: Loaded driver for PL330 DMAC-241330
dma-pl330 f8003000.dmac:        DBUFF-128x8bytes Num_Chans-8 Num_Peri-4 
Num_Events-16
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
e0001000.serial: ttyPS0 at MMIO 0xe0001000 (irq = 82, base_baud = 3125000) 
is a xuartps
console [ttyPS0] enabled
xdevcfg f8007000.devcfg: ioremap 0xf8007000 to 60830000
brd: module loaded
loop: module loaded
libphy: MACB_mii_bus: probed
macb e000b000.ethernet eth0: Cadence GEM rev 0x00020118 at 0xe000b000 irq 
54 (00:0a:35:00:01:22)
macb e000b000.ethernet eth0: attached PHY driver [Marvell 88E1510] 
(mii_bus:phy_addr=e000b000.etherne:00, irq=-1)
i2c /dev entries driver
zynq-edac f8006000.memory-controller: ecc not enabled
ipip: IPv4 over IPv4 tunneling driver
TCP: cubic registered
NET: Registered protocol family 17
Registering SWP/SWPB emulation handler
Freeing unused kernel memory: 256K (4044c000 - 4048c000)
Starting rcS...
++ Mounting filesystem

Please press Enter to activate this console.








De :    Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
A :     Philippe.Corbel@zodiacaerospace.com
Cc :    xenomai@xenomai.org
Date :  05/11/2015 21:48
Objet : Re: [Xenomai]  Xenomai on Linux 3.18 on Zynq



On Thu, Nov 05, 2015 at 09:31:02AM +0100, 
Philippe.Corbel@zodiacaerospace.com wrote:
> Hi All!
> 
> I just subscribe to the mailing list to ask you for a few insight on my 
> potential problem.
> 
> I'm having the same behaviour that Andreas Galauner observed on his 
board 
> and since there have been no news since April, I'm restarting this 
> thread...

The mail you quote (unfortunately, not using the "reply" function of
your mail, which would have made finding back the original thread
easy), talks about a percpu issue that is fixed in recent I-pipe
patches. I suspect, however, that the percpu issue has nothing to do
with the stall issue you observe.

> 
> I'm currently developping for a custom designed board based on a Zynq 
> 7c020 and hoped to use Xenomai 3.0 on it.

Could you try the latest release, xenomai 3.0.1 ?

-- 
      Gilles.
https://urldefense.proofpoint.com/v2/url?u=https-3A__click-2Dhack.org&d=AwIBAg&c=uGI7_x3Gc0YOJ1Z5IL8Cqkg4u0O9mkiikR3CHRDHzv4&r=zHACEiPn-zUulNBqLUpINKqmol5KwpMtIt61dZ2A5vPCGZct98HdLObfEsRDsZ2-&m=60kfTnfC6ZZbW6IvJD_0tc6ch53dIHw2qZc3RcIIrX8&s=MFEUw843TCdwvK8suALtOwxyf35Ua063PHzyKN3fP9w&e= 


