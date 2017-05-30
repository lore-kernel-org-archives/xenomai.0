References: <46850988-a862-b747-f11d-1191f7e13458@cs.ru.nl>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cb912c40-1247-6395-9a84-a3203dd5f022@xenomai.org>
Date: Tue, 30 May 2017 19:30:58 +0200
MIME-Version: 1.0
In-Reply-To: <46850988-a862-b747-f11d-1191f7e13458@cs.ru.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi
 2 (or 3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Harco Kuppens <h.kuppens@cs.ru.nl>, xenomai@xenomai.org

On 05/30/2017 06:38 PM, Harco Kuppens wrote:
> So I decided to also  test these wiringpi test programs on mine build
> xenomai 3 image for the rpi2. Unfortunately the isr.c wiringpi program
> didn't work anymore on mine build image. So even without using xenomai3,
> but just using linux the pi2 just hangs and a hard reset was needed.
> 
> Thus I guess there is still something wrong with mine image?
> Does anybody know what I'm doing wrong?
> Or is this still a bug in the gpio library or in the patches applied?
> 

It looks obvious that you tried hard and got your feet wet with Xenomai
already, so let's go straight to the point: the lockup issue when using
GPIO interrupts is most likely due to the I-pipe patch not properly
adapting the GPIO chip driver for dealing with IRQ virtualization.

In short, each IRQ controller which may be active on a SoC must be
driven by I-pipe aware code. For instance, the bcm2835 family has common
GPIOs controlled by the driver at drivers/pinctrl/pinctrl-bcm2835.c. If
that driver has not been patched specifically for supporting the IRQ
pipeline, then this won't work with Xenomai, and may well end up with
painful IRQ storms causing a machine hang. The same goes for any other
chip serving as an IRQ controller you might need on your platform.

So, first and foremost, I would recommend to make sure the I-pipe code
is right for your kernel, then build on top of that. A good way to
figure out which IRQ controllers are active is look at the output of
/proc/interrupts on a kernel that disables the interrupt pipeline.
Each IRQ information mentions the label of the controller which deals
with it. With that information, you need to cross-check whether the
corresponding IRQ chip driver (the one that bears this label in the
irq_chip descriptor structure) was made I-pipe aware.

Some time ago, I ported Xenomai 3 to the PI Zero (kernel 4.1.18), which
is based on the bcm2835 SoC like the PI 1 series. That code is available
from the vendors/raspberry/ipipe-4.1 branch at
git://git.xenomai.org/ipipe.git. This may be a good starting point, at
least for testing with a PI 1, before working on the required fixups for
supporting other Broadcom SoCs.

IIRC, RPI 2B and RPI 3 are based on the bcm2836, bcm2837 SoCs resp.,
which are not covered by the port just mentioned. You may find some
preliminary I-pipe related changes in the bcm2836 core interrupt support
code, but those have never been tested. By preliminary, I mean that
there is likely a few more IRQ controllers to make I-pipe aware on these
SoCs, aside of testing the initial changes.

Bottom line: using a stock I-pipe patch is unlikely to work out of the
box. The fact that such patch does support several SoCs equipped with
Cortex A7/A9 CPUs is by no mean a guarantee that all Cortex-based SoCs
are supported by the same code.

-- 
Philippe.

