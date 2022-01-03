Message-ID: <23a27bc9-495a-08af-7349-00b6ff25c53d@siemens.com>
Date: Mon, 3 Jan 2022 14:14:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Added verbosity to 16550A serial driver.
Content-Language: en-US
References: <20211217080346.56416-1-ksmola51@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20211217080346.56416-1-ksmola51@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantin Smola <ksmola51@gmail.com>, xenomai@xenomai.org

On 17.12.21 09:03, Konstantin Smola via Xenomai wrote:
> Added verbosity to 16550A serial driver. dmesg shows the driver version, ports, irqs, baudbase.
> Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
> ---
>  kernel/drivers/serial/16550A.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
> index c9274fb19..4e896c6ff 100644
> --- a/kernel/drivers/serial/16550A.c
> +++ b/kernel/drivers/serial/16550A.c
> @@ -25,12 +25,19 @@
>  #include <rtdm/serial.h>
>  #include <rtdm/driver.h>
>  
> -MODULE_DESCRIPTION("RTDM-based driver for 16550A UARTs");
> +
> +#define MOD_DESCR "RTDM-based driver for 16550A UARTs"
> +static char mod_descr[64] = MOD_DESCR;
> +#define MOD_VER "1.5.2"
> +static char mod_ver[32]=MOD_VER;
> +
> +MODULE_DESCRIPTION(MOD_DESCR);
>  MODULE_AUTHOR("Jan Kiszka <jan.kiszka@web.de>");
> -MODULE_VERSION("1.5.2");
> +MODULE_VERSION(MOD_VER);
>  MODULE_LICENSE("GPL");
>  
>  #define RT_16550_DRIVER_NAME	"xeno_16550A"
> +static char mod_name[64]=RT_16550_DRIVER_NAME;
>  
>  #define MAX_DEVICES		8
>  
> @@ -1106,6 +1113,8 @@ int __init rt_16550_init(void)
>  	if (!rtdm_available())
>  		return -ENODEV;
>  
> +	rtdm_printk("%s: %s rev %s\n", mod_name, mod_descr, mod_ver);
> +

Not suitable for upstream as explained in the other thread.

>  	rt_16550_pnp_init();
>  	rt_16550_pci_init();
>  
> @@ -1128,6 +1137,8 @@ int __init rt_16550_init(void)
>  		name = (char *)(dev + 1);
>  		ksformat(name, RTDM_MAX_DEVNAME_LEN, dev->label, i);
>  
> +		rtdm_printk("%s: %s io=0x%x irq=%d baud_base=%d\n", mod_name, name, (unsigned)rt_16550_base_addr(i),irq[i],baud_base[i]);
> +

This is fine, analog to what Linux dumps.

But the line is overlong (>80).

>  		err = rt_16550_init_io(i, name);
>  		if (err)
>  			goto kfree_out;
> @@ -1182,6 +1193,7 @@ void rt_16550_exit(void)
>  
>  	rt_16550_pci_cleanup();
>  	rt_16550_pnp_cleanup();
> +	rtdm_printk("%s: Unloaded.\n", mod_name);

Nope, too verbose. Fine as local change while debugging.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

