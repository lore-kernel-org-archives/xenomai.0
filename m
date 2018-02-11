References: <CALLqZ8RC+5r7QhOf6EW5p_KGLpd-9+b7j511j19JgR90iopw_w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <07e341e7-5d6f-4054-4270-b0777f7b6daa@xenomai.org>
Date: Sun, 11 Feb 2018 10:44:54 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RC+5r7QhOf6EW5p_KGLpd-9+b7j511j19JgR90iopw_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] bcm2835 ipipe question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/11/2018 02:57 AM, Greg Gallagher wrote:
> I'm getting the raspberry pi zero images ready and I see the following
> in the dmesg:
> 
> [    0.000000] WARNING: CPU: 0 PID: 0 at
> /home/ggallagher/devel/emb_linux/ipipe-arm/kernel/irq/chip.c:57
> irq_set_chip+0x7c/0xac
> [    0.000000] irqchip ARMCTRL-level is not pipeline-safe!
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.4-ipipe+ #2
> [    0.000000] Hardware name: BCM2835
> [    0.000000] I-pipe domain: Linux
> 
> it looks like cobalt isn't running either, I'm trying to find the best
> way to debug this or if this is a bug?

This is a heads up I have recently added telling us about an active IC
driver which has not been fixed up for interrupt pipelining yet, which
would certainly cause breakage with CONFIG_IPIPE on.

In that case, that would be:
drivers/irqchip/irq-bcm2835.c:	.name = "ARMCTRL-level",

Looking at the code, it has been fixed up properly, but it is missing
the new flag introduced for tagging such condition, i.e.:

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index bf8c9d4dc00d..ea2c31b58073 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -115,6 +115,7 @@ static struct irq_chip armctrl_chip = {
 	.irq_hold = armctrl_mask_irq,
 	.irq_release = armctrl_unmask_irq,
 #endif
+	.flags	= IRQCHIP_PIPELINE_SAFE,
 };

-- 
Philippe.

