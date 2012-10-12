Message-ID: <5077E273.3010109@xenomai.org>
Date: Fri, 12 Oct 2012 11:27:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20121011170958.40C8E372@centrum.cz>,
	<50771645.6020705@xenomai.org>,
	<20121012091140.E3CB5F90@centrum.cz> <5077D1D8.1070505@xenomai.org>
	<20121012112115.C2F442F8@centrum.cz>
In-Reply-To: <20121012112115.C2F442F8@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Shared interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: xenomai@xenomai.org

On 10/12/2012 11:21 AM, Petr Cervenka wrote:
>>>>>
>>>>> My primary questions: Is there a possibility to have the rtdm driver
>>>>> compatible with both cases?
>>>>
> 
> So I assume, it is not possible.

It is possible. What you want is, in case you have a nrt device, and in
this case only, register a shared irq handler which simply returns
XN_ISR_PROPAGATE | XN_ISR_NOENABLE, independently of the irq handler for
the rt device.

But if you start doing that, it is probably better to do what is
described in the FAQ (write an irq handler for the nrt device which
really acknowledges the irq at device level, so that you can avoid
returning XN_ISR_NOENABLE, and keep determinism).

> 
>>
>> Yes, I was talking about the rt devices only case. For the rt/nrt mixup,
>> see the FAQ.
>>
> 
> I have some suggestion on improvement in future version: 
> Allowing to setup for interrupt, that when no rt device handles the interrupt it could be passed to the linux.
> More specifically:
> Similar flag to XN_ISR_PROPAGATE, but pass interrupt to linux only when it was not handled by any rt device at all.
> 
> Example:
> Imagine system with 2 shared PCI slots (and no other). The user can use those slots for any combination of rt and nrt devices. This combination (or IRQ sharing) is not known in advance.

This will probably never happen. The case where rt/nrt devices are mixed
up has absolutely no interest. If you do not need determinism for the rt
device, do not use an rt driver.

-- 
					    Gilles.

