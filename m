Message-ID: <51B368EF.3060301@xenomai.org>
Date: Sat, 08 Jun 2013 19:25:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44b485fd.1ee68.13f24728cbf.Coremail.ericvic@163.com>
In-Reply-To: <44b485fd.1ee68.13f24728cbf.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Set gpio irq priority with tzic_set_irq_prio(int irq, int hi)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: xenomai@xenomai.org

On 06/08/2013 05:40 PM, 嵌入式工程师 wrote:

> Now I use Imx53 gpio2-14 to be a interrupt source ,but I found its priority so lower . 


How is that? All the gpio irqs have the same priority.

> So I use tzic_set_irq_prio(int irq, int hi) 
> .................................
> .............................
> 
> 
> 
> 
>  MY_GPIO2_14=(1*32+14)+128;
>  irq=irq_ to_gpio( MY_GPIO2_14);
>  mxc_tzic_init_irq(IMX53_TZIC_BASE_ADDR);
>  tzic_set_irq_prio(irq,20);//chang the priority to #30
> .................................
> ......................................
> 
> 
> Is it right？


No. tzic_set_irq_prio is an internal function to be used by Xenomai. You
do not need to use it.

> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai



-- 
                                                                Gilles.

