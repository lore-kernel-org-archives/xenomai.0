Message-ID: <43C03DC3.1040502@domain.hid>
Date: Sat, 07 Jan 2006 23:16:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] heres a go
	at	an	adeos-ipipe-2.6.15-i386-1.1-01.patch
References: <20060106163226.X16178@domain.hid> <43BF7337.7020506@domain.hid>
	<20060107114240.B16178@domain.hid> <43C01960.3090806@domain.hid>
	<43C0364B.5020000@domain.hid>
In-Reply-To: <43C0364B.5020000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
> Philippe Gerum wrote:
> 
>> You may want to try this one:
>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.15-i386-1.1-03.patch 
>>
>>
> 
> although Im not surprised, I feel like telling someone,
> 
> [jimc@domain.hid ~]$ uname -a
> Linux harpo.jimc.earth 2.6.15-ipipe-103-sony #1 Sat Jan 7 13:54:09 MST 
> 2006 i686 i686 i386 GNU/Linux
> [jimc@domain.hid ~]$
> 
> is NFS root for ..
> 
> soekris:~# uname -a
> Linux soekris 2.6.15-ipipe-103-sk #3 Sat Jan 7 13:42:06 MST 2006 i586 
> GNU/Linux
> soekris:~#
> soekris:~# df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> 192.168.42.1:/nfshost/soekris
>                      20158372  14249292   4885080  75% /
> tmpfs                    63268         0     63268   0% /dev/shm
> /dev/hda1               484602    268767    190813  59% /mnt/flash
> 192.168.42.1:/boot    20158400  14249312   4885088  75% /boot
> 192.168.42.1:/lib/modules
>                      20158400  14249312   4885088  75% /lib/modules
> 192.168.42.1:/media/cdrecorder
>                      20158400  14249312   4885088  75% /mnt/cd
> 192.168.42.1:/home    20158400  14249312   4885088  75% /home
> 192.168.42.1:/mnt/dilbert
>                      15638816  11716256   3128128  79% /mnt/dilbert
> 192.168.42.1:/usr/xenomai
>                      20158400  14249312   4885088  75% /usr/xenomai
> 192.168.42.1:/home/jimc/dilbert/pirt
>                      15638816  11716256   3128128  79% /mnt/pirt
> 
> 
> woohoo!
> 
> I just diffed my-1.01 and real-1.03, it looks like I missed a bunch
> of these:
>  > -     spin_unlock_irqrestore(&ioapic_lock, flags);
>  > +     spin_unlock_irqrestore_hw(&ioapic_lock, flags);
> 
> did I get lucky ?
> or is it cuz Im not SMP ?

The additional hw locking is to make 100% sure that built-in Adeos 
domains pushed above Linux could call the related routines even during 
the kernel init phase. Since the I-pipe is enabled quite early during 
this process, I've decided to play extra safe here.

> or cuz my sony has no APIC  (as distinct from ACPI) ?
> do any PCs have an APIC, or is that something for servers / hi-end
> or embedded ?
> 

It has become the norm for desktops, Intel CPU(s) of hi-end boxen have 
one especially SMP since it works with the IO-APIC for routing 
interrupts among other things. Still not the norm for embedded AFAIK, 
this will possibly evolve the same way over time too.

> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
> BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
> BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
> 511MB LOWMEM available.
> On node 0 totalpages: 130880
>  DMA zone: 4096 pages, LIFO batch:0
>  DMA32 zone: 0 pages, LIFO batch:0
>  Normal zone: 126784 pages, LIFO batch:31
>  HighMem zone: 0 pages, LIFO batch:0
> DMI present.
> ACPI: RSDP (v000 SONY                                  ) @ 0x000f53f0
> ACPI: RSDT (v001   SONY       F1 0x20040323 MSFT 0x00000097) @ 0x1ff40000
> ACPI: FADT (v002   SONY       F1 0x20040323 MSFT 0x00000097) @ 0x1ff40200
> ACPI: OEMB (v001   SONY       F1 0x20040323 MSFT 0x00000097) @ 0x1ff50040
> ACPI: DSDT (v001   SONY       F1 0x20040323 MSFT 0x0100000d) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x408
> Allocating PCI resources starting at 30000000 (gap: 20000000:e0000000)
> Built 1 zonelists
> Kernel command line: ro root=LABEL=/
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 1694.791 MHz processor.
> Using pmtmr for high-res timesource
> I-pipe 1.1-03: pipeline enabled.
> 
> 
> BTW, what happened to 1.01 and 1.02 ?
> 

There were three critical changes to merge for starting 1.1; one at a 
time, -03 has ended the series.

> tia
> jimc
> 


-- 

Philippe.

