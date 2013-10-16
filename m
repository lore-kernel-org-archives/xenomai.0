Message-ID: <525E8BE5.4070609@cantastic.org>
Date: Wed, 16 Oct 2013 14:51:49 +0200
From: Ralf Roesch <xenomai@cantastic.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>
	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>
	<525E7D85.9020307@xenomai.org> <525E81CD.6000603@steinkuehler.net>
	<525E8665.8000705@steinkuehler.net>
In-Reply-To: <525E8665.8000705@steinkuehler.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On Wed Oct 16 2013 14:28:21 GMT+0200, Charles Steinkuehler 
<charles@steinkuehler.net>  wrote:
> On 10/16/2013 7:08 AM, Charles Steinkuehler wrote:
>> On 10/16/2013 6:50 AM, Gilles Chanteperdrix wrote:
>>> Ok, so the MMC irq is a gpio irq. And its counter is 0, which does not
>>> seem to be normal if the root filesystem in on MMC. Is it 0 too when
>>> you boot an unpatched kernel?
>>>
>>> Do you run a vanilla kernel or a vendor kernel with additional patches
>>> to drivers/gpio/gpio-omap.c, or maybe a beaglebone specific GPIO
>>> driver in drivers/gpio ?
>> It's a BeagleBone specific kernel with a list of patches as long as my
>> arm...and I have pretty long arms!
>>
>> https://github.com/cdsteinkuehler/linux-dev/blob/3.8.13-bone28-xenomai/patch.sh
>>
>> I'm not sure about the GPIO interrupt.  I'll see what happens with the
>> non-xenomai kernel, and review the board setup.
> Both the BeagleBone and the Xenomai kernels behave the same way.  The
> GPIO mmc interrupt is stuck at zero, and the 80: INTC mmc interrupt
> count increases on access to the filesystem.
>
I have the same issue here (xenomai 3.8.13 bone28 patched kernel).
My file system works out from the BBB onboard flash. I have no SD card 
in use, nor plugged in.
I assume that this mode has no card detect function.
MMC1 interrupts are increased on file system access.

root@arm:~# cat /proc/interrupts
            CPU0
  23:          2      INTC  tps65217
  28:       3633      INTC  edma
  30:          0      INTC  edma_error
  34:          0      INTC  musb-hdrc.0.auto
  35:          1      INTC  musb-hdrc.1.auto
  36:          0      INTC  pruss_evt0
  37:          0      INTC  pruss_evt1
  38:          0      INTC  pruss_evt2
  39:          0      INTC  pruss_evt3
  40:          0      INTC  pruss_evt4
  41:          0      INTC  pruss_evt5
  42:          0      INTC  pruss_evt6
  43:          0      INTC  pruss_evt7
  44:      12085      INTC  mmc1
  46:         96      INTC  4819c000.i2c
  52:          0      INTC  tilcdc
  56:          0      INTC  4a100000.ethernet
  57:     104628      INTC  4a100000.ethernet
  58:        153      INTC  4a100000.ethernet
  59:          0      INTC  4a100000.ethernet
  80:          0      INTC  mmc0
  83:     477814      INTC  gp_timer
  86:      21786      INTC  44e0b000.i2c
  88:     362463      INTC  OMAP UART0
  91:          0      INTC  rtc0
  92:          0      INTC  rtc0
125:          0      INTC  53100000.sham
150:          0      GPIO  mmc0
IPI0:          0  CPU wakeup interrupts
IPI1:          0  Timer broadcast interrupts
IPI2:          0  Rescheduling interrupts
IPI3:          0  Function call interrupts
IPI4:          0  Single function call interrupts
IPI5:          0  CPU stop interrupts
Err:          0

--
Ralf

