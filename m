MIME-Version: 1.0
In-Reply-To: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Wed, 27 Sep 2017 14:26:45 +0100
Message-ID: <CAKJ14NfuNCtfK9bT5Oh+dRYAKhW+4KgaFO5w=xt=exJOw6forQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Unexpected mode switches when reordering C++ lines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> I've got two versions of the same piece of code, the only difference
> is that lines are reordered:
>
> #if 1
>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat+4));
>    sPhasor.angle = interpretU32AsFloat(u32Tmp);
>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat));
>    sPhasor.mag   = interpretU32AsFloat(u32Tmp);
> #else
>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat));
>    sPhasor.mag   = interpretU32AsFloat(u32Tmp);
>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat+4));
>    sPhasor.angle = interpretU32AsFloat(u32Tmp);
> #endif
>
> In case '#if 1' sPhasor.angle is assigned before sPhasor.mag, and
> everything works fine.
>
> In case '#if 0' it's the other way round, and I get mode switches
> caused by the first (but not second) ntohl().

I forgot to mention the mode switch is actually a unaligned access
exception as shown here:
$> cat /proc/xenomai/faults
TRAP         CPU0        CPU1
  0:            0          50    (Data or instruction access)
  1:            0           0    (Section fault)
  2:            0           0    (Generic data abort)
  3:            0           0    (Unknown exception)
  4:            0           0    (Instruction breakpoint)
  5:            0           0    (Floating point exception)
  6:            0           0    (VFP Floating point exception)
  7:            0           0    (Undefined instruction)
  8:            0    14629654    (Unaligned access exception)

>
> Looking at the assembly, there is a clear difference:
>
> #if 1
>    0x2ac5bcb8 <+304>:   ldr     r3, [r5]
>    0x2ac5bcbc <+308>:   ldr     r2, [r5, #4]
>    0x2ac5bcc0 <+312>:   rev     r3, r3
>    0x2ac5bcc4 <+316>:   rev     r2, r2
> [...]
> #else
>      0x2abc3cb8 <+304>:   ldm     r5, {r2, r3}
> => 0x2abc3cbc <+308>:   rev     r2, r2
>      0x2abc3cc0 <+312>:   rev     r3, r3
> [...]
> #endif
>
> Here the arrow indicates where the mode switch occurs, which is at the
> 'rev' (for reverse byte order instruction), hence ntohl(). It seems
> that the assembler optimization that collates the two ' ldr r3, [r5]'
> and 'ldr r2, [r5, #4]' into ' ldm r5, {r2, r3}' could have something
> to do with the mode switches...
>
> Any clues what causes the mode switches and how to avoid them?
>
> Cheers,
>
> Andreas
>
>
> Setup:
> i.MX6 dual (ARM Cortex A9)
> $> cat /proc/version
> Linux version 3.0.43-tpcom_run2-PD13.2.4 (andreas@gorse) (gcc version
> 4.6.2 (OSELAS.Toolchain-2011.11.3 linaro-4.6-2011.11) ) #1 SMP PREEMPT
> Tue Sep 26 16:17:30 BST 2017
> $> cat /proc/xenomai/version
> 2.6.4
> $> cat /proc/ipipe/version
> 1.18-13
> $> arm-cortexa9-linux-gnueabi-gcc --version
> arm-cortexa9-linux-gnueabi-gcc (OSELAS.Toolchain-2011.11.3
> linaro-4.6-2011.11) 4.6.2
> $> arm-cortexa9-linux-gnueabi-ld --version
> GNU ld (GNU Binutils) 2.21.1

