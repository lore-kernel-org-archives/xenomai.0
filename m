Subject: Re: [PATCH 7/7] travis: append v5.0 to the matrix
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
 <20190305144521.2567-7-roman.stratiienko@globallogic.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2985e73a-4e62-547c-9147-5325c3f65733@xenomai.org>
Date: Wed, 6 Mar 2019 18:52:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190305144521.2567-7-roman.stratiienko@globallogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org


Hi,

On 3/5/19 3:45 PM, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>  .travis.yml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0807760f4..ab23b745d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -46,6 +46,11 @@ script:
>  
>  matrix:
>    include:
> +    - env:
> +      - ARCH: arm
> +        KERNEL_VERSION: 5.0
> +        KERNEL_DEFCONFIG: multi_v7_defconfig
> +        IPIPE_URL: https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/v5.0-draft1/ipipe-arm-v5.0-draft.patch
>      - env:
>        - ARCH: arm
>          KERNEL_VERSION: 4.20.7
> 

I'm looking at [1] ATM, assuming this is where the patch above came from:

> 2a4faac5245b ipipe: kconfig: fix missing quotes

This is ARM stuff which should go to [2], where the latest ARM port of
the pipeline lives. Nitpicking: "arm/ipipe: kconfig: ..." would match
the current convention for the shortlog.

> 5231f75b1e8e Create readme.md

Do we need a separate file mentioning this info (compared to adding it
to a commit log)?

> 2d82784ecaad Fix uild

This is adapting the stm32 chip for IRQ pipeling, we did not have that
one fixed up yet, nice. This is material for [2] as well. However, some
changes are missing for this to work as expected:

- ipipe_handle_demuxed_irq should be substituted to generic_handle_irq,
to push the incoming IRQ stream from this device to the pipeline entry.
Otherwise nasty things may happen. Because this is a chained interrupt
decoded from a primary vector, we use the demuxed_irq form, otherwise we
would have used the plain domain_irq form.

- gc->chip_types->chip.flags should be or'ed with IRQCHIP_PIPELINE_SAFE.
This tells the genirq core that this irqchip is fine with interrupt
pipelining.

> 835db6f1c35e Fix build

This won't be enough for enabling the pipeline with this broadcom chip.
generic_handle_irq should be replaced by ipipe_handle_demuxed_irq in
brcmstb_l2_intc_irq_handle(). Also, taking the descriptor lock there in
case of bad irq is a no-go. This is a regular spinlock, we can take it
from a code running the low-level IRQ handling for the pipeline.

> 06b790f344cc Build fix
> 0b6098a739be Build fix

I'm unsure where the patched code came from, the original stuff from [1]
looks ok, and needs no patching.

> 461360fe54d1 travis: add .travis.yml

No issue to have that in the mainline I-pipe tree if you need so.

> d458d8321d83 Build Fixes

This commit should be be split, explaining the rationale for the changes
such as those to the TSC emulation code.

[1] https://github.com/devel-opi/linux-ipipe-arm-porting/tree/v5.0-draft2
[2] https://gitlab.denx.de/Xenomai/ipipe-arm

-- 
Philippe.

