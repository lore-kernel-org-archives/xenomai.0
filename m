Message-ID: <48317AED.7030507@domain.hid>
Date: Mon, 19 May 2008 15:04:45 +0200
From: paradoxxa <paradoxxa2001@domain.hid>
MIME-Version: 1.0
References: <1168701330@domain.hid>	
	<2ff1a98a0805190239x5f8c8445h47d8ca3070dded1c@domain.hid>	
	<4831626B.9080208@domain.hid>	
	<2ff1a98a0805190506g10f8c1bx781434f8bc73d9a1@domain.hid>	
	<48316FCF.3030706@domain.hid>
	<2ff1a98a0805190536q5bb3be8dg9b35265bc5b1b618@domain.hid>
In-Reply-To: <2ff1a98a0805190536q5bb3be8dg9b35265bc5b1b618@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: paradoxxa2001@domain.hid
Subject: Re: [Xenomai-help] at91sam9263 and user-space support compile fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix schrieb:
> On Mon, May 19, 2008 at 2:17 PM, paradoxxa <paradoxxa2001@domain.hid> wrote:
>   
>
>
> No, you are talking about CONFIG_DEBUG_LL, I am talking about
> CONFIG_DEBUG_INFO. These are two different options. So, this make at
> least two options that you changed. Could you check if a kernel with
> an unmodified defconfig boots ?
>
>   
The CONFIG_DEBUG_INFO is already set in the defconfig. The 
CONFIG_DEBUG_LL i set manually.
As well I had to changed the  AT91 Master Clock Frequency.

Here are the logs of a unmodified defconfig boot:
----------------------------------------------------------------------------------------------------------
Starting kernel ...

Linux version 2.6.24-dienetho-pm9263 (support@domain.hid) (gcc version 
4.1.1) #1 Mon May 19 14:48:33
 CEST 2008
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
Machine: Ronetix PM9263/BB9263
Ignoring unrecognised tag 0x54410008
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 199 MHz, master 99 MHz, main 18.432 MHz
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: root=/dev/mtdblock4 rootfstype=jffs2 fbcon=rotate:3 
mtdparts=physmap-flash.0:25
6k(u-boot)ro,64k(u-boot-env)ro,1408k(kernel),-(rootfs);nand:-(nand) 
ip=10.0.0.17:10.0.0.20:10.0.0.20
:255.255.255.0:PM9263:eth0:off
AT91: 160 gpio irqs in 5 banks
PID hash table entries: 256 (order: 8, 1024 bytes)
I-pipe 1.9-01: pipeline enabled.
Console: colour dummy device 80x30
console [tty0] enabled
console [ttyS0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Kernel panic - not syncing: AT91 clock rate incorrectly set.
Please recompile with IPIPE_AT91_MCK set to 99532800 Hz.

----------------------------------------------------------------------------------------------------------

