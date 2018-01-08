MIME-Version: 1.0
In-Reply-To: <ed68531e-57e3-3997-e81e-4593bdebff65@siemens.com>
References: <1515433793-12938-1-git-send-email-greg@embeddedgreg.com>
 <CALLqZ8RpDPvMfQG7wTjZhuvRn++Awb1gPrx7T4C3YeC46k5Q3g@mail.gmail.com>
 <ed68531e-57e3-3997-e81e-4593bdebff65@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 8 Jan 2018 16:09:04 -0500
Message-ID: <CALLqZ8TZwhv=DCAQ=h5Xf96cxDD7M1Wc6ZhycFt7aCwjjD5zkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [PATCH] Fix up the imx uart driver so it now compiles
	with new kernels.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Sounds good, I fixed up the patch and will submit it again.  There are
a couple of warnings from checkpath.pl still but I don't
think they need to be fixed up.  I can post the output if anyone would
like to see it.  I also had the original publisher wrong,
I fixed that up and added the sign off at the bottom.

Let me know if I missed anything.

Thanks

Greg

On Mon, Jan 8, 2018 at 1:03 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2018-01-08 18:52, Greg Gallagher wrote:
>> Hi,
>>  The patch I submitted was based on one that was submitted by Wolfgang
>> Netbal back in Feb
>>  2016.  The original thread that this patch was derived from is located here
>> https://xenomai.org/pipermail/xenomai/2016-February/035924.html
>>
>> Just wanted to make sure proper credit was given, I think I put this
>> info in the patch as well.
>
> Just write a commit message (which is desirable anyway) and mention the
> origin there. In case you barely changed the original version, you could
> also leave the original author in place by starting the body with "From:
> Author <email>" and then just mention your changes at the end of the log
> message (usually before your signed-off-by, but Xenomai does not enforce
> that protocol yet).
>
> Could you sort out the unrelated style changes? Preferred style is that
> of the kernel. The kernel has a checker (scripts/checkpatch.pl), which
> does not mean there can be sometimes exceptions, but it should not a
> guideline still.
>
> Thanks for picking this up!
> Jan
>
>>
>> -Greg
>>
>> On Mon, Jan 8, 2018 at 12:49 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>> ---
>>>  kernel/drivers/serial/rt_imx_uart.c | 299 ++++++++++++++++++++++++------------
>>>  1 file changed, 204 insertions(+), 95 deletions(-)
>>>
>>> diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
>>> index 092cecc..db63df6 100644
>>> --- a/kernel/drivers/serial/rt_imx_uart.c
>>> +++ b/kernel/drivers/serial/rt_imx_uart.c
>>> @@ -36,8 +36,10 @@
>>>  #include <asm/irq.h>
>>>  #include <asm/dma.h>
>>>  #include <asm/div64.h>
>>> -#include <mach/hardware.h>
>>> -#include <mach/imx-uart.h>
>>> +#include <linux/platform_data/serial-imx.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>>
>>>  #include <rtdm/serial.h>
>>>  #include <rtdm/driver.h>
>>> @@ -65,7 +67,10 @@ MODULE_LICENSE("GPL");
>>>  #define UBMR   0xa8 /* BRM Modulator Register */
>>>  #define UBRC   0xac /* Baud Rate Count Register */
>>>  #define MX2_ONEMS 0xb0 /* One Millisecond register */
>>> -#define UTS (cpu_is_mx1() ? 0xd0 : 0xb4) /* UART Test Register */
>>> +#define IMX1_UTS 0xd0 /* UART Test Register on i.mx1 */
>>> +#define IMX21_UTS 0xb4 /* UART Test Register on all other i.mx*/
>>> +
>>> +
>>>
>>>  /* UART Control Register Bit Fields.*/
>>>  #define URXD_CHARRDY   (1<<15)
>>> @@ -189,9 +194,25 @@ MODULE_LICENSE("GPL");
>>>  #define RT_IMX_UART_MAX                5
>>>
>>>  static int tx_fifo[RT_IMX_UART_MAX];
>>> -compat_module_param_array(tx_fifo, int, RT_IMX_UART_MAX, 0400);
>>> +module_param_array(tx_fifo, int, NULL, 0400);
>>>  MODULE_PARM_DESC(tx_fifo, "Transmitter FIFO size");
>>>
>>> +/* i.MX21 type uart runs on all i.mx except i.MX1 and i.MX6q */
>>> +enum imx_uart_type {
>>> +       IMX1_UART,
>>> +       IMX21_UART,
>>> +       IMX53_UART,
>>> +       IMX6Q_UART,
>>> +        IMX7D_UART,
>>> +};
>>> +
>>> +/* device type dependent stuff */
>>> +struct imx_uart_data {
>>> +       unsigned uts_reg;
>>> +       enum imx_uart_type devtype;
>>> +};
>>> +
>>> +
>>>  struct rt_imx_uart_port {
>>>         unsigned char __iomem *membase; /* read/write[bwl] */
>>>         resource_size_t mapbase;        /* for ioremap */
>>> @@ -200,11 +221,69 @@ struct rt_imx_uart_port {
>>>         unsigned int have_rtscts;
>>>         unsigned int use_dcedte;
>>>         unsigned int use_hwflow;
>>> -       struct clk *clk;                /* clock id for UART clock */
>>> -       unsigned int uartclk;           /* base uart clock */
>>> +       struct clk *clk_ipg;            /* clock id for UART clock */
>>> +       struct clk *clk_per;            /* clock id for UART clock */
>>> +        const struct imx_uart_data *devdata;
>>> +        unsigned int uartclk;          /* base uart clock */
>>>         struct rtdm_device rtdm_dev;    /* RTDM device structure */
>>>  };
>>>
>>> +
>>> +static struct imx_uart_data imx_uart_devdata[] = {
>>> +       [IMX1_UART] = {
>>> +               .uts_reg = IMX1_UTS,
>>> +               .devtype = IMX1_UART,
>>> +       },
>>> +       [IMX21_UART] = {
>>> +               .uts_reg = IMX21_UTS,
>>> +               .devtype = IMX21_UART,
>>> +       },
>>> +       [IMX53_UART] = {
>>> +               .uts_reg = IMX21_UTS,
>>> +               .devtype = IMX53_UART,
>>> +       },
>>> +       [IMX6Q_UART] = {
>>> +               .uts_reg = IMX21_UTS,
>>> +               .devtype = IMX6Q_UART,
>>> +       },
>>> +        [IMX7D_UART] = {
>>> +                .uts_reg = IMX21_UTS,
>>> +                .devtype = IMX7D_UART,
>>> +        },
>>> +};
>>> +
>>> +static const struct platform_device_id rt_imx_uart_id_table[] = {
>>> +        {
>>> +               .name = "imx1-uart",
>>> +               .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX1_UART],
>>> +       }, {
>>> +               .name = "imx21-uart",
>>> +               .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX21_UART],
>>> +       }, {
>>> +               .name = "imx53-uart",
>>> +               .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX53_UART],
>>> +       }, {
>>> +               .name = "imx6q-uart",
>>> +               .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX6Q_UART],
>>> +       }, {
>>> +                .name = "imx-uart",
>>> +                .driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX7D_UART],
>>> +        }, {
>>> +               /* sentinel */
>>> +       }
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, rt_imx_uart_id_table);
>>> +
>>> +static const struct of_device_id rt_imx_uart_dt_ids[] = {
>>> +       { .compatible = "fsl,imx7d-uart", .data = &imx_uart_devdata[IMX7D_UART], },
>>> +        { .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
>>> +       { .compatible = "fsl,imx53-uart", .data = &imx_uart_devdata[IMX53_UART], },
>>> +       { .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
>>> +       { .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
>>> +       { /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, rt_imx_uart_dt_ids);
>>> +
>>>  struct rt_imx_uart_ctx {
>>>         struct rtser_config config;     /* current device configuration */
>>>
>>> @@ -344,6 +423,7 @@ static int rt_imx_uart_rx_chars(struct rt_imx_uart_ctx *ctx,
>>>  static void rt_imx_uart_tx_chars(struct rt_imx_uart_ctx *ctx)
>>>  {
>>>         int ch, count;
>>> +        unsigned uts_reg = ctx->port->devdata->uts_reg;
>>>
>>>         for (count = ctx->port->tx_fifo;
>>>              (count > 0) && (ctx->out_npend > 0);
>>> @@ -352,7 +432,7 @@ static void rt_imx_uart_tx_chars(struct rt_imx_uart_ctx *ctx)
>>>                 writel(ch, ctx->port->membase + URTX0);
>>>                 ctx->out_head &= (OUT_BUFFER_SIZE - 1);
>>>
>>> -               if (readl(ctx->port->membase + UTS) & UTS_TXFULL)
>>> +               if (readl(ctx->port->membase + uts_reg) & UTS_TXFULL)
>>>                         break;
>>>         }
>>>  }
>>> @@ -493,9 +573,10 @@ static unsigned int rt_imx_uart_get_msr(struct rt_imx_uart_ctx *ctx)
>>>  static void rt_imx_uart_set_mcr(struct rt_imx_uart_ctx *ctx,
>>>                                 unsigned int mcr)
>>>  {
>>> -       unsigned long ucr2 = readl(ctx->port->membase + UCR2);
>>> +       unsigned uts_reg = ctx->port->devdata->uts_reg;
>>> +        unsigned long ucr2 = readl(ctx->port->membase + UCR2);
>>>         unsigned long ucr3 = readl(ctx->port->membase + UCR3);
>>> -       unsigned long uts = readl(ctx->port->membase + UTS);
>>> +       unsigned long uts = readl(ctx->port->membase + uts_reg);
>>>
>>>         if (mcr & RTSER_MCR_RTS) {
>>>                 /*
>>> @@ -523,7 +604,7 @@ static void rt_imx_uart_set_mcr(struct rt_imx_uart_ctx *ctx,
>>>                 uts |= UTS_LOOP;
>>>         else
>>>                 uts &= ~UTS_LOOP;
>>> -       writel(uts, ctx->port->membase + UTS);
>>> +       writel(uts, ctx->port->membase + uts_reg);
>>>  }
>>>
>>>  static void rt_imx_uart_break_ctl(struct rt_imx_uart_ctx *ctx,
>>> @@ -723,7 +804,7 @@ static int rt_imx_uart_setup_ufcr(struct rt_imx_uart_port *port)
>>>          * RFDIV is set such way to satisfy requested uartclk value
>>>          */
>>>         val = TXTL << 10 | RXTL;
>>> -       ufcr_rfdiv = (clk_get_rate(port->clk) + port->uartclk / 2) /
>>> +       ufcr_rfdiv = (clk_get_rate(port->clk_per) + port->uartclk / 2) /
>>>                 port->uartclk;
>>>
>>>         if (!ufcr_rfdiv)
>>> @@ -897,7 +978,7 @@ static int rt_imx_uart_ioctl(struct rtdm_fd *fd,
>>>                 }
>>>
>>>                 if ((config->config_mask & RTSER_SET_BAUD) &&
>>> -                   (config->baud_rate > clk_get_rate(ctx->port->clk) / 16 ||
>>> +                   (config->baud_rate > clk_get_rate(ctx->port->clk_per) / 16 ||
>>>                      config->baud_rate <= 0))
>>>                         /* invalid baudrate for this port */
>>>                         return -EINVAL;
>>> @@ -1382,42 +1463,96 @@ static struct rtdm_driver imx_uart_driver = {
>>>         },
>>>  };
>>>
>>> +
>>> +#ifdef CONFIG_OF
>>> +
>>> +/*
>>> + * This function returns 1 iff pdev isn't a device instatiated by dt, 0 iff it
>>> + * could successfully get all information from dt or a negative errno.
>>> + */
>>> +static int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
>>> +                                struct platform_device *pdev)
>>> +{
>>> +        struct device_node *np = pdev->dev.of_node;
>>> +        const struct of_device_id *of_id =
>>> +                        of_match_device(rt_imx_uart_dt_ids, &pdev->dev);
>>> +        int ret;
>>> +
>>> +        if (!np)
>>> +                /* no device tree device */
>>> +                return 1;
>>> +
>>> +        ret = of_alias_get_id(np, "serial");
>>> +        if (ret < 0) {
>>> +                dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
>>> +                return ret;
>>> +        }
>>> +
>>> +       pdev->id = ret;
>>> +
>>> +        if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
>>> +                port->have_rtscts = 1;
>>> +        if (of_get_property(np, "fsl,irda-mode", NULL))
>>> +                dev_warn(&pdev->dev, "IRDA not yet supported\n");
>>> +
>>> +        if (of_get_property(np, "fsl,dte-mode", NULL))
>>> +               port->use_dcedte = 1;
>>> +
>>> +        port->devdata = of_id->data;
>>> +
>>> +        return 0;
>>> +}
>>> +#else
>>> +static inline int rt_imx_uart_probe_dt(struct rt_imx_uart_port *port,
>>> +                                       struct platform_device *pdev)
>>> +{
>>> +        return 1;
>>> +}
>>> +#endif
>>> +
>>> +static void rt_imx_uart_probe_pdata(struct rt_imx_uart_port *port,
>>> +                                    struct platform_device *pdev)
>>> +{
>>> +        struct imxuart_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>> +
>>> +        port->devdata = (struct imx_uart_data  *) pdev->id_entry->driver_data;
>>> +
>>> +        if (!pdata)
>>> +                return;
>>> +
>>> +        if (pdata->flags & IMXUART_HAVE_RTSCTS)
>>> +                port->have_rtscts = 1;
>>> +}
>>> +
>>>  static int rt_imx_uart_probe(struct platform_device *pdev)
>>>  {
>>> -       struct imxuart_platform_data *pdata;
>>>         struct rtdm_device *dev;
>>>         struct rt_imx_uart_port *port;
>>>         struct resource *res;
>>> -       int err;
>>> +       int ret;
>>>
>>> -       port = kzalloc(sizeof(*port), GFP_KERNEL);
>>> +       port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
>>>         if (!port)
>>>                 return -ENOMEM;
>>>
>>> +        ret = rt_imx_uart_probe_dt(port, pdev);
>>> +        if (ret > 0)
>>> +                rt_imx_uart_probe_pdata(port, pdev);
>>> +        else if (ret < 0)
>>> +                return ret;
>>> +
>>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> -       if (!res) {
>>> -               err = -ENODEV;
>>> -               goto kfree_out;
>>> -       }
>>> -       port->mapbase = res->start;
>>> +       if (!res)
>>> +               return -ENODEV;
>>>
>>>         port->irq = platform_get_irq(pdev, 0);
>>> -       if (port->irq <= 0) {
>>> -               err = -ENODEV;
>>> -               goto kfree_out;
>>> -       }
>>>
>>> -       if (!request_mem_region(port->mapbase, PAGE_SIZE, DRIVER_NAME)) {
>>> -               err = -EBUSY;
>>> -               goto kfree_out;
>>> -       }
>>> -
>>> -       port->membase = ioremap(port->mapbase, PAGE_SIZE);
>>> -       if (!port->membase) {
>>> -               err = -ENOMEM;
>>> -               goto release_mem_region_out;
>>> -       }
>>> +        if (port->irq <= 0)
>>> +               return -ENODEV;
>>>
>>> +       port->membase = devm_ioremap_resource(&pdev->dev, res);
>>> +       if (IS_ERR(port->membase))
>>> +               return PTR_ERR(port->membase);
>>>
>>>         dev = &port->rtdm_dev;
>>>         dev->driver = &imx_uart_driver;
>>> @@ -1429,54 +1564,31 @@ static int rt_imx_uart_probe(struct platform_device *pdev)
>>>         else
>>>                 port->tx_fifo = tx_fifo[pdev->id];
>>>
>>> -       port->clk = clk_get(&pdev->dev, "uart");
>>> -       if (IS_ERR(port->clk)) {
>>> -               err = PTR_ERR(port->clk);
>>> -               goto iounmap_out;
>>> -       }
>>> -       clk_enable(port->clk);
>>> -       port->uartclk = clk_get_rate(port->clk);
>>> +       port->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>>> +       if (IS_ERR(port->clk_ipg))
>>> +               return PTR_ERR(port->clk_ipg);
>>>
>>> -       port->use_hwflow = 1;
>>> +        port->clk_per = devm_clk_get(&pdev->dev, "per");
>>> +       if (IS_ERR(port->clk_per))
>>> +               return PTR_ERR(port->clk_per);
>>>
>>> -       pdata = pdev->dev.platform_data;
>>> -       if (pdata && (pdata->flags & IMXUART_HAVE_RTSCTS))
>>> -               port->have_rtscts = 1;
>>> -       if (pdata && (pdata->flags & IMXUART_USE_DCEDTE))
>>> -               port->use_dcedte = 1;
>>> -       if (pdata && pdata->init) {
>>> -               err = pdata->init(pdev);
>>> -               if (err)
>>> -                       goto clk_disable_out;
>>> -       }
>>> +       clk_enable(port->clk_ipg);
>>> +       clk_enable(port->clk_per);
>>> +       port->uartclk = clk_get_rate(port->clk_per);
>>> +
>>> +       port->use_hwflow = 1;
>>>
>>> -       err = rtdm_dev_register(dev);
>>> -       if (err)
>>> -               goto pdata_exit_out;
>>> +        ret = rtdm_dev_register(dev);
>>> +       if (ret)
>>> +               return ret;
>>>
>>>         platform_set_drvdata(pdev, port);
>>>
>>>         printk(KERN_INFO
>>> -              "%s on IMX UART%d: membase=0x%p mapbase=%#x irq=%d uartclk=%d\n",
>>> -              dev->name, pdev->id, port->membase, (u32)port->mapbase,
>>> -              port->irq, port->uartclk);
>>> -
>>> -       return 0;
>>> -
>>> -pdata_exit_out:
>>> -       if (pdata && pdata->exit)
>>> -               pdata->exit(pdev);
>>> -clk_disable_out:
>>> -       clk_put(port->clk);
>>> -       clk_disable(port->clk);
>>> -iounmap_out:
>>> -       iounmap(port->membase);
>>> -release_mem_region_out:
>>> -       release_mem_region(port->mapbase, SZ_4K);
>>> -kfree_out:
>>> -       kfree(port);
>>> -
>>> -       return err;
>>> +              "%s on IMX UART%d: membase=0x%p irq=%d uartclk=%d\n",
>>> +              dev->name, pdev->id, port->membase, port->irq, port->uartclk);
>>> +
>>> +        return 0;
>>>  }
>>>
>>>  static int rt_imx_uart_remove(struct platform_device *pdev)
>>> @@ -1490,26 +1602,9 @@ static int rt_imx_uart_remove(struct platform_device *pdev)
>>>
>>>         rtdm_dev_unregister(dev);
>>>
>>> -       if (port->clk) {
>>> -               clk_put(port->clk);
>>> -               clk_disable(port->clk);
>>> -       }
>>> -
>>> -       if (pdata && pdata->exit)
>>> -               pdata->exit(pdev);
>>> -
>>> -       iounmap(port->membase);
>>> -       release_mem_region(port->mapbase, PAGE_SIZE);
>>> -       kfree(port);
>>> -
>>> -       return 0;
>>> +        return 0;
>>>  }
>>>
>>> -static const struct platform_device_id rt_imx_uart_id_table[] = {
>>> -       {"imx-uart",},
>>> -       {},
>>> -};
>>> -
>>>  static struct platform_driver rt_imx_uart_driver = {
>>>         .probe = rt_imx_uart_probe,
>>>         .remove = rt_imx_uart_remove,
>>> @@ -1517,15 +1612,29 @@ static struct platform_driver rt_imx_uart_driver = {
>>>         .driver = {
>>>                 .name = DRIVER_NAME,
>>>                 .owner = THIS_MODULE,
>>> +                .of_match_table = rt_imx_uart_dt_ids,
>>>         },
>>> +        .prevent_deferred_probe = true,
>>>  };
>>>
>>> +
>>>  static int __init rt_imx_uart_init(void)
>>>  {
>>> -       if (!realtime_core_enabled())
>>> +        int ret;
>>> +
>>> +        if (!realtime_core_enabled())
>>>                 return 0;
>>>
>>> -       return platform_driver_register(&rt_imx_uart_driver);
>>> +
>>> +       ret = platform_driver_register(&rt_imx_uart_driver);
>>> +        if (ret) {
>>> +                printk(KERN_ERR
>>> +                        "%s; Could not register  driver (err=%d)\n",
>>> +                       __func__, ret);
>>> +
>>> +        }
>>> +
>>> +        return ret;;
>>>  }
>>>
>>>  static void __exit rt_imx_uart_exit(void)
>>> --
>>> 2.7.4
>>>
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

