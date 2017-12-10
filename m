References: <1512791435-4231-1-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <782badb7-2d33-b750-4ceb-7c8821bf81fe@xenomai.org>
Date: Sun, 10 Dec 2017 17:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <1512791435-4231-1-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Fix up name collision,
	debug is already defined
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 12/09/2017 04:50 AM, Greg Gallagher wrote:
> ---
> When compiling for x86 and enabling experimental intel net drivers I ran
> into a compilation error where debug was defined previously.  Rename the 
> debug variable to avoid the collision.
> 
> ---
>  kernel/drivers/net/drivers/experimental/e1000/e1000_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
> index 66ecfce..acdc13c 100644
> --- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
> +++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
> @@ -421,9 +421,9 @@ module_param_array(cards, int, NULL, 0444);
>  MODULE_PARM_DESC(cards, "array of cards to be supported (eg. 1,0,1)");
>  
>  
> -static int debug = NETIF_MSG_DRV | NETIF_MSG_PROBE;
> -module_param(debug, int, 0);
> -MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
> +static int local_debug = NETIF_MSG_DRV | NETIF_MSG_PROBE;
> +module_param(local_debug, int, 0);
> +MODULE_PARM_DESC(local_debug, "Debug level (0=none,...,16=all)");
>  
>  /* The parameter 'pciif' might be used to use this driver for
>   * PCI or PCIe only NICs.
> @@ -1096,7 +1096,7 @@ static int e1000_probe(struct pci_dev *pdev,
>  	adapter->netdev = netdev;
>  	adapter->pdev = pdev;
>  	adapter->hw.back = adapter;
> -	adapter->msg_enable = (1 << debug) - 1;
> +	adapter->msg_enable = (1 << local_debug) - 1;
>  
>  	err = -EIO;
>  	adapter->hw.hw_addr = ioremap(pci_resource_start(pdev, BAR_0),
> 

Merged, thanks.

-- 
Philippe.

