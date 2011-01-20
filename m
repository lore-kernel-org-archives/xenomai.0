Message-ID: <4D3850EF.4020005@domain.hid>
Date: Thu, 20 Jan 2011 16:12:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinUokEbeGRSFsYu4NSU5JhSPg514Yyty0wwGgrh@domain.hid>
In-Reply-To: <AANLkTinUokEbeGRSFsYu4NSU5JhSPg514Yyty0wwGgrh@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Hi,
> 
> I have an ARM based platform which is similar to the at91sam9263ek
> eval board. One of the differences is that touchscreen irq is on pin
> PB31 instead of PA15. The 'arch/arm/mach-at91/board-sam9263ek.c' has
> been changed for this.
> 
> Touch works when using the kernel without Xenomai.
> When using the same kernel with Xenomai patches, touch doesn't work. I
> get only 2 interrupts on the GPIO pin (cat /proc/interrupts).
> 
> Anyone an idea why the Xenomai enabled kernel stops generating
> interrupts on the GPIO pins while the non-Xenomai enabled kernel
> doesn't?

Xenomai does not change anything. However, the I-pipe patch changes the
way interrupts are handled. Now, we have to figure out exactly how this
is an issue.

Is this GPIO a muxed GPIO?

As a first test, could you try commenting out the
#define __IPIPE_FEATURE_PIC_MUTE
in arch/arm/mach-at91/include/mach/irqs.h ?

Have you tried commenting out the line you show us which disables
interrupts? Can you explain why this interrupt line is using
handle_simple_IRQ if it is not a muxed GPIO?

-- 
                                                                Gilles.

