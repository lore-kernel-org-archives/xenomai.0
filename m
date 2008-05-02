Message-ID: <481AE850.8090807@domain.hid>
Date: Fri, 02 May 2008 12:09:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <481AA6B5.9070508@domain.hid> <481AC93E.3030107@domain.hid>
	<481AD5C2.6030607@domain.hid> <481AD90C.2090902@domain.hid>
	<481AD9E5.4000102@domain.hid> <481AE18A.2070803@domain.hid>
	<481AE503.2060609@domain.hid>
In-Reply-To: <481AE503.2060609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] MSI Interrupt Crash
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> PS: We really do want to call mask/unmask instead of disable/enable in any case, because ->disable()
>> became a nop in 2.6.21, so we just can't rely on its default action anyway. This is a separate
>> issue, that caused rthal_irq_disable() not to actually mask the interrupt when the I/O APIC is enabled.
> 
> Hmmmm... That makes me scratch my head. Could this change have some
> impact on I-pipe as well? We are currently pulling hairs here as some
> SCSI adapter is flooding us with spurious IRQs during init, but only if
> I-pipe is enabled.
>

__ipipe_enable_irq/__ipipe_disable_irq are not doing the right thing anymore,
but, AFAICT, this would only affect callers of ipipe_virtualize_irq and
ipipe_control_irq, using IPIPE_ENABLE_MASK.

Btw, are those APIC-based SMP spurious interrupts, or 8259-based ones?

-- 
Philippe.

