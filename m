Message-ID: <4D6E61B6.906@domain.hid>
Date: Wed, 02 Mar 2011 16:26:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110302151603.GA14557@domain.hid>
In-Reply-To: <20110302151603.GA14557@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> I am running Xenomai 2.5 git master on a P2020 with kernel 2.6.36.
> 
> We have a custom PCIe card that raise a MSI, with a normal (not rtdm)
> driver. It appears that the interrupt comes just once and then is
> stuck. It work under plain Linux, but I cannot rule out a HW timing
> bug either.
> 
> The wiki pages 
> 
>    http://www.xenomai.org/index.php/FAQs
>    http://www.xenomai.org/index.php/Configuring_x86_kernels
> 
> say not to enable MSI on x86, with a link to a very old (2008)
> discussion. I found a newer mail
> 
>    https://mail.gna.org/public/xenomai-help/2010-01/msg00095.html
> 
> claiming that MSI is okay.

No. This is my fault. I simply had forgotten that MSI were not OK on x86.

> 
> Is there a known problem with MSI and Xenomai?

There is a known problem with MSI on x86 (explained by the FAQ link).

> 
> If so, where/how can I start to get working on fixing it?
> 
> (I don't need the MSI in a rtdm or adeos context.)

Given that the problem is that the interrupt controller ack/mask
functions (if I recall correctly) need, on x86, to use some Linux
primitives which can not be called from Xenomai domain, I am not sure it
is easy to fix. And the fact that you do not need the MSI in Xenomai
domain does not change anything, since ack/mask routines are called
ahead of the pipeline anyway.

-- 
					    Gilles.

