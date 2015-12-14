Date: Mon, 14 Dec 2015 23:48:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151214224850.GG16627@hermes.click-hack.org>
References: <44cb82ce.15337.151812ff429.Coremail.ericvic@163.com>
 <20151208112320.GA24418@hermes.click-hack.org>
 <5d8dd3ae.5ccc.1519e440866.Coremail.ericvic@163.com>
 <20151214064253.GC7035@hermes.click-hack.org>
 <653fe8d9.f6c1.1519f7e1ec0.Coremail.ericvic@163.com>
 <20151214080316.GB27298@hermes.click-hack.org>
 <613bbb7c.109f7.1519f9cec39.Coremail.ericvic@163.com>
 <566E8611.7030205@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566E8611.7030205@sigmatek.at>
Subject: Re: [Xenomai] Compileerror rt_imx_uart.c on kernel 3.10.53 ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: xenomai@xenomai.org

On Mon, Dec 14, 2015 at 10:04:17AM +0100, Wolfgang Netbal wrote:
> Dear All,
> 
> when I activated the serial realtime driver 
> (CONFIG_XENO_DRIVERS_IMX_UART) in my kernel 3.10.53
> I get the following compile errors.
> 
> drivers/xenomai/serial/rt_imx_uart.c: In function 'rt_imx_uart_probe':
> 
> drivers/xenomai/serial/rt_imx_uart.c:2032:20: error: 'struct imxuart_platform_data' has no member named 'init'
> 
>    if (pdata && pdata->init) {
> 
>                      ^
> 
> drivers/xenomai/serial/rt_imx_uart.c:2033:14: error: 'struct imxuart_platform_data' has no member named 'init'
> 
>     err = pdata->init(pdev);
> 
>                ^
> 
> drivers/xenomai/serial/rt_imx_uart.c:2095:20: error: 'struct imxuart_platform_data' has no member named 'exit'
> 
>    if (pdata && pdata->exit)
> 
>                      ^
> 
> drivers/xenomai/serial/rt_imx_uart.c:2096:8: error: 'struct imxuart_platform_data' has no member named 'exit'
> 
>     pdata->exit(pdev);
> 
>          ^
> 
> drivers/xenomai/serial/rt_imx_uart.c: In function 'rt_imx_uart_remove':
> 
> drivers/xenomai/serial/rt_imx_uart.c:2126:20: error: 'struct imxuart_platform_data' has no member named 'exit'
> 
>    if (pdata && pdata->exit)
> 
>                      ^
> 
> drivers/xenomai/serial/rt_imx_uart.c:2127:8: error: 'struct imxuart_platform_data' has no member named 'exit'
> 
>     pdata->exit(pdev);
> 
> 
> 
> I found out that in kernel 3.10.53 the function pointer to exit and init 
> function in struct imxuart_platform_data is missing.
> 
> I tried to find a newer version of rt_imx_uart.c in xenomai 3.0 but the 
> file is the same.
> 
> Do you have any idea how to fix this ?

Maybe the file is adapted to newer kernel versions? Such as Linux
3.14 or Linux 3.18 ?

Please try, if you want to answer a random mail, to remove any
reference-to or in-reply-to header, so that your mail does not
appear in a middle of an unrelated thread. Look at the mess you have
done here:
https://xenomai.org/pipermail/xenomai/2015-December/thread.html

-- 
					    Gilles.
https://click-hack.org

