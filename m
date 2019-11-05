MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 5 Nov 2019 15:18:35 +0100
Message-ID: <CAFc1U0vzFoBeKNEU-dVjGVGgHTZZTbO46RN4u_afi5O8H-JBRw@mail.gmail.com>
Subject: UDD example for Pi 3 (GPIO / IRQ)
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi all,

I try to write a simple UDD example for Raspberry Pi 3 in order to control
a led (GPIO out) and button (GPIO in, IRQ). Example is based on
https://xenomai.org/pipermail/xenomai/2017-February/037121.html (by
Philippe !).
It works fine for GPIO out (led is blinking)  but I can't get IRQ event
from user space (ioctl from UDD driver seems not to be not called).

# ./xenomai_udd_rpi_gpio
Using GPIO 4 and period 100000000 ns
IRQ thread starting
thread_irq: fd= 0
failed to enable signotify (-1)
failed to enable interrupt (-1)

It works fine in kernel space, irq_handler() function is registered and
called.

# cat /proc/xenomai/irq

  IRQ         CPU0        CPU1        CPU2        CPU3

   17:        1573        1587        1769         770         [timer/0]

  183:           0           0           0           0         rpi_gpio

 1032:           0           0           0           0         [sync]

 1033:           0           1           1           1         [timer-ipi]

 1034:           0           1           1           1         [reschedule]

 1035:           0           0           0           0         [virtual]

 1039:           0           0          17           0         [virtual]

# [  174.350733] Got IRQ !

[  174.437832] Got IRQ !

Source code is available from GitHub.

https://github.com/pficheux/xenomai_examples

Any Idea?

Thx by advance.

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
