From: Jean-Pascal JULIEN <jean-pascal.julien@insiteo.com>
Date: Tue, 22 May 2012 13:52:27 +0200
Message-ID: <C7408997F5B0784C970ED53C11855FAE011112339161@INSITEOSBS01.insiteo.local>
References: <4FBADE7D.5030609@bbn.com>,<4FBB4951.5070803@xenomai.org>
	<C7408997F5B0784C970ED53C11855FAE01111233915D@INSITEOSBS01.insiteo.local>,
	<4FBB5393.5040003@xenomai.org>
In-Reply-To: <4FBB5393.5040003@xenomai.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE : RE : A possible mis-interaction between
 CONFIG_PREEMPT and GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,

I have tested the new patch but i have the same result.
i have a logic analyzer who monitored the irq and the answer to the irq.
Below two  acquisitions with response latency higher than 1ms :

       ******       ******       ******       ******       ******       ***=
***
******       ******       ******       ******       ******       ******    =
   ****** the irq input on GPIO (2KHz)

       *****************        ***********               ************     =
           first acquisition
******                      ******              ************               =
*********** the toggle of the output GPIO on IRQ


       ***********************        ***********               ***********=
*        second acquisition
******                             ******              ************        =
       ****** the toggle of the output GPIO on IRQ

My irq on the linux space is : (cat /proc/interrupts).
         CPU0
  7:       6005        INTC  TWL4030-PIH
 11:          0        INTC  prcm
 12:      84772        INTC  DMA
 25:          4        INTC  OMAP DSS
 38:     589982        INTC  gp timer
 56:     138661        INTC  omap_i2c
 61:       1015        INTC  omap_i2c
 72:          3        INTC  serial idle
 73:          0        INTC  serial idle
 74:        280        INTC  serial idle, OMAP UART2
 77:          0        INTC  ehci_hcd:usb2
 83:      31139        INTC  mmc0
 86:         26        INTC  mmc1
 92:          0        INTC  musb-hdrc
 93:          0        INTC  musb-hdrc
336:     291209        GPIO  eth0
371:          0     twl4030  twl4030_madc
378:          0     twl4030  twl4030_usb
379:       6005     twl4030  rtc0

My irq in the xenomai space are: (cat /proc/xenomai/irq).
IRQ         CPU0
 38:      603343         [timer]
307:     2956569         XENO_IRQ_RECEIVE
418:           0         [virtual]


What kind of test do you need, for help me to solve my problem?

Thanks.

JP


