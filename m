MIME-Version: 1.0
In-Reply-To: <4DFCC18F.3060207@domain.hid>
References: <4DF9CA75.1040903@domain.hid> <4DF9DCE3.70703@domain.hid>
	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>
	<4DFBA463.3090902@domain.hid> <4DFBAEB9.8060106@domain.hid>
	<4DFBB08B.5020005@domain.hid> <4DFCC18F.3060207@domain.hid>
Date: Mon, 20 Jun 2011 15:34:35 +0100
Message-ID: <BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>
From: Jakub Nowacki <j.s.nowacki@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On 18 June 2011 16:17, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 06/17/2011 09:52 PM, Jakub Nowacki wrote:
>> On 17/06/2011 20:44, Gilles Chanteperdrix wrote:
>>> =A0From your first mail, the chipset you use is a Q57, the datasheet sa=
ys
>>> that the GLB_SMI_EN is still there. So, what you should do is check
>>> whether the SMI_LOCK bit is set. The following (untested) patch should
>>> print the lock bit value:
>>>
>>> diff --git a/ksrc/arch/x86/smi.c b/ksrc/arch/x86/smi.c
>>> index d80b14b..97e6774 100644
>>> --- a/ksrc/arch/x86/smi.c
>>> +++ b/ksrc/arch/x86/smi.c
>>> @@ -157,7 +157,8 @@ void rthal_smi_disable(void)
>>> =A0 =A0 =A0 =A0 =A0mask_bits(rthal_smi_masked_bits, rthal_smi_en_addr);
>>>
>>> =A0 =A0 =A0 =A0 =A0if (inl(rthal_smi_en_addr)& =A0rthal_smi_masked_bits=
)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("Xenomai: SMI workaround failed!\n=
");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("Xenomai: SMI workaround failed!, =
BIOS lock: d\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(inl(rthal_smi_en_addr +=
 0xA0 - SMI_CTRL_ADDR)& =A0(1<< =A04)));
>>> =A0 =A0 =A0 =A0 =A0else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("Xenomai: SMI workaround enab=
led\n");
>>>
>>
>> You were faster. Thanks! Sorry for slight cross posting. I have this
>> machine at work so I probably test it on Monday.
>
> The next step is to try disabling the individual bits (TC0, USB legacy,
> etc...), as they may not affected by the SMI_LOCK bit.
>

I've added the patch to smi.c and, as suspected, the SMI_LOCK is on,
namely, kernel log looks like:

[    2.111453] Xenomai: SMI workaround failed!, BIOS lock: 1

I switched off the global SMI disable leaving the particular bits
disabled and it seems to work:

[    2.121558] Xenomai: SMI-enabled chipset found
[    2.121568] Xenomai: SMI workaround enabled

BTW I've found that often motherboards have SMI locked and it is not
changeable in BIOS.

As for latency tests it helped, I think. I did series of tests with
large load (8x'dd if=3D/dev/zero of=3D/dev/null') and the results look
something like that:

Latency for user task (-t0), period 100 us:
RTS|     -2.363|     -1.936|     20.443|       0|     0|    00:30:00/00:30:=
00
Latency for kernel task (-t1), period 100 us:
RTS|     -2.924|     -2.500|     12.974|       0|     0|    00:30:00/00:30:=
00
Latency for timer IRQ (-t2), period 100 us:
RTS|     -3.327|     -2.970|     10.572|       0|     0|    00:30:00/00:30:=
00

Interestingly, I'm getting the same results for core2 kernel without
SMI workaround working. I was just getting high latencies approx. 70
us for generic kernel. I'm not sure though how is it possible. Also,
the higher latencies of above 10 us are arriving not too often but
relatively regularly (without any visible pattern, though). I'm not
sure if such a latencies are rather normal or caused by something
'bad'.

Moreover, I seem not be able to do switch test; when I run it I'm getting:

=3D=3D Testing FPU check routines...
r0: 1 !=3D 2
r1: 1 !=3D 2
r2: 1 !=3D 2
r3: 1 !=3D 2
r4: 1 !=3D 2
r5: 1 !=3D 2
r6: 1 !=3D 2
r7: 1 !=3D 2
=3D=3D FPU check routines: OK.
ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9
rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15
rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20
rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2
rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8
rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13
rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18
rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22
sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3RTT|  363494:24:53
RTH|---------cpu|ctx switches|-------total
RTD|           0|           0|           0
RTD|           1|           0|           0
RTD|           2|           0|           0

Thanks again for the a lot of help I received so far.

Best wishes,

Jakub

