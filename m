Subject: Re: ipipe: IRQ not received on i.MX8 (linux-imx)
References: <a57774b8-46af-5db9-1ab4-163210bc1396@smile.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <05232e08-17d7-4b61-2b5c-c3cb97b4145f@siemens.com>
Date: Mon, 5 Jul 2021 13:02:52 +0200
MIME-Version: 1.0
In-Reply-To: <a57774b8-46af-5db9-1ab4-163210bc1396@smile.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre-Loup Gosse <pierre-loup.gosse@smile.fr>, xenomai@xenomai.org, Greg Gallagher <greg@embeddedgreg.com>, Philippe Gerum <rpm@xenomai.org>

On 05.07.21 09:10, Pierre-Loup Gosse via Xenomai wrote:
> Hi,
> 
> For a client project I try to port Xenomai 3.1 + I-pipe to the kernel
> linux-imx 5.4.70 for arm64 (i.MX8 Mini). I adapted the I-pipe patch
> (5.4.72-arm64). The kernel boots and works well.
> 

I think the imx8mm is fairly well supported in upstream by now. Maybe
worth to have a look at 5.10-dovetail and the Xenomai devel branch
(upcoming 3.2) so that you do not need to fiddle with the downstream
linux-imx mess in your product. I think Philippe is even testing on
imx8mm, but I might be wrong.

> However, for the non-regression test, I run a client test that uses
> Xenomai and UDD (to register a PCIe driver). The test waits for a
> hardware IRQ from a PCIe device. This IRQ is never received which lead
> the test to fail. To be more precise, after running the test, Xenomai
> show that no IRQs was received for this device:
> 
> # cat /proc/xenomai/irq
>   IRQ         CPU0        CPU1 CPU2        CPU3
>     3:        4027       14050 3708        4488         [timer/0]
> **223:           0           0 0           0         netx00
>  1031:           0           0 0           0         [sync]
>  1032:           1           1 1           0         [timer-ipi]
>  1033:           0           0 0           0         [reschedule]
>  1037:           0          44 0           0         [virtual]
> 
> 'netx00' is our device with the IRQ 223.
> /proc/xenomai/irq simply reads the irqall counter per CPU per IRQ
> (/__ipipe_cpudata_irq_hits/). This means that no IRQ 223 went through
> the I-pipe, or worse, not even sent.
> 
> But in comparison, I reproduced this test with the old client image
> (Xenomai 3.1 + I-pipe on the kernel linux-imx 4.14.98) on the same
> hardware (arm64 i.MX8 Mini). The test passed and Xenomai received IRQs
> for 'next00'.
> 
> This leads me to the conclusion that on the new kernel our IRQ is sent
> but does not pass through the I-pipe.
> 
> I noticed that some irq handler functions from driver do not use the
> /ipipe_handle_domain_irq/ or /ipipe_handle_demuxed_irq/ but the generic
> function, respectively /handle_domain_irq/ and /generic_handle_irq/.
> Especially for the imx irqchip (_drivers/irqchip/irq-imx-intmux.c_ and
> _drivers/irqchip/irq-imx-irqsteer.c_). I patched these files to use
> /ipipe_handle_demuxed_irq/ rather than /generic_handle_irq/. But
> /proc/xenomai/irq still shows 0 IRQs and the test still fails.
> 
> Am I doing things right ? Or am I missing something ?

Greg may provide some hints here from his porting to 5.4.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

