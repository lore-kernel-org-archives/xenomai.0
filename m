Message-ID: <5336C42B.4080101@xenomai.org>
Date: Sat, 29 Mar 2014 14:01:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADoY7i8=SSBVO6R7eiGtMLb9ZnAsXj+mC4L_pDRs3-zDBaP7aQ@mail.gmail.com>
In-Reply-To: <CADoY7i8=SSBVO6R7eiGtMLb9ZnAsXj+mC4L_pDRs3-zDBaP7aQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] IRQ Handler latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 29/03/2014 00:41, Newell Jensen a écrit :
> Hello,
> 
> I have successfully created an RTDM driver that uses the EPIT timer on the
> i.mx6dl-sabresd board.  The reason I created this driver is I wanted to see
> what the hard interrupt latency is using Xenomai.
> 
> AFAIK, I am using the RTDM skin in the proper way.  However, I wanted to
> run my code by the experts (you guys), to see if there is any improvements
> that I can make.
> 
> Here is a link to my code:  http://pastebin.com/TFWLq9mq
> 
> My questions are:
> 
> 1. Is there anything that I am not doing in my code that I should be to
> reduce interrupt latency?

You can remove some useless stuff from the interrupt handler: testing
rtdm_in_rt_context is useless, calling rtdm_lock_get_irqsave is useless,
as irqs are already off.

> 
> 2. Is there a way to set the priority for a kernel module like the one I
> have?

It does not make sense to talk about the priority of a kernel module.

> 
> 3. Is there an easy way to see the priorities of all irqs both in Xenomai
> and Linux?

Xenomai irqs are not threaded, so there is no such thing as an irq priority.

But why do you ask all this, have you compared the latencies you measure
with those of the "latency" test, are they not comparable?
Do you have the patch which disables write-allocate in the imx6 L2 cache?


-- 
Gilles.

