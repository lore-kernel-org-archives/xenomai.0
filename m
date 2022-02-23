References: <PH1P110MB1050BF72127DFC0CE3440B64E23C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Realtime interrupt handling in driver
Date: Wed, 23 Feb 2022 09:12:17 +0100
In-reply-to: <PH1P110MB1050BF72127DFC0CE3440B64E23C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87h78qf0qe.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@xenomai.org


Russell Johnson via Xenomai <xenomai@xenomai.org> writes:

> Hello,
>
> In my driver that I have been converting to support OOB functionality
> with the EVL core, I have an interrupt handler that handles all
> interrupts from a device sitting on the PCIe bus. I was reading
> through the information on your wiki about interrupt pipelining in
> Dovetail. I was confused a bit on if there is work that I need to do
> in order to get interrupts & interrupt handlers to run out-of-band
> (and not be preempted by in-band linux processing), or if the EVL core
> takes care of that for me?
> If there is work I need to do with
> interrupt config & interrupt handlers in order to make them able to
> run out-of-band, where do I need to start?
>
> Thanks!
>
> Russell

[1] describes the general flow, this is a bit outdated starting from the
upcoming kernel v5.17 series [2], but the logic remains the same though.
[3] explains why and how to fix up the irqchip handlers for IRQ
pipelining.

[1] https://evlproject.org/dovetail/porting/irqflow/
[2] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/v5.17-evl-rebase
[3] https://evlproject.org/dovetail/pipeline/irq_handling/

-- 
Philippe.

