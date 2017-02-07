References: <1486421551-31257-1-git-send-email-dmitriy@mperpetuo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3b4ebffe-e114-1c35-72e9-3fab0c962981@xenomai.org>
Date: Tue, 7 Feb 2017 11:32:34 +0100
MIME-Version: 1.0
In-Reply-To: <1486421551-31257-1-git-send-email-dmitriy@mperpetuo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: add missing drivers to genpatches
 script for arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>, xenomai@xenomai.org

On 02/06/2017 11:52 PM, Dmitriy Cherkasov wrote:
> This adds the clocksource and GIC drivers to the arm64 patch.
> ---
>  scripts/ipipe/genpatches.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
> index 07b6cf3..e2846a4 100755
> --- a/scripts/ipipe/genpatches.sh
> +++ b/scripts/ipipe/genpatches.sh
> @@ -107,6 +107,9 @@ BEGIN {
>  
>      driver_arch["tty/serial/amba-pl011.c"]="arm64"
>      driver_arch["gpio/gpio-pl061.c"]="arm64"
> +    driver_arch["clocksource/arm_arch_timer.c"]="arm64"
> +    driver_arch["irqchip/irq-gic.c"]="arm64"
> +    driver_arch["irqchip/irq-gic-v3.c"]="arm64"
>  
>      driver_arch["tty/serial/bfin_uart.c"]="blackfin"
>  
> 

This patch would break the ARM32 side. This is an associative array
shared by all archs. The logic of genpatches.sh needs significant rework
for handling the case of driver code shared by multiple archs.

-- 
Philippe.

