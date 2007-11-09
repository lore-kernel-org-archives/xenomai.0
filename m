Message-ID: <4734736D.7060100@domain.hid>
Date: Fri, 09 Nov 2007 15:49:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b054e88e0711090616r6376a8a6t81e9bc94b4290dea@domain.hid>
	<473471FB.9010305@domain.hid>
In-Reply-To: <473471FB.9010305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel oops while trying first boot w/ Xenomai
 2.4rc5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Giammarco Zacheo wrote:
>> Hi All,
>> this is my first try to run a x86_64 kernel with Xenomai 2.4rc5 with
>> my Core 2 Extreme, but I got this message... :(
>>
>> Anybody can help? My config file is attached.
>>
>> Thank you
>>
>> Giammarco
>>
>>
>> Linux version 2.6.22.12 (root@domain.hid) (gcc version 4.1.2 (Gentoo 4.1.2 p17
>> Command line: root=/dev/sda6 console=ttyS0,38400
>> BIOS-provided physical RAM map:
>>  BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
>>  BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
>>  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
>>  BIOS-e820: 0000000000100000 - 00000000cffc6300 (usable)
>>  BIOS-e820: 00000000cffc6300 - 00000000d0000000 (reserved)
>>  BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
>>  BIOS-e820: 00000000fec00000 - 00000000fed40000 (reserved)
>>  BIOS-e820: 00000000fed45000 - 0000000100000000 (reserved)
>>  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
>> end_pfn_map = 1245184
>> DMI 2.4 present.
>> Zone PFN ranges:
>>   DMA             0 ->     4096
>>   DMA32        4096 ->  1048576
>>   Normal    1048576 ->  1245184
>> early_node_map[3] active PFN ranges
>>     0:        0 ->      153
>>     0:      256 ->   851910
>>     0:  1048576 ->  1245184
>> Intel MultiProcessor Specification v1.4
>> MPTABLE: OEM ID: COMPAQ   MPTABLE: Product ID: Workstation  MPTABLE: APIC at: 00
>> Processor #0 (Bootup-CPU)
>> Processor #1
>> Processor #2
>> Processor #3
>> I/O APIC #1 at 0xFEC00000.
>> Setting APIC routing to flat
>> Processors: 4
>> Allocating PCI resources starting at d2000000 (gap: d0000000:20000000)
>> SMP: Allowing 4 CPUs, 0 hotplug CPUs
>> PERCPU: Allocating 83560 bytes of per cpu data
>> Built 1 zonelists.  Total pages: 1030095
>> Kernel command line: root=/dev/sda6 console=ttyS0,38400
>> Initializing CPU#0
>> PID hash table entries: 4096 (order: 12, 32768 bytes)
>> time.c: Detected 2666.822 MHz processor.
>> I-pipe 1.2-05: pipeline enabled.
>> Console: colour VGA+ 80x25
>> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
>> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
>> Checking aperture...
>> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>> Placing software IO TLB between 0x5940000 - 0x9940000
>> Memory: 4047392k/4980736k available (2258k kernel code, 146116k reserved, 1259k)
>> Calibrating delay using timer specific routine.. 5335.03 BogoMIPS (lpj=2667519)
>> Mount-cache hash table entries: 256
>> CPU: L1 I cache: 32K, L1 D cache: 32K
>> CPU: L2 cache: 4096K
>> using mwait in idle threads.
>> CPU: Physical Processor ID: 0
>> CPU: Processor Core ID: 0
>> CPU0: Thermal monitoring enabled (TM2)
>> SMP alternatives: switching to UP code
>   ^^^^^^^^^^^^^^^^
> I could imagine that this is our problem. The SMP alternatives code is
> most probably not ipipe-compatible and could have side-effects here.
> 
> Suggestion: Compile your kernel as UP, if you want to run it UP (more
> efficient anyway /wrt Xenomai). Please report the result!

Forget about this, just found the same setup here, and it causes no
problems.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

