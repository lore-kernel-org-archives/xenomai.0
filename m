Date: Wed, 8 Feb 2017 10:08:17 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170208100817.327a247b@md1em3qc>
In-Reply-To: <1486516444-9669-1-git-send-email-dmitriy@mperpetuo.com>
References: <3b4ebffe-e114-1c35-72e9-3fab0c962981@xenomai.org>
 <1486516444-9669-1-git-send-email-dmitriy@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] ipipe: fix genpatches script for arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Cc: xenomai@xenomai.org

Hi,

looks to me like it should be two patches. The first one introducing
multiarch and the second using it for arm64.

Henning

On Tue, 7 Feb 2017 15:14:04 -1000
Dmitriy Cherkasov <dmitriy@mperpetuo.com> wrote:

> Previous versions of genpatches.sh only allow one architecture
> per driver. Since some drivers are shared between arm and arm64,
> this adds new functionality to the script, allowing multiple
> architectures to be specified per driver as a space-separated list.
> ---
>  scripts/ipipe/genpatches.sh | 37
> +++++++++++++++++++++++++++++-------- 1 file changed, 29
> insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
> index 9392a41..3714c1b 100755
> --- a/scripts/ipipe/genpatches.sh
> +++ b/scripts/ipipe/genpatches.sh
> @@ -62,7 +62,6 @@ BEGIN {
>      driver_arch["iommu/irq_remapping.c"]="noarch"
>  
>      driver_arch["clk/mxs/clk-imx28.c"]="arm"
> -    driver_arch["clocksource/arm_arch_timer.c"]="arm"
>      driver_arch["clocksource/mxs_timer.c"]="arm"
>      driver_arch["clocksource/arm_global_timer.c"]="arm"
>      driver_arch["clocksource/pxa_timer.c"]="arm"
> @@ -81,7 +80,6 @@ BEGIN {
>      driver_arch["irqchip/spear-shirq.c"]="arm"
>      driver_arch["irqchip/irq-mxs.c"]="arm"
>      driver_arch["irqchip/irq-s3c24xx.c"]="arm"
> -    driver_arch["irqchip/irq-gic.c"]="arm"
>      driver_arch["irqchip/irq-vic.c"]="arm"
>      driver_arch["irqchip/irq-atmel-aic.c"]="arm"
>      driver_arch["irqchip/irq-atmel-aic5.c"]="arm"
> @@ -89,7 +87,6 @@ BEGIN {
>      driver_arch["irqchip/irq-bcm7120-l2.c"]="arm"
>      driver_arch["irqchip/irq-brcmstb-l2.c"]="arm"
>      driver_arch["irqchip/irq-dw-apb-ictl.c"]="arm"
> -    driver_arch["irqchip/irq-gic-v3.c"]="arm"
>      driver_arch["irqchip/irq-sunxi-nmi.c"]="arm"
>      driver_arch["irqchip/irq-crossbar.c"]="arm"
>      driver_arch["mfd/twl4030-irq.c"]="arm"
> @@ -105,6 +102,10 @@ BEGIN {
>      driver_arch["pinctrl/pinctrl-single.c"]="arm"
>      driver_arch["tty/serial/xilinx_uartps.c"]="arm"
>  
> +    driver_arch["irqchip/irq-gic.c"]="arm arm64"
> +    driver_arch["irqchip/irq-gic-v3.c"]="arm arm64"
> +    driver_arch["clocksource/arm_arch_timer.c"]="arm arm64"
> +
>      driver_arch["tty/serial/amba-pl011.c"]="arm64"
>      driver_arch["gpio/gpio-pl061.c"]="arm64"
>  
> @@ -123,6 +124,7 @@ match($0, /^diff --git a\/arch\/([^ \t\/]*)/) {
>      split(substr($0, RSTART, RLENGTH), arch, /\//)
>      a=arch[3]
>  
> +    is_multiarch=0
>      set_current_arch(a)
>      print $0 >> current_file
>      next
> @@ -137,14 +139,25 @@ match($0, /^diff --git a\/drivers\/([^ \t]*)/) {
>  	 print "Error unknown architecture for driver "f
>  	 unknown_file_error=1
>      } else {
> -	 a = driver_arch[f]
> -	 set_current_arch(a)
> -	 print $0 >> current_file
> -	 next
> +        a = driver_arch[f]
> +        if(index(a, " ")) {
> +            is_multiarch = 1
> +            split(a, multiarch, " ")
> +            for(a in multiarch) {
> +                set_current_arch(multiarch[a])
> +                print $0 >> current_file
> +            }
> +        } else {
> +            is_multiarch = 0
> +            set_current_arch(a)
> +            print $0 >> current_file
> +        }
> +        next
>      }
>  }
>  
>  /^diff --git a\/scripts\/ipipe\/genpatches.sh/ {
> +    is_multiarch=0
>      if (splitmode == "no") {
>  	current_file="/dev/null"
>  	current_arch="nullarch"
> @@ -154,6 +167,7 @@ match($0, /^diff --git a\/drivers\/([^ \t]*)/) {
>  
>  /^diff --git/ {
>      set_current_arch("noarch")
> +    is_multiarch=0
>      print $0 >> current_file
>      next
>  }
> @@ -164,7 +178,14 @@ match ($0, /#define
> [I]PIPE_CORE_RELEASE[ \t]*([^ \t]*)/) { }
>  
>  {
> -    print $0 >> current_file
> +    if(is_multiarch) {
> +        for(a in multiarch) {
> +            set_current_arch(multiarch[a])
> +            print $0 >> current_file
> +        }
> +    } else {
> +        print $0 >> current_file
> +    }
>  }
>  
>  END {


