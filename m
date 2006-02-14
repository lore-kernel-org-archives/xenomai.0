Message-ID: <43F22012.8050706@domain.hid>
Date: Tue, 14 Feb 2006 19:23:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <fd6a47a90602140744lc1d4365q@domain.hid>	
	<43F21867.8070002@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
In-Reply-To: <fd6a47a90602141007g7830d31fu@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
> One moment. I'm trying to locate rthal_disable_irq()...
>  
> 
>     Does calling rthal_disable_irq() instead of returning
>     RTDM_IRQ_ENABLE, but rather
>     0, prevents the freeze?
> 
> 

rthal_irq_disable, sorry.

-- 

Philippe.

