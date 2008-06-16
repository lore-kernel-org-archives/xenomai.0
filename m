Message-ID: <2ff1a98a0806160516r4aef127bu713ea993c0e671ad@domain.hid>
Date: Mon, 16 Jun 2008 14:16:16 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48562A3A.6000200@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48562A3A.6000200@domain.hid>
Subject: Re: [Xenomai-help] GPIO IRQ on AT91SAM9263
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paradoxxa <paradoxxa2001@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Jun 16, 2008 at 10:54 AM, Paradoxxa <paradoxxa2001@domain.hid> wrote:
> Hi,
>
> i have a general question about interrupt handling on a at91sam9263
> machine.
> Is there a possibility to define a  GPIO Pin to register a interrupt
> handler and use
> a interrupt service routine in the user space or should i use a RTDM modul.

The way GPIO irqs are mapped to irq numbers is platform dependent.
Aside of that, once you have got the IRQ number, GPIO irqs are
considered as normal IRQs by Xenomai.

-- 
 Gilles

