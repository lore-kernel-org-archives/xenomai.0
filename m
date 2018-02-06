References: <1517890199-26957-1-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <aa7d8c40-cfbb-08a5-a19e-c1c98c0398e5@xenomai.org>
Date: Tue, 6 Feb 2018 10:23:14 +0100
MIME-Version: 1.0
In-Reply-To: <1517890199-26957-1-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] fixes for rpi 2b build
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 02/06/2018 05:09 AM, Greg Gallagher wrote:
> Small fix ups to enable building multi_v7_defconfig
> ---
>   drivers/gpio/gpio-mvebu.c          |  1 +
>   drivers/gpio/gpio-pl061.c          |  1 +
>   drivers/gpio/gpio-zynq.c           |  2 +-
>   drivers/irqchip/irq-atmel-aic5.c   |  6 ++++--
>   drivers/irqchip/irq-bcm7120-l2.c   | 15 +++++++++------
>   drivers/irqchip/irq-brcmstb-l2.c   | 10 ++++++----
>   drivers/irqchip/irq-dw-apb-ictl.c  |  1 +
>   drivers/pinctrl/pinctrl-rockchip.c |  8 ++++----
>   drivers/soc/dove/pmu.c             |  1 +
>   9 files changed, 28 insertions(+), 17 deletions(-)
> 

Merged, thanks.

-- 
Philippe.

