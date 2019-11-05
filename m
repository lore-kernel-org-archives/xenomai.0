Subject: Re: UDD example for Pi 3 (GPIO / IRQ)
References: <CAFc1U0vzFoBeKNEU-dVjGVGgHTZZTbO46RN4u_afi5O8H-JBRw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0881ee04-8cd4-b817-0475-b39daf939d90@xenomai.org>
Date: Tue, 5 Nov 2019 15:54:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAFc1U0vzFoBeKNEU-dVjGVGgHTZZTbO46RN4u_afi5O8H-JBRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>

On 2019-11-05 15:18, Pierre FICHEUX via Xenomai wrote:
> Hi all,
> 
> I try to write a simple UDD example for Raspberry Pi 3 in order to control
> a led (GPIO out) and button (GPIO in, IRQ). Example is based on
> https://xenomai.org/pipermail/xenomai/2017-February/037121.html (by
> Philippe !).
> It works fine for GPIO out (led is blinking)  but I can't get IRQ event
> from user space (ioctl from UDD driver seems not to be not called).
> 
> # ./xenomai_udd_rpi_gpio
> Using GPIO 4 and period 100000000 ns
> IRQ thread starting
> thread_irq: fd= 0
> failed to enable signotify (-1)
> failed to enable interrupt (-1)
> 
> It works fine in kernel space, irq_handler() function is registered and
> called.
> 
> # cat /proc/xenomai/irq
> 
>   IRQ         CPU0        CPU1        CPU2        CPU3
> 
>    17:        1573        1587        1769         770         [timer/0]
> 
>   183:           0           0           0           0         rpi_gpio
> 
>  1032:           0           0           0           0         [sync]
> 
>  1033:           0           1           1           1         [timer-ipi]
> 
>  1034:           0           1           1           1         [reschedule]
> 
>  1035:           0           0           0           0         [virtual]
> 
>  1039:           0           0          17           0         [virtual]
> 
> # [  174.350733] Got IRQ !
> 
> [  174.437832] Got IRQ !
> 
> Source code is available from GitHub.
> 
> https://github.com/pficheux/xenomai_examples
> 
> Any Idea?
> 

More coffee, louder rock, glasses with stronger correction for all of us, old cranky meatballs:

-  if ((fd = open("/dev/rtdm/rpi_gpio", O_RDWR) < 0)) {
+  if ((fd = open("/dev/rtdm/rpi_gpio", O_RDWR)) < 0) {

-- 
Philippe.

