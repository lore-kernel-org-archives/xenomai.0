From: steve freyder <steve@freyder.net>
Subject: 3.1 rt_imx_uart.c regression
Message-ID: <752a846a-bd43-299d-53e7-ee7b7a864a53@freyder.net>
Date: Sun, 9 Feb 2020 19:28:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Xenomai group.


We appear to have a regression in the rt_imx_uart driver in Xenomai 
3.1.  The problem didn't exist in 3.0.7, and I believe it did exist in 
3.0.10.  Between those two I did not try to narrow it down.  I 
discovered this when connecting a UART on a 3.1 system to a UART on a 
3.0.7 system, both being IMX6 Dual-Lite SOM's, and the cross-connected 
UARTs would not intercommunicate (100% framing errors).  A simple TX/RX 
loopback test on either system was successful, but the cross-connect 
(like cross-link.c might use) was unsuccessful with a mixed 3.0.7 <--> 
3.1 environment.


I traced this to the setting (or not setting) of the UCR2_SRST bit in 
the rt_imx_uart_set_config() routine.  The IMX6 TRM defines this bit as 
SRST_B (B as in 'bar' as in inverted) and so setting this bit means *no 
software reset", so not setting it results in a software reset, which 
results in leaving the UART clock divisors at default and the resulting 
rate is 80mhz.  The user-selected (via ioctl()) baud rate and other 
parameters therefore have no effect.


The patch below fixes this problem.  I hope I have the proper format.


There may be another "benign" issue with this driver, but I would defer 
that to someone more familiar with it.  Specifically, it's with the 
routine rt_imx_uart_setup_ufcr(), whose function appears to be 
duplicated in rt_imx_uart_set_config().  In the driver init, 
rt_imx_uart_setup_ufcr() is called after the call to 
rt_imx_uart_set_config(), but in another place it is not called after 
the set_config() call.  I think rt_imx_uart_setup_ufcr() should be 
removed along with the call to it during initialization but the patch 
below does not include that mod.


Finally, the fact that this made it through testing brings up the test 
methodology for UART driver validation as concerns "character timing".  
With this kind of bug, simple loopback tests probably pass.  In a short 
test program that I built, I had code to read the nanosecond clock 
before initiating transmission, and then again after reception 
completed, and displaying the delta time.  Using that, the problem 
showed itself immediately (the delta ns for transmission of a single 
character was between 40K and 100K, much too fast given my 
ioctl(SET_CONFIG) had requested 9600 baud).  I wonder if it's worth 
adding a similar check to the testing logic.


Best regards,

Steve



======================================================================================

diff --git a/kernel/drivers/serial/rt_imx_uart.c 
b/kernel/drivers/serial/rt_imx_uart.c
index 2b27b7d..6894c1c 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -703,9 +703,9 @@ static int rt_imx_uart_set_config(struct 
rt_imx_uart_ctx *ctx,
                 uint64_t tdiv64;

                 if (ctx->config.data_bits == RTSER_8_BITS)
-                       ucr2 = UCR2_WS | UCR2_IRTS;
+                       ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
                 else
-                       ucr2 = UCR2_IRTS;
+                       ucr2 = UCR2_SRST | UCR2_IRTS;

                 if (ctx->config.handshake == RTSER_RTSCTS_HAND) {
                         if (port->have_rtscts) {

======================================================================================


