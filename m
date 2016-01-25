From: Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>
Message-ID: <56A65100.8000207@basystemes.fr>
Date: Mon, 25 Jan 2016 17:44:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] rt_imx_uart compilation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I tried to compile linux kernel 3.18.12 with xenomai 2.6.4 and rtserial 
enabled on arm imx6. The compilation failed with :
   CC [M]  drivers/xenomai/serial/rt_imx_uart.o
drivers/xenomai/serial/rt_imx_uart.c:39:27: fatal error: 
mach/hardware.h: No such file or directory
  #include <mach/hardware.h>
                            ^

I can see in the file :
#include <mach/hardware.h>
#include <mach/imx-uart.h>

The requested file seem to be in arch/arm/mach-imx/hardware.h and 
imx-uart.h in arch/arm/include/debug/imx-uart.h so i tried to correct 
the path with :
#include <../mach-imx/hardware.h>
#include <debug/imx-uart.h>

The compilation failed with :

   CC [M]  drivers/xenomai/serial/rt_imx_uart.o
drivers/xenomai/serial/rt_imx_uart.c: In function 'rt_imx_uart_probe':
drivers/xenomai/serial/rt_imx_uart.c:1465:21: error: dereferencing 
pointer to incomplete type
   if (pdata && (pdata->flags & IMXUART_HAVE_RTSCTS))
                      ^
drivers/xenomai/serial/rt_imx_uart.c:1465:31: error: 
'IMXUART_HAVE_RTSCTS' undeclared (first use in this function)
   if (pdata && (pdata->flags & IMXUART_HAVE_RTSCTS))
                                ^
drivers/xenomai/serial/rt_imx_uart.c:1465:31: note: each undeclared 
identifier is reported only once for each function it appears in
drivers/xenomai/serial/rt_imx_uart.c:1467:21: error: dereferencing 
pointer to incomplete type
   if (pdata && (pdata->flags & IMXUART_USE_DCEDTE))
                      ^
drivers/xenomai/serial/rt_imx_uart.c:1467:31: error: 
'IMXUART_USE_DCEDTE' undeclared (first use in this function)
   if (pdata && (pdata->flags & IMXUART_USE_DCEDTE))
                                ^
drivers/xenomai/serial/rt_imx_uart.c:1469:20: error: dereferencing 
pointer to incomplete type
   if (pdata && pdata->init) {
                     ^
drivers/xenomai/serial/rt_imx_uart.c:1470:14: error: dereferencing 
pointer to incomplete type
    err = pdata->init(pdev);
               ^
drivers/xenomai/serial/rt_imx_uart.c:1489:20: error: dereferencing 
pointer to incomplete type
   if (pdata && pdata->exit)
                     ^
drivers/xenomai/serial/rt_imx_uart.c:1490:8: error: dereferencing 
pointer to incomplete type
    pdata->exit(pdev);
         ^
drivers/xenomai/serial/rt_imx_uart.c: In function 'rt_imx_uart_remove':
drivers/xenomai/serial/rt_imx_uart.c:1520:20: error: dereferencing 
pointer to incomplete type
   if (pdata && pdata->exit)
                     ^
drivers/xenomai/serial/rt_imx_uart.c:1521:8: error: dereferencing 
pointer to incomplete type
    pdata->exit(pdev);
         ^

Do you have an idea ?


Jean-Baptiste Trédez

