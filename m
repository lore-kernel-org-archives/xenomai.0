MIME-Version: 1.0
References: <CAFc1U0vzFoBeKNEU-dVjGVGgHTZZTbO46RN4u_afi5O8H-JBRw@mail.gmail.com>
 <0881ee04-8cd4-b817-0475-b39daf939d90@xenomai.org>
In-Reply-To: <0881ee04-8cd4-b817-0475-b39daf939d90@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 5 Nov 2019 17:13:43 +0100
Message-ID: <CAFc1U0t6VHGiKGzL6ytHsXi0wAebWeX1bbq8MBScBJKjVnRBnw@mail.gmail.com>
Subject: Re: UDD example for Pi 3 (GPIO / IRQ)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Thx a lot, "trust does not exclude control" (if using code from an
intern...) -:))

regards

Le mar. 5 nov. 2019 =C3=A0 15:54, Philippe Gerum <rpm@xenomai.org> a =C3=A9=
crit :

> On 2019-11-05 15:18, Pierre FICHEUX via Xenomai wrote:
> > Hi all,
> >
> > I try to write a simple UDD example for Raspberry Pi 3 in order to
> control
> > a led (GPIO out) and button (GPIO in, IRQ). Example is based on
> > https://xenomai.org/pipermail/xenomai/2017-February/037121.html (by
> > Philippe !).
> > It works fine for GPIO out (led is blinking)  but I can't get IRQ event
> > from user space (ioctl from UDD driver seems not to be not called).
> >
> > # ./xenomai_udd_rpi_gpio
> > Using GPIO 4 and period 100000000 ns
> > IRQ thread starting
> > thread_irq: fd=3D 0
> > failed to enable signotify (-1)
> > failed to enable interrupt (-1)
> >
> > It works fine in kernel space, irq_handler() function is registered and
> > called.
> >
> > # cat /proc/xenomai/irq
> >
> >   IRQ         CPU0        CPU1        CPU2        CPU3
> >
> >    17:        1573        1587        1769         770         [timer/0=
]
> >
> >   183:           0           0           0           0         rpi_gpio
> >
> >  1032:           0           0           0           0         [sync]
> >
> >  1033:           0           1           1           1
>  [timer-ipi]
> >
> >  1034:           0           1           1           1
>  [reschedule]
> >
> >  1035:           0           0           0           0         [virtual=
]
> >
> >  1039:           0           0          17           0         [virtual=
]
> >
> > # [  174.350733] Got IRQ !
> >
> > [  174.437832] Got IRQ !
> >
> > Source code is available from GitHub.
> >
> > https://github.com/pficheux/xenomai_examples
> >
> > Any Idea?
> >
>
> More coffee, louder rock, glasses with stronger correction for all of us,
> old cranky meatballs:
>
> -  if ((fd =3D open("/dev/rtdm/rpi_gpio", O_RDWR) < 0)) {
> +  if ((fd =3D open("/dev/rtdm/rpi_gpio", O_RDWR)) < 0) {
>
> --
> Philippe.
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
