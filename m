Message-ID: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>
Date: Wed, 21 Nov 2007 10:40:49 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1195598528.25407.9.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1195598528.25407.9.camel@domain.hid>
Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled. Disable
	IRQ line.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai@xenomai.org

On Nov 20, 2007 11:42 PM, Dennis Nguyen <dennisnguy@domain.hid> wrote:
> Hello,
>
> I'm using linux kernel 2.6.22.12, xenomai 2.4-rc6, and rtnet trunk 1140
> date 11/15/2007. There are 2 8139 RealTek nics in the system
>
> I got the disable IRQ messages when loading RTnet modules:
> Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disable IRQ line.
> Xenomai: xnintr_shirq_handler: IRQ10 not handled. Disable IRQ line.
>
> one nic using IRQ 11 and the other using IRQ 10
> These cause the rteth0 and rteth1 not receive any packages.
>
> How can I enable the interrupts? or control so that the
> xnintr_shirq_handler not disable the interrupts?

There are several reasons why this can happen. One reason is a bug in
the drivers interrupt handler, which returns RTDM_IRQ_NONE whereas it
should not. Another reason is that the IRQs 10 and 11 are shared
between the ethernet driver and non real-time drivers. This can not
work.


-- 
                                               Gilles Chanteperdrix

