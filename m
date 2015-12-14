References: <44cb82ce.15337.151812ff429.Coremail.ericvic@163.com>
 <20151208112320.GA24418@hermes.click-hack.org>
 <5d8dd3ae.5ccc.1519e440866.Coremail.ericvic@163.com>
 <20151214064253.GC7035@hermes.click-hack.org>
 <653fe8d9.f6c1.1519f7e1ec0.Coremail.ericvic@163.com>
 <20151214080316.GB27298@hermes.click-hack.org>
 <613bbb7c.109f7.1519f9cec39.Coremail.ericvic@163.com>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <566E8611.7030205@sigmatek.at>
Date: Mon, 14 Dec 2015 10:04:17 +0100
MIME-Version: 1.0
In-Reply-To: <613bbb7c.109f7.1519f9cec39.Coremail.ericvic@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Compileerror rt_imx_uart.c on kernel 3.10.53 ARM
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear All,

when I activated the serial realtime driver 
(CONFIG_XENO_DRIVERS_IMX_UART) in my kernel 3.10.53
I get the following compile errors.

drivers/xenomai/serial/rt_imx_uart.c: In function 'rt_imx_uart_probe':

drivers/xenomai/serial/rt_imx_uart.c:2032:20: error: 'struct imxuart_platform_data' has no member named 'init'

   if (pdata && pdata->init) {

                     ^

drivers/xenomai/serial/rt_imx_uart.c:2033:14: error: 'struct imxuart_platform_data' has no member named 'init'

    err = pdata->init(pdev);

               ^

drivers/xenomai/serial/rt_imx_uart.c:2095:20: error: 'struct imxuart_platform_data' has no member named 'exit'

   if (pdata && pdata->exit)

                     ^

drivers/xenomai/serial/rt_imx_uart.c:2096:8: error: 'struct imxuart_platform_data' has no member named 'exit'

    pdata->exit(pdev);

         ^

drivers/xenomai/serial/rt_imx_uart.c: In function 'rt_imx_uart_remove':

drivers/xenomai/serial/rt_imx_uart.c:2126:20: error: 'struct imxuart_platform_data' has no member named 'exit'

   if (pdata && pdata->exit)

                     ^

drivers/xenomai/serial/rt_imx_uart.c:2127:8: error: 'struct imxuart_platform_data' has no member named 'exit'

    pdata->exit(pdev);



I found out that in kernel 3.10.53 the function pointer to exit and init 
function in struct imxuart_platform_data is missing.

I tried to find a newer version of rt_imx_uart.c in xenomai 3.0 but the 
file is the same.

Do you have any idea how to fix this ?

Kind regards
Wolfgang

