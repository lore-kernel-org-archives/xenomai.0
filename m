MIME-Version: 1.0
In-Reply-To: <9DA3CFDAD528B6408A6F2150A12D33CA51A776E1@SHSMSX103.ccr.corp.intel.com>
References: <9DA3CFDAD528B6408A6F2150A12D33CA51A776E1@SHSMSX103.ccr.corp.intel.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 7 Jun 2018 12:42:26 -0400
Message-ID: <CALLqZ8Rkja5WUYTaYw5DH2Wj46i7j+xEdi1sN+L8RUT5AmoRiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] INTR-REMAP issue while enabling GPIO interrupt as
	RTDM interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yan, Hongliang" <archer.hl.yan@intel.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

I'm probably not much help but something similar was on the list a while ago:

https://xenomai.org/pipermail/xenomai/2017-November/038014.html

On Thu, Jun 7, 2018 at 11:55 AM, Yan, Hongliang <archer.hl.yan@intel.com> wrote:
> Hi All,
>   I am trying to enable pinctrl-intel.c GPIO interrupt as RTDM interrupt. I use rtdm_irq_request to replace devm_request_irq in probe function.
>   code is as following:
> =======================================================================
> #if 1
>     if ((ret = rtdm_irq_request(&irq_rtdm,
>                     irq, handler_interruption,
>                     0,
>                     "test", NULL)) != 0) {
>         printk("rtdm request error\n");
> }
>
> #else
>     ret = devm_request_irq(pctrl->dev, irq, intel_gpio_irq, IRQF_SHARED,
>                    dev_name(pctrl->dev), pctrl);
>     if (ret) {
>         dev_err(pctrl->dev, "failed to request interrupt\n");
>         goto fail;
>     }
> #endif
> =========================================================================
>   I check /proc/xenomai/irq, it shows GPIO interrupt has been registered as XENOMAI interrupt.
> =========================================================================
> [root@localhost devices]# cat /proc/xenomai/irq
>   IRQ         CPU0        CPU1        CPU2        CPU3
>    14:           0           0           0           0         test
> 4352:           0           0           0           0         [sync]
> 4353:           0           0           0           1         [reschedule]
> 4354:     1007738      987012     1007340     1082939         [timer/0]
> 4355:           1           1           0           1         [timer-ipi]
> 4419:           0           0           0           0         [virtual]
> ===========================================================================
> But once I trigger the GPIO interrupt, the interrupt handler can't be called. Instead, it shows:
> <3>[  156.957511] DMAR: DRHD: handling fault status reg 2
> <3>[  156.957541] DMAR: INTR-REMAP: Request device [[f0:1f.0] fault index 0
> <3>[  156.957541] INTR-REMAP:[fault reason 37] Blocked a compatibility format interrupt request
>
> I also list lspci -v, there is no device named f0:1f.0.
> Could someone help me with this? Did I miss something when request RTDM interrupt?
>
> Best Regards,
>
> Archer Yan
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

