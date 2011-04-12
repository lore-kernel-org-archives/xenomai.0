Message-ID: <4DA45660.4000003@domain.hid>
Date: Tue, 12 Apr 2011 15:40:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4D9F0679.7080109@domain.hid>	<1302268379.2101.35.camel@domain.hid>		<4DA30C80.3010107@domain.hid>	<1302531493.2054.355.camel@domain.hid>		<4DA30E14.6070401@domain.hid>	<1302532049.2054.357.camel@domain.hid>		<4DA31108.9080000@domain.hid>	<1302532753.2054	<4DA314F1.3070504@domain.hid>
	<4DA31EB6.4040909@domain.hid> <4DA4544F.7020300@domain.hid>
In-Reply-To: <4DA4544F.7020300@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jesper Christensen <jbc@domain.hid>
Cc: xenomai@xenomai.org

On 2011-04-12 15:31, Jesper Christensen wrote:
>  
> 
> I have managed to print the stack of a faulting thread:
> 
> Xenomai: suspending kernel thread b911f518 ('rtnet-rtpc') at
> nip=0xb911f940, lr=0xb911f940, r1=0xaf2c4580 after exception #1792
> 
> Xenomai: dumping stack at af2c4600
> Xenomai: 0xaf2c45ec - 0xaf2c45fc:       00000000 af2c4600 8009a334
> 00000000 00000000
> Xenomai: 0xaf2c45d8 - 0xaf2c45e8:       00000000  0 00000000 00000000
> 00000000
> Xenomai: 0xaf2c45c4 - 0xaf2c45d4:       b911f518  0 00000000 af2c45f0
> 8009a364
> Xenomai: 0xaf2c45b0 - 0xaf2c45c0:       00000000  0 00000000 00000000
> 00000000
> Xenomai: 0xaf2c459c - 0xaf2c45ac:       00000000  0 00000000 b911f518
> 8009a334
> Xenomai: 0xaf2c4588 - 0xaf2c4598:       00000000 b911f4e0 af2c45d0
> b911649c 00000000
> Xenomai: 0xaf2c4574 - 0xaf2c4584:       805e3988 8000000 805a89f0
> 00000001 b911f940
> Xenomai: 0xaf2c4560 - 0xaf2c4570:       b911f940 20000000 22000022
> b911ebb8 00000700
> Xenomai: 0xaf2c454c - 0xaf2c455c:       805a89f0 b911f940 00029000
> ffffffff 8009b2e4
> Xenomai: 0xaf2c4538 - 0xaf2c4548:       00000000 b911ebb8 805e50c4
> 805e3988 805a89f0
> Xenomai: 0xaf2c4524 - 0xaf2c4534:       00100100 ffffffff 00000000
> af2c4580 8000bf48
> Xenomai: 0xaf2c4510 - 0xaf2c4520:       00000000  0 00000000 00000000
> 00200200
> Xenomai: 0xaf2c44fc - 0xaf2c450c:       805e3988 22000022 00000000
> 00000000 00000000
> 
> Manually decoded link register words:
> ---------------------------------------------------------------------------------------------------------
> 8009a334:
> $ powerpc-linux-gnu-addr2line -e vmlinux 0x8009a334
> linux-2.6.29.6/arch/powerpc/include/asm/xenomai/bits/pod.h:168
> 
> 8009a364:
> $ powerpc-linux-gnu-addr2line -e vmlinux 0x8009a364
> linux-2.6.29.6/arch/powerpc/include/asm/xenomai/bits/pod.h:172
> 
> b911649c:
> $ powerpc-linux-gnu-addr2line -e
> ../3rd_party/XM-Linux/rtnet_build/stack/rtnet.ko 0x249c
> rtnet_build/stack/rtnet_rtpc.c:201
> 
> 8000bf48:
> $ powerpc-linux-gnu-addr2line -e vmlinux 0x8000bf48
> linux-2.6.29.6/arch/powerpc/kernel/ipipe.c:429  
> (ipipe_trigger_irq(unsigned irq) at local_irq_restore_hw(flags);)
> 
> ---------------------------------------------------------------------------------------------------------
> 
> Notice the "r1" register in the first line i assume should point to a
> back chain word, but the value is 00000001 and the "link register" word
> immediately after is b911f940 which points to:
> # grep b911f940 /proc/kallsyms
> b911f940 b pending_calls_lock   [rtnet]
> 
> 
> I'm not sure of the significance of the stack frame after that one.
> 

IIRC, you said that you are using rtnet-rtpc for a special use case.
Given the fact that this interface very well documented and highly
intuitive to use ;), I wouldn't be too surprised if you ran into a race
or an invalid use case.

Is the rtpc-using code part of your tarball? If so, can you break it out
and explain on it how you use rtpc?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

