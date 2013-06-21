Message-ID: <51C4873D.9030000@xenomai.org>
Date: Fri, 21 Jun 2013 19:02:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51C41FD4.9070608@163.com>
In-Reply-To: <51C41FD4.9070608@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] request_irq with xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: aking_jin <jinxin16897123@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/21/2013 11:41 AM, aking_jin wrote:

> Hi,all
>      I've patched the kernel 3.5.7 with xenomai,and xenomai have been 
> enabled. After that, I want to have a  normal gpio interrupt test with 
> normal way using request_irq, found its return value is -/EINVAL,
> Finally found that IRQ_NOREQUEST was set in the irq_desc[irq_number] 
> through debug. could you give me some advice? thanks.
>          the following was the irq_desc of irq_gpio:
> 
>          [   66.087719] irq 10, desc: c1805600, depth: 0, count: 0, 
> unhandled: 0
>          [   66.097903] ->handle_irq():  c0065678, 
> __ipipe_chained_irq+0x0/0x4
>          [   66.104157] ->irq_data.chip(): c052de50, 
> pxa_internal_irq_chip+0x0/0x70
>          [   66.110751] ->action():   (null)
>          [   66.114010]    IRQ_NOPROBE set
>          [   66.117039]  IRQ_NOREQUEST set
>          [   66.120063]   IRQ_NOTHREAD set
> 
> Thank you very much~
> /
> 


I would say you are using the wrong irq number, you are using the irq
number of the parent, multiplexed interrupt, instead of using the
per-gpio irq number (which you should obtain with gpio_to_irq), but this
question is off-topic on this list, since it has nothing to do with xenomai.


-- 
                                                                Gilles.

