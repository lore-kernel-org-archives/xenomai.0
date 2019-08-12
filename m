Subject: Re: [PATCH] loopback: Prepend module name to log messages
References: <1565550426-4788-1-git-send-email-lists.tormod@gmail.com>
 <1565550426-4788-2-git-send-email-lists.tormod@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2419948f-c2c2-3006-b203-15eaadf6916b@siemens.com>
Date: Mon, 12 Aug 2019 21:07:10 +0200
MIME-Version: 1.0
In-Reply-To: <1565550426-4788-2-git-send-email-lists.tormod@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Tormod Volden <lists.tormod@gmail.com>, xenomai@xenomai.org

On 11.08.19 21:07, Tormod Volden via Xenomai wrote:
> From: Tormod Volden <debian.tormod@gmail.com>
> 
> Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
> ---
>   kernel/drivers/net/drivers/loopback.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/loopback.c b/kernel/drivers/net/drivers/loopback.c
> index ef5323a..ebfcf5c 100644
> --- a/kernel/drivers/net/drivers/loopback.c
> +++ b/kernel/drivers/net/drivers/loopback.c
> @@ -18,6 +18,9 @@
>    * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>    */
>   
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/printk.h>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
> @@ -93,7 +96,7 @@ static int __init loopback_init(void)
>       int err;
>       struct rtnet_device *rtdev;
>   
> -    printk("initializing loopback...\n");
> +    pr_info("initializing loopback interface...\n");
>   
>       if ((rtdev = rt_alloc_etherdev(0, 1)) == NULL)
>   	return -ENODEV;
> @@ -129,7 +132,7 @@ static void __exit loopback_cleanup(void)
>   {
>       struct rtnet_device *rtdev = rt_loopback_dev;
>   
> -    printk("removing loopback...\n");
> +    pr_info("removing loopback interface...\n");
>   
>       rt_unregister_rtnetdev(rtdev);
>       rt_rtdev_disconnect(rtdev);
> 

Thanks, applied both to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

