Message-ID: <43B81ADC.9090002@domain.hid>
Date: Sun, 01 Jan 2006 19:09:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rt shared irqs] changes on the adeos-ipipe layer
	v.2
References: <b647ffbd0512291103y383a96c1i@domain.hid>
In-Reply-To: <b647ffbd0512291103y383a96c1i@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:

<snip>

> 
> er.. I was confused by the fact that sum of all apcs in 
> /proc/xenomai/apc != virq from /proc/xenomai/irq, but ipipe_printk_virq 
> is not listed since it's registered without rthal::apc interface. Ok, 
> should take a look at it closer, i.e. maybe at least rthal_linux_irq can 
> be reworked now.
>

APCs are multiplexed on a single virq.

> 
> -- 
> Best regards,
> Dmitry Adamushko
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

