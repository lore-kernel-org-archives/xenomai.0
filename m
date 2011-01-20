MIME-Version: 1.0
In-Reply-To: <4D3850EF.4020005@domain.hid>
References: <AANLkTinUokEbeGRSFsYu4NSU5JhSPg514Yyty0wwGgrh@domain.hid>
	<4D3850EF.4020005@domain.hid>
Date: Thu, 20 Jan 2011 17:11:41 +0100
Message-ID: <AANLkTimJzJpjKy2dowqzwrivCb86pkbt+tNQ5-h4=7xr@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] ARM gpio pins interrupts
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
Cc: xenomai@xenomai.org

On Thu, Jan 20, 2011 at 4:12 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> Hi,
>>
>> I have an ARM based platform which is similar to the at91sam9263ek
>> eval board. One of the differences is that touchscreen irq is on pin
>> PB31 instead of PA15. The 'arch/arm/mach-at91/board-sam9263ek.c' has
>> been changed for this.
>>
>> Touch works when using the kernel without Xenomai.
>> When using the same kernel with Xenomai patches, touch doesn't work. I
>> get only 2 interrupts on the GPIO pin (cat /proc/interrupts).
>>
>> Anyone an idea why the Xenomai enabled kernel stops generating
>> interrupts on the GPIO pins while the non-Xenomai enabled kernel
>> doesn't?
>
> Xenomai does not change anything. However, the I-pipe patch changes the
> way interrupts are handled. Now, we have to figure out exactly how this
> is an issue.
>
> Is this GPIO a muxed GPIO?

Pin PB31 is a muxed GPIO IRQ.

>
> As a first test, could you try commenting out the
> #define __IPIPE_FEATURE_PIC_MUTE
> in arch/arm/mach-at91/include/mach/irqs.h ?
>

Commenting out the define has no difference; still get 2 irq's.

> Have you tried commenting out the line you show us which disables
> interrupts? Can you explain why this interrupt line is using
> handle_simple_IRQ if it is not a muxed GPIO?

I tried not disabling the IRQ and not setting the irq_disabled flag in
the isr, but that unfortunately always resulted in unbalanced enables
for the IRQ and finally a lock up of the system. Have to dig into the
driver code a little deeper if I want to balance it.
Interesting is that I get more IRQ's than just 2. Even many more than
I expect for one touch (>100) which tells me the comment in the
driver's isr makes sense. And which also indicates this problem is
likely related to disabling the irq here.

(BTW: tried ipipe 1.18-01 which shows the same problem)

Thanks for helping!
Henri

>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

