MIME-Version: 1.0
In-Reply-To: <20150325160852.GK15125@hermes.click-hack.org>
References: <CACreCVLijm5Wup7aTrRTq=SHBmEUQY5D2pYpXThWXSrGqpcuqw@mail.gmail.com>
 <20150318142119.GF24525@hermes.click-hack.org>
 <CACreCV+WajHg9wKp3HpxZ4uVdva5ADAWtOH6DDjPfWzcyNk2YQ@mail.gmail.com>
 <20150318145611.GG24525@hermes.click-hack.org>
 <CACreCV+VoYvYQbejhJ2RzU9ZJDUBExwZyRv-DFs3TzWtQvzZkg@mail.gmail.com>
 <20150325145730.GJ15125@hermes.click-hack.org>
 <CACreCVLQk_4i7OdMdOFBG6cLKxh3-qJLZGMoz9i_q4XoZPbdoA@mail.gmail.com>
 <20150325160852.GK15125@hermes.click-hack.org>
Date: Thu, 26 Mar 2015 07:44:16 +0800
Message-ID: <CACreCV+tYp1QConFh2uKWjnqVOQ4uA=xLmbyay_XT9mui0txfw@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
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

On Thu, Mar 26, 2015 at 12:08 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, Mar 25, 2015 at 11:25:02PM +0800, GP Orcullo wrote:
>> On Wed, Mar 25, 2015 at 10:57 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > On Wed, Mar 25, 2015 at 10:48:45PM +0800, GP Orcullo wrote:
>> >> On Wed, Mar 18, 2015 at 10:56 PM, Gilles Chanteperdrix
>> >> <gilles.chanteperdrix@xenomai.org> wrote:
>> >> > On Wed, Mar 18, 2015 at 10:48:10PM +0800, GP Orcullo wrote:
>> >> >> On Wed, Mar 18, 2015 at 10:21 PM, Gilles Chanteperdrix
>> >> >> <gilles.chanteperdrix@xenomai.org> wrote:
>> >> >> > On Wed, Mar 18, 2015 at 10:11:06PM +0800, GP Orcullo wrote:
>> >> >> >> Hi,
>> >> >> >>
>> >> >> >> I'm trying to port xenomai 2.6.4 on an Amlogic S805 board runni=
ng  a
>> >> >> >> 3.10.33 non-mainlined kernel.
>> >> >> >>
>> >> >> >> The kernel boots with CONFIG_IPIPE enabled but without CONFIG_X=
ENOMAI.
>> >> >> >> Once CONFIG_XENOMAI is set, the boot fails.
>> >> >> >>
>> >> >> >> Attached are the .config and the bootlog files. Turning
>> >> >> >> CONFIG_SMP_ON_UP off gives a different result.
>> >> >> >>
>> >> >> >> Any pointers on where to start looking?
>> >> >> >
>> >> >> > here:
>> >> >> > https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new=
-arm-soc/
>> >> >> >
>> >> >> > Your diagnostic is not consistent with the kernel messages: the =
only
>> >> >> > difference between CONFIG_XENOMAI and !CONFIG_XENOMAI is when
>> >> >> > xenomai starts, however your kernel crashes before xenomai start=
s.
>> >> >> >
>> >> >> > Your problem is probably, as usual, in the timer handling code, =
or
>> >> >> > tsc emulation.
>> >> >> >
>> >> >> > Other than that, I would disable the usually not recommended ker=
nel
>> >> >> > options.
>> >> >> >
>> >> >> > --
>> >> >> >                                             Gilles.
>> >> >>
>> >> >> I think there's a problem with the vendor supplied kernel source.
>> >> >>
>> >> >> On the xenomai patched kernel, disabling CONFIG_IPIPE and enabling
>> >> >> CONFIG_SMP_ON_UP gives the following error during compilation:
>> >> >>
>> >> >> In file included from arch/arm/include/generated/asm/irq_regs.h:1:=
0,
>> >> >>                  from include/linux/irq.h:26,
>> >> >>                  from include/linux/ipipe.h:28,
>> >> >>                  from include/linux/sched.h:25,
>> >> >>                  from arch/arm/kernel/asm-offsets.c:13:
>> >> >> include/asm-generic/irq_regs.h: In function =E2=80=98get_irq_regs=
=E2=80=99:
>> >> >> include/asm-generic/irq_regs.h:25:2: error: implicit declaration o=
f
>> >> >> function =E2=80=98ipipe_processor_id=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
>> >> >>
>> >> >> I traced the error to this file:
>> >> >> http://git.xenomai.org/ipipe-gch.git/tree/arch/arm/include/asm/per=
cpu.h?h=3Dfor-ipipe-3.10
>> >> >
>> >> > That is very much likely a bug in the I-pipe patch itself, a case w=
e
>> >> > did not handle (CONFIG_SMP_ON_UP and !CONFIG_IPIPE), nothing very
>> >> > serious, and probably unrelated to the issues you have.
>> >> >
>> >> > --
>> >> >                                             Gilles.
>> >>
>> >> I've stripped the kernel to its bare minimum and I was able to boot
>> >> xenomai on a single cpu and pass the xeno-regression-test with no
>> >> problems.
>> >>
>> >> Once CONFIG_SMP is enabled, the boot is stuck at "Switching to
>> >> clocksource ipipe_tsc". There are no additional messages after that.
>> >>
>> >> This processor has no per-cpu local timers; it has eight timers total
>> >> and I've allocated four timers for ipipe use. Sharing timers with
>> >> Linux gives the same results.
>> >
>> > Check that the tsc is working by calling ipipe_tsc_get() and
>> > printing the result in a loop right after tsc registration. If this
>> > freezes, the address you passed when registering the tsc is invalid.
>> > If it always print the same value, you are using a timer that is
>> > not started.
>> >
>> > --
>> >                                             Gilles.
>>
>> The tsc timer is working:
>>
>> [    0.192740] Brought up 4 CPUs
>> [    0.206979] SMP: Total of 4 processors activated (8.00 BogoMIPS).
>> [    0.213032] CPU: All CPU(s) started in SVC mode.
>> [    0.218205] devtmpfs: initialized
>> [    0.229562] DMA: preallocated 4096 KiB pool for atomic coherent alloc=
ations
>> [    0.235390] Switching to clocksource ipipe_tsc
>> [    1.845448] ipipe_tsc_get =3D 7361092
>> [    3.515445] ipipe_tsc_get =3D 9031092
>> [    5.185445] ipipe_tsc_get =3D 10701092
>> [    6.855445] ipipe_tsc_get =3D 12371092
>> [    8.525445] ipipe_tsc_get =3D 14041092
>>
>> I've added the code in the clockevent timer interrupt handler, right
>> after __ipipe_tsc_update().
>
> Seems to be incrementing real fast. To be sure it is working, please
> do the test as I suggested.
>
> --
>                                             Gilles.

The increment is consistent with a 1 MHz clock rate.

Here's the result right after __ipipe_tsc_register(&tsc_info):

[    0.000000] sched_clock: 32 bits at 1000kHz, resolution 1000ns,
wraps every 4294967ms
[    0.000000] I-pipe, 1.000 MHz clocksource
[    0.000000] ipipe_tsc_get =3D 5303847
[    0.000000] ipipe_tsc_get =3D 5307392
[    0.000000] ipipe_tsc_get =3D 5310942
[    0.000000] ipipe_tsc_get =3D 5314492
[    0.000000] ipipe_tsc_get =3D 5318042
[    0.000000] ipipe_tsc_get =3D 5321592
[    0.000000] ipipe_tsc_get =3D 5325142
[    0.000000] ipipe_tsc_get =3D 5328692
[    0.000000] ipipe_tsc_get =3D 5332242
[    0.000000] ipipe_tsc_get =3D 5335792
[    0.000000] Switching to timer-based delay loop


--=20
GP Orcullo

