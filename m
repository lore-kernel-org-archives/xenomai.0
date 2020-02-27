MIME-Version: 1.0
In-Reply-To: <CALLqZ8Q9BQKXRDOGd1i7hAa32c5BzZpWixX+m3oV_nBh7ZeEwQ@mail.gmail.com>
References: <CAPm8-H6oDc4NogRLTFvi7-9vOv=a2OGE=fiRib1yUEOyR-rsAQ@mail.gmail.com>
 <CALLqZ8Qa1+WLUQHw7woNOJZGgjmhkjms+QYLpT9ggnD47XsUog@mail.gmail.com>
 <CAPm8-H6rz3ArzOcYas1mQyYfw-njGfQwZGriQz3Hrg5MdU9+vg@mail.gmail.com>
 <CALLqZ8TtxHc-hsqkKMx2iX1_GZftFOEFnLSYH37UJVs4d5VM8A@mail.gmail.com>
 <CALLqZ8S6jvvU0xp+bb19uMVnFP9AS7=KSn1XugsBShU78YVM-A@mail.gmail.com>
 <86518a45-5c2d-3322-da91-fe0f248d0253@siemens.com>
 <CAPm8-H7REC_UQ2GV7aJbj1+Wx2dNiAL-67W8sjYk+a_Y5Ur6EA@mail.gmail.com>
 <CAPm8-H4U06gsNqQLVKHgyAzUcEcg7fJv48UR7uvM2jfjzQx+bA@mail.gmail.com>
 <CALLqZ8Rq7Ar5=KMgkYNaVOMHyp08yTPvGdShQTLb=E3OSU061Q@mail.gmail.com>
 <CAPm8-H7foEfOFTHTFwG1iDp-eUdH6=e-tGrEDC28ony-0WXdvQ@mail.gmail.com>
 <CAPm8-H7gUZGKbYG9L-fhoGndzN3fcPhqQ9WuJ7cP=HDVPNemSA@mail.gmail.com>
 <CALLqZ8Ts5sApS5JjOKVY3DLyShJzBzd2FNRZYBQ0y5u2MiBAUg@mail.gmail.com>
 <CALLqZ8TObDwBbmu_ijwi7Mis38JquYqO2f1TorNWBt5qyk+FoQ@mail.gmail.com>
 <CALLqZ8Q=GqLpdxBAoPLqyniySKG8w_CeBJp1PW+KtB=1H8OEtg@mail.gmail.com>
 <CAPm8-H6=F0eFKxvwYQbCmb8pK9rfq9Y2L2W3+96hPH96m81-kw@mail.gmail.com>
 <CALLqZ8Q9BQKXRDOGd1i7hAa32c5BzZpWixX+m3oV_nBh7ZeEwQ@mail.gmail.com>
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Thu, 27 Feb 2020 15:34:00 +0200
Message-ID: <CAPm8-H45=N-u-YNvLowaogfgCVkgTFks7sqo+5X6Nq=F7Rb+sg@mail.gmail.com>
Subject: Re: system freeze - beaglebone black xenomai - gpio interrupts driver
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
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>

Hi,

  Good job. It works now.
I will do more testing and will let you know.

Thanks!

On 2/24/20, Greg Gallagher <greg@embeddedgreg.com> wrote:
> Hi,
>
> On Sat, Feb 8, 2020 at 6:56 AM Laurentiu-Cristian Duca
> <laurentiu.duca@gmail.com> wrote:
>>
>> Hello there
>>
>>   Greg, any news?
>>
>> Thanks
>>
>> On 1/31/20, Greg Gallagher <greg@embeddedgreg.com> wrote:
>> > Hey,
>> >
>> > On Wed, Jan 29, 2020 at 11:58 AM Greg Gallagher <greg@embeddedgreg.com=
>
>> > wrote:
>> >>
>> >> Hey,
>> >>
>> >> On Wed, Jan 29, 2020 at 12:07 AM Greg Gallagher
>> >> <greg@embeddedgreg.com>
>> >> wrote:
>> >> >
>> >> > Hi,
>> >> >
>> >> > On Tue, Jan 28, 2020 at 7:37 AM Laurentiu-Cristian Duca
>> >> > <laurentiu.duca@gmail.com> wrote:
>> >> > >
>> >> > > Again, to make things clear:
>> >> > > I have tested two modules: one with RTDM gpio-interrupts and one
>> >> > > with
>> >> > > classic linux interrupts.
>> >> > > The one with RTDM gpio-interrupts:
>> >> > > - makes kernel freeze on 4.14.71 and 4.19.82 ipipe-enabled kernel=
s
>> >> > > - works (but with ipipe warnings when interrupt arrives) in 4.4.7=
1
>> >> > > and
>> >> > > 4.9.51
>> >> > > The one with classic linux interrupts:
>> >> > > - works in PREEMPT_RT linux (tested on 5.4.5 and 4.19.59
>> >> > > PREEMPT_RT
>> >> > > non-ipipe non-xenomai)
>> >> > > - makes kernel freeze when interrupt arrives on 4.14.71 and
>> >> > > 4.19.82
>> >> > > for xenomai ipipe enabled kernels
>> >> > >
>> >> > > On 1/28/20, Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
>> >> > > wrote:
>> >> > > > This does not happen with non-ipipe enabled kernels.
>> >> > > > I have tested a classic gpio-interrupt module on PREEMPT_RT and
>> >> > > > it
>> >> > > > works,
>> >> > > > but when I tested it on an ipipe-enabled kernel (4.14.71 and
>> >> > > > 4.19.82)
>> >> > > > got kernel freeze.
>> >> > > >
>> >> > > > On 1/28/20, Greg Gallagher <greg@embeddedgreg.com> wrote:
>> >> > > >> On Tue, Jan 28, 2020 at 7:11 AM Laurentiu-Cristian Duca <
>> >> > > >> laurentiu.duca@gmail.com> wrote:
>> >> > > >>
>> >> > > >>> I forgot to say that I've tested 4.14.71 with xenomai 3.0.9
>> >> > > >>>
>> >> > > >>> On 1/28/20, Laurentiu-Cristian Duca <laurentiu.duca@gmail.com=
>
>> >> > > >>> wrote:
>> >> > > >>> > Hello Jan and friends,
>> >> > > >>> >
>> >> > > >>> > The situation is the following for bbb:
>> >> > > >>> > - 4.14.71 and 4.19.82 xenomai-3 master enabled kernels
>> >> > > >>> > freeze when trying to use gpio-interrupts;
>> >> > > >>> > when interrupt comes the gpioout is toggled but the system
>> >> > > >>> > do not respond anymore to keyboard and nothing more is show=
n
>> >> > > >>> > on
>> >> > > >>> > the
>> >> > > >>> screen
>> >> > > >>> > - note that even if I try a classic (linux only,
>> >> > > >>> > non-xenomai)
>> >> > > >>
>> >> > > >> This happens even with non-ipipe enables kernels?
>> >> > > >
>> >> > > >>
>> >> > > >>
>> >> > > >>> > gpio interrupt handler in 4.19.82 with xenomai-3
>> >> > > >>> > the system freeze when interrupt comes
>> >> > > >>> > - 4.9.51 and 4.4.71 xenomai 3.0.5 enabled kernels work
>> >> > > >>> > blinking gpioout and do not block,
>> >> > > >>> > but both show warnings when interrupt comes
>> >> > > >>> > which significantly increase interrupt latency.
>> >> > > >>> >
>> >> > > >>> >
>> >> > > >>> > On 1/28/20, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> >> > > >>> >> On 24.01.20 07:24, Greg Gallagher via Xenomai wrote:
>> >> > > >>> >>> I sent a patch offline, if you could try it that would be
>> >> > > >>> >>> great.
>> >> > > >>> >>> I'm
>> >> > > >>> >>> having issues getting my board set up.
>> >> > > >>> >>>
>> >> > > >>> >>
>> >> > > >>> >> Do we know by now if this is an I-pipe issue or rather
>> >> > > >>> >> something
>> >> > > >>> >> cobalt-related?
>> >> > > >>> >>
>> >> > > >>> >> Jan
>> >> > > >>> >>
>> >> > > >>> >>> On Thu, Jan 23, 2020 at 1:13 PM Greg Gallagher
>> >> > > >>> >>> <greg@embeddedgreg.com>
>> >> > > >>> >>> wrote:
>> >> > > >>> >>>>
>> >> > > >>> >>>> Hi,
>> >> > > >>> >>>>
>> >> > > >>> >>>> On Thu, Jan 23, 2020 at 12:15 PM Laurentiu-Cristian Duca
>> >> > > >>> >>>> <laurentiu.duca@gmail.com> wrote:
>> >> > > >>> >>>>>
>> >> > > >>> >>>>> Hi, the interrupt comes one per second in my test, so
>> >> > > >>> >>>>> there
>> >> > > >>> >>>>> is no
>> >> > > >>> >>>>> flood.
>> >> > > >>> >>>>> In 4.19 the system it blinks the gpioout but it does no=
t
>> >> > > >>> >>>>> respond
>> >> > > >>> >>>>> to
>> >> > > >>> >>>>> keyboard and does not show anything more on the screen.
>> >> > > >>> >>>>
>> >> > > >>> >>>> Okay, there's a couple things that are different between
>> >> > > >>> >>>> 4.4
>> >> > > >>> >>>> and
>> >> > > >>> >>>> 4.19
>> >> > > >>> >>>> that I'm looking into, which is taking me a little long
>> >> > > >>> >>>> then
>> >> > > >>> >>>> I
>> >> > > >>> >>>> thought.  I won't have this patch ready till tomorrow
>> >> > > >>> >>>> morning.  I
>> >> > > >>> >>>> finally have beaglebone black hardware, I'll make sure
>> >> > > >>> >>>> the
>> >> > > >>> >>>> kernel
>> >> > > >>> >>>> boots and then send the patch to you for testing.
>> >> > > >>> >>>>
>> >> > > >>> >>>> -Greg
>> >> > > >>> >>>>
>> >> > > >>> >>>>
>> >> > > >>> >>>>>
>> >> > > >>> >>>>> On Thu, Jan 23, 2020, 19:03 Greg Gallagher
>> >> > > >>> >>>>> <greg@embeddedgreg.com>
>> >> > > >>> >>>>> wrote:
>> >> > > >>> >>>>>>
>> >> > > >>> >>>>>> Hi,
>> >> > > >>> >>>>>>
>> >> > > >>> >>>>>> On Thu, Jan 23, 2020 at 9:21 AM Laurentiu-Cristian Duc=
a
>> >> > > >>> >>>>>> via
>> >> > > >>> >>>>>> Xenomai
>> >> > > >>> >>>>>> <xenomai@xenomai.org> wrote:
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> Hello xenomai community,
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      I have successfully tested in xenomai SPI with
>> >> > > >>> >>>>>>> interrupts
>> >> > > >>> >>>>>>> on
>> >> > > >>> >>>>>>> bbb.
>> >> > > >>> >>>>>>> However, on bbb, if I try to test a basic gpio
>> >> > > >>> >>>>>>> interrupts
>> >> > > >>> >>>>>>> driver,
>> >> > > >>> >>>>>>> problems appear.
>> >> > > >>> >>>>>>>      Please see details below. I appreciate any idea.
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> 1. xenomai-3 master linux 4.19.82, default dts
>> >> > > >>> >>>>>>> # insmod xeno_osc-gpio-rtdm.ko
>> >> > > >>> >>>>>>> [  105.582245]  IRQ number 62 !
>> >> > > >>> >>>>>>> [  105.585976] after request irq =3D 62
>> >> > > >>> >>>>>>> System freeze when first interrupt occurs and I must
>> >> > > >>> >>>>>>> power
>> >> > > >>> >>>>>>> off.
>> >> > > >>> >>>>>> Is it possible to use raw_printk and see if the system
>> >> > > >>> >>>>>> is
>> >> > > >>> >>>>>> still
>> >> > > >>> >>>>>> working but possibly getting flooded by interrupts?
>> >> > > >>> >>>>>> When
>> >> > > >>> >>>>>> I
>> >> > > >>> >>>>>> encountered this issue with the BCM2835 port I placed =
a
>> >> > > >>> >>>>>> raw_printk
>> >> > > >>> in
>> >> > > >>> >>>>>> one of the functions that initially handles the
>> >> > > >>> >>>>>> interrupt
>> >> > > >>> >>>>>> to see
>> >> > > >>> >>>>>> if
>> >> > > >>> >>>>>> it
>> >> > > >>> >>>>>> was being ack'd.
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> 2. xenomai 3.0.5 linux 4.4.71, default dts
>> >> > > >>> >>>>>>> # insmod xeno_osc-gpio-rtdm.ko
>> >> > > >>> >>>>>>> [   39.901907]  IRQ number 142 !
>> >> > > >>> >>>>>>> [   39.905447] after request irq =3D 142
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> When first interrupt occurs:
>> >> > > >>> >>>>>>> [  322.104560] irq 142, desc: df15e500, depth: 1,
>> >> > > >>> >>>>>>> count:
>> >> > > >>> >>>>>>> 0,
>> >> > > >>> >>>>>>> unhandled:
>> >> > > >>> >>>>>>> 0
>> >> > > >>> >>>>>>> [  322.111310] ->handle_irq():  c00998b4,
>> >> > > >>> >>>>>>> handle_edge_irq+0x0/0x168
>> >> > > >>> >>>>>>> [  322.117606] ->irq_data.chip(): df156710, 0xdf15671=
0
>> >> > > >>> >>>>>>> [  322.122702] ->action():   (null)
>> >> > > >>> >>>>>>> [  322.126067]    IRQ_NOPROBE set
>> >> > > >>> >>>>>>> [  322.129252] unexpected IRQ trap at vector 8e
>> >> > > >>> >>>>>>> [  322.133706] ------------[ cut here ]------------
>> >> > > >>> >>>>>>> [  322.138530] WARNING: CPU: 0 PID: 0 at
>> >> > > >>> >>>>>>> kernel/irq/chip.c:843
>> >> > > >>> >>>>>>> __ipipe_ack_bad_irq+0x24/0x3c()
>> >> > > >>> >>>>>>> [  322.147244] Modules linked in:
>> >> > > >>> >>>>>>> xeno_osc_gpio_rtdm(O)
>> >> > > >>> >>>>>>> [  322.152444] CPU: 0 PID: 0 Comm: swapper/0 Tainted:
>> >> > > >>> >>>>>>> G
>> >> > > >>> >>>>>>> O
>> >> > > >>> >>>>>>> 4.4.71-ipipe #1
>> >> > > >>> >>>>>>> [  322.160434] Hardware name: Generic AM33XX
>> >> > > >>> >>>>>>> (Flattened
>> >> > > >>> >>>>>>> Device
>> >> > > >>> Tree)
>> >> > > >>> >>>>>>> [  322.166791] I-pipe domain: Linux
>> >> > > >>> >>>>>>> [  322.170175] [<c0017bf4>] (unwind_backtrace) from
>> >> > > >>> >>>>>>> [<c0013d58>]
>> >> > > >>> >>>>>>> (show_stack+0x10/0x14)
>> >> > > >>> >>>>>>> [  322.178273] [<c0013d58>] (show_stack) from
>> >> > > >>> >>>>>>> [<c0368a0c>]
>> >> > > >>> >>>>>>> (dump_stack+0x9c/0xc4)
>> >> > > >>> >>>>>>> [  322.185829] [<c0368a0c>] (dump_stack) from
>> >> > > >>> >>>>>>> [<c003d168>]
>> >> > > >>> >>>>>>> (warn_slowpath_common+0x78/0xb4)
>> >> > > >>> >>>>>>> [  322.194280] [<c003d168>] (warn_slowpath_common)
>> >> > > >>> >>>>>>> from
>> >> > > >>> [<c003d240>]
>> >> > > >>> >>>>>>> (warn_slowpath_null+0x1c/0x24)
>> >> > > >>> >>>>>>> [  322.203455] [<c003d240>] (warn_slowpath_null) from
>> >> > > >>> >>>>>>> [<c00991a8>]
>> >> > > >>> >>>>>>> (__ipipe_ack_bad_irq+0x24/0x3c)
>> >> > > >>> >>>>>>> [  322.212542] [<c00991a8>] (__ipipe_ack_bad_irq) fro=
m
>> >> > > >>> >>>>>>> [<c00df9b4>]
>> >> > > >>> >>>>>>> (__ipipe_dispatch_irq+0x78/0x1d8)
>> >> > > >>> >>>>>>> [  322.221903] [<c00df9b4>] (__ipipe_dispatch_irq)
>> >> > > >>> >>>>>>> from
>> >> > > >>> [<c03a3948>]
>> >> > > >>> >>>>>>> (omap_gpio_irq_handler+0x134/0x1a4)
>> >> > > >>> >>>>>>> [  322.231532] [<c03a3948>] (omap_gpio_irq_handler)
>> >> > > >>> >>>>>>> from
>> >> > > >>> >>>>>>> [<c0095b1c>]
>> >> > > >>> >>>>>>> (handle_irq_event_percpu+0xa4/0x304)
>> >> > > >>> >>>>>>> [  322.241341] [<c0095b1c>] (handle_irq_event_percpu)
>> >> > > >>> >>>>>>> from
>> >> > > >>> >>>>>>> [<c0095db4>] (handle_irq_event+0x38/0x5c)
>> >> > > >>> >>>>>>> [  322.250605] [<c0095db4>] (handle_irq_event) from
>> >> > > >>> >>>>>>> [<c0099858>]
>> >> > > >>> >>>>>>> (handle_level_irq+0x88/0xe4)
>> >> > > >>> >>>>>>> [  322.259235] [<c0099858>] (handle_level_irq) from
>> >> > > >>> >>>>>>> [<c0095198>]
>> >> > > >>> >>>>>>> (generic_handle_irq+0x20/0x34)
>> >> > > >>> >>>>>>> [  322.268045] [<c0095198>] (generic_handle_irq) from
>> >> > > >>> >>>>>>> [<c009547c>]
>> >> > > >>> >>>>>>> (__handle_domain_irq+0x64/0xd4)
>> >> > > >>> >>>>>>> [  322.277127] [<c009547c>] (__handle_domain_irq) fro=
m
>> >> > > >>> >>>>>>> [<c00df228>]
>> >> > > >>> >>>>>>> (__ipipe_do_sync_stage+0x21c/0x25c)
>> >> > > >>> >>>>>>> [  322.286665] [<c00df228>] (__ipipe_do_sync_stage)
>> >> > > >>> >>>>>>> from
>> >> > > >>> >>>>>>> [<c00093e4>]
>> >> > > >>> >>>>>>> (__ipipe_grab_irq+0x5c/0x7c)
>> >> > > >>> >>>>>>> [  322.295753] [<c00093e4>] (__ipipe_grab_irq) from
>> >> > > >>> >>>>>>> [<c06462f4>]
>> >> > > >>> >>>>>>> (__irq_svc+0x54/0x60)
>> >> > > >>> >>>>>>> [  322.303745] Exception stack(0xc0937f58 to
>> >> > > >>> >>>>>>> 0xc0937fa0)
>> >> > > >>> >>>>>>> [  322.309017] 7f40:
>> >> > > >>> >>>>>>>      00000000 df91d240
>> >> > > >>> >>>>>>> [  322.317556] 7f60: 00000000 00000000 c092e240
>> >> > > >>> >>>>>>> c0938a24
>> >> > > >>> >>>>>>> 00000000
>> >> > > >>> >>>>>>> c09f4c3c c09389c4 00000001
>> >> > > >>> >>>>>>> [  322.326095] 7f80: c064d88c 00000000 00000000
>> >> > > >>> >>>>>>> c0937fa8
>> >> > > >>> >>>>>>> c0080f04
>> >> > > >>> >>>>>>> c00df35c 60000013 ffffffff
>> >> > > >>> >>>>>>> [  322.334634] [<c06462f4>] (__irq_svc) from
>> >> > > >>> >>>>>>> [<c00df35c>]
>> >> > > >>> >>>>>>> (ipipe_unstall_root+0x38/0x50)
>> >> > > >>> >>>>>>> [  322.342822] [<c00df35c>] (ipipe_unstall_root) from
>> >> > > >>> >>>>>>> [<c0080f04>]
>> >> > > >>> >>>>>>> (cpu_startup_entry+0x68/0x2b8)
>> >> > > >>> >>>>>>> [  322.351826] [<c0080f04>] (cpu_startup_entry) from
>> >> > > >>> >>>>>>> [<c08b0c28>]
>> >> > > >>> >>>>>>> (start_kernel+0x370/0x3e8)
>> >> > > >>> >>>>>>> [  322.360361] ---[ end trace 3de49b4cee31ba0b ]---
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> When other interrupts occur:
>> >> > > >>> >>>>>>> [  322.365188] irq 142, desc: df15e500, depth: 1,
>> >> > > >>> >>>>>>> count:
>> >> > > >>> >>>>>>> 0,
>> >> > > >>> >>>>>>> unhandled:
>> >> > > >>> >>>>>>> 0
>> >> > > >>> >>>>>>> [  322.371908] ->handle_irq():  c00998b4,
>> >> > > >>> >>>>>>> handle_edge_irq+0x0/0x168
>> >> > > >>> >>>>>>> [  322.378183] ->irq_data.chip(): df156710, 0xdf15671=
0
>> >> > > >>> >>>>>>> [  322.383277] ->action():   (null)
>> >> > > >>> >>>>>>> [  322.386641]    IRQ_NOPROBE set
>> >> > > >>> >>>>>>> [  322.389825] unexpected IRQ trap at vector 8e
>> >> > > >>> >>>>>>> [  324.664939] irq 142, desc: df15e500, depth: 1,
>> >> > > >>> >>>>>>> count:
>> >> > > >>> >>>>>>> 0,
>> >> > > >>> >>>>>>> unhandled:
>> >> > > >>> >>>>>>> 0
>> >> > > >>> >>>>>>> [  324.671684] ->handle_irq():  c00998b4,
>> >> > > >>> >>>>>>> handle_edge_irq+0x0/0x168
>> >> > > >>> >>>>>>> [  324.677980] ->irq_data.chip(): df156710, 0xdf15671=
0
>> >> > > >>> >>>>>>> [  324.683077] ->action():   (null)
>> >> > > >>> >>>>>>> [  324.686442]    IRQ_NOPROBE set
>> >> > > >>> >>>>>>> ...
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> 3. Source code of the basic gpio interrupt driver:
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> #include <linux/fs.h>
>> >> > > >>> >>>>>>> #include <linux/gpio.h>
>> >> > > >>> >>>>>>> #include <linux/interrupt.h>
>> >> > > >>> >>>>>>> #include <linux/module.h>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> #include <rtdm/driver.h>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> static unsigned int irq_num;
>> >> > > >>> >>>>>>> // bbb gpios that work on PREEMPT_RT linux 4.19.59 an=
d
>> >> > > >>> >>>>>>> 5.4.5
>> >> > > >>> >>>>>>> with
>> >> > > >>> >>>>>>> default dts
>> >> > > >>> >>>>>>> static unsigned int gpio_out =3D 48;
>> >> > > >>> >>>>>>> static unsigned int gpio_in =3D 115;
>> >> > > >>> >>>>>>> static bool value =3D false;
>> >> > > >>> >>>>>>> static rtdm_irq_t irq_handle;
>> >> > > >>> >>>>>>> static int num_of_intr =3D 0;
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> static int gpio_irq_handler(rtdm_irq_t * irq)
>> >> > > >>> >>>>>>> {
>> >> > > >>> >>>>>>>      value =3D !value;
>> >> > > >>> >>>>>>>      gpio_set_value(gpio_out, value); // toggle the
>> >> > > >>> >>>>>>> led
>> >> > > >>> >>>>>>> everytime
>> >> > > >>> >>>>>>> irq
>> >> > > >>> >>>>>>> handler is invoked
>> >> > > >>> >>>>>>>      trace_printk("GPIO interrupt \n");
>> >> > > >>> >>>>>>>      num_of_intr++;
>> >> > > >>> >>>>>>>      return RTDM_IRQ_HANDLED;
>> >> > > >>> >>>>>>> }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> static int __init rtdm_init (void)
>> >> > > >>> >>>>>>> {
>> >> > > >>> >>>>>>>      int err;
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      if ((err =3D gpio_request(gpio_in,
>> >> > > >>> >>>>>>> THIS_MODULE->name))
>> >> > > >>> >>>>>>> !=3D 0)
>> >> > > >>> >>>>>>> {
>> >> > > >>> >>>>>>>          printk(" gpio_request gpio_in failed ! \n");
>> >> > > >>> >>>>>>>          return err;
>> >> > > >>> >>>>>>>      }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      if ((err =3D gpio_direction_input(gpio_in)) !=3D=
 0) {
>> >> > > >>> >>>>>>>          printk(" gpio_direction_input gpio_in failed
>> >> > > >>> >>>>>>> !
>> >> > > >>> >>>>>>> \n");
>> >> > > >>> >>>>>>>          gpio_free(gpio_in);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>          return err;
>> >> > > >>> >>>>>>>      }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      irq_num =3D gpio_to_irq(gpio_in);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      printk(" IRQ number %d !  \n",irq_num);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      if ((err =3D gpio_request(gpio_out,
>> >> > > >>> >>>>>>> THIS_MODULE->name))
>> >> > > >>> >>>>>>> !=3D 0)
>> >> > > >>> >>>>>>> {
>> >> > > >>> >>>>>>>          printk(" gpio_request gpio_out failed ! \n")=
;
>> >> > > >>> >>>>>>>          gpio_free(gpio_in);
>> >> > > >>> >>>>>>>          return err;
>> >> > > >>> >>>>>>>      }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      if ((err =3D gpio_direction_output(gpio_out, 0))=
 !=3D
>> >> > > >>> >>>>>>> 0)
>> >> > > >>> >>>>>>> {
>> >> > > >>> >>>>>>>          printk(" gpio_direction_input gpio_out faile=
d
>> >> > > >>> >>>>>>> !
>> >> > > >>> >>>>>>> \n");
>> >> > > >>> >>>>>>>          gpio_free(gpio_out);
>> >> > > >>> >>>>>>>          gpio_free(gpio_in);
>> >> > > >>> >>>>>>>          return err;
>> >> > > >>> >>>>>>>      }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      err =3D irq_set_irq_type(irq_num,
>> >> > > >>> >>>>>>> IRQF_TRIGGER_RISING);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      if(err) {
>> >> > > >>> >>>>>>>          gpio_free(gpio_out);
>> >> > > >>> >>>>>>>          gpio_free(gpio_in);
>> >> > > >>> >>>>>>>          printk(" irq_set_irq_type failed ! \n");
>> >> > > >>> >>>>>>>          return err;
>> >> > > >>> >>>>>>>      }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      err =3D
>> >> > > >>> >>>>>>>
>> >> > > >>> rtdm_irq_request(&irq_handle,irq_num,(rtdm_irq_handler_t)gpio=
_irq_handler,
>> >> > > >>> >>>>>>>                  RTDM_IRQTYPE_EDGE,THIS_MODULE->name,
>> >> > > >>> >>>>>>> NULL);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      printk("after request irq =3D %d
>> >> > > >>> >>>>>>> \n",irq_handle.irq);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      if(err) {
>> >> > > >>> >>>>>>>          gpio_free(gpio_out);
>> >> > > >>> >>>>>>>          gpio_free(gpio_in);
>> >> > > >>> >>>>>>>          printk(" rtdm_irq_request failed ! \n");
>> >> > > >>> >>>>>>>          return err;
>> >> > > >>> >>>>>>>      }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      err =3D rtdm_irq_enable(&irq_handle);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      if (err < 0) {
>> >> > > >>> >>>>>>>          printk("rtdm_irq_enable failed \n");
>> >> > > >>> >>>>>>>          return err;
>> >> > > >>> >>>>>>>      }
>> >> > > >>> >>>>>>>      return 0;
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> static void __exit rtdm_exit (void)
>> >> > > >>> >>>>>>> {
>> >> > > >>> >>>>>>>      rtdm_irq_free(&irq_handle);
>> >> > > >>> >>>>>>>      gpio_free(gpio_out);
>> >> > > >>> >>>>>>>      gpio_free(gpio_in);
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>      printk("The number of intr is %d
>> >> > > >>> >>>>>>> \n",num_of_intr);
>> >> > > >>> >>>>>>> }
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> module_init(rtdm_init);
>> >> > > >>> >>>>>>> module_exit(rtdm_exit);
>> >> > > >>> >>>>>>> MODULE_LICENSE("GPL");
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>>> Thank you,
>> >> > > >>> >>>>>>> L-C Duca
>> >> > > >>> >>>>>>>
>> >> > > >>> >>>>>> My above comments would be good to start debugging the
>> >> > > >>> >>>>>> issue.
>> >> > > >>> >>>>>> Looking
>> >> > > >>> >>>>>> at the ipipe trees I think we are missing some ipipe
>> >> > > >>> >>>>>> things
>> >> > > >>> >>>>>> in
>> >> > > >>> >>>>>> the
>> >> > > >>> >>>>>> GPIO driver from 4.4 to 4.19.  When I diff the files i=
t
>> >> > > >>> >>>>>> looks
>> >> > > >>> >>>>>> like
>> >> > > >>> >>>>>> there are some things missing in 4.19.  I can make a
>> >> > > >>> >>>>>> patch
>> >> > > >>> >>>>>> for
>> >> > > >>> >>>>>> you
>> >> > > >>> to
>> >> > > >>> >>>>>> try, I'll have it ready shortly.
>> >> > > >>> >>>>>>
>> >> > > >>> >>>>>> -Greg
>> >> > > >>> >>>
>> >> > > >>> >>
>> >> > > >>> >> --
>> >> > > >>> >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> >> > > >>> >> Corporate Competence Center Embedded Linux
>> >> > > >>> >>
>> >> > > >>> >
>> >> > > >>>
>> >> > > >> I think this is an ipipe issue, I am able to reproduce but I=
=E2=80=99ll
>> >> > > >> need a
>> >> > > >> little more time to confirm my findings, printascii is not
>> >> > > >> working
>> >> > > >> for me
>> >> > > >> on this SOC.
>> >> > > >>
>> >> > > >> Greg
>> >> > > >>
>> >> > > >
>> >> >
>> >> > This is definitely an ipipe issue so this should not hold up any ne=
w
>> >> > Xenomai release.  I was able to get the following back trace with
>> >> > the
>> >> > Ipipe debugging turned on.
>> >> >
>> >> > root@busterarm:/home# [   75.141504] I-pipe: Detected illicit call
>> >> > from head domain 'Xenomai'
>> >> > [   75.141504]         into a regular Linux service
>> >> > [   75.152566] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O
>> >> >   4.19.82-ga0888f089f79-dirty #8
>> >> > [   75.161755] Hardware name: Generic AM33XX (Flattened Device Tree=
)
>> >> > [   75.167890] I-pipe domain: Xenomai
>> >> > [   75.171334] [<c0112c3c>] (unwind_backtrace) from [<c010d204>]
>> >> > (show_stack+0x10/0x14)
>> >> > [   75.179136] [<c010d204>] (show_stack) from [<c08af6d8>]
>> >> > (dump_stack+0xe8/0x110)
>> >> > [   75.186502] [<c08af6d8>] (dump_stack) from [<c02111a0>]
>> >> > (ipipe_test_and_stall_root+0x8/0x34)
>> >> > [   75.195001] [<c02111a0>] (ipipe_test_and_stall_root) from
>> >> > [<c08cb874>] (_raw_spin_lock_irqsave+0x14/0x4c)
>> >> > [   75.204643] [<c08cb874>] (_raw_spin_lock_irqsave) from
>> >> > [<c0553660>]
>> >> > (gpio_to_desc+0x14/0xd0)
>> >> > [   75.214200] [<c0553660>] (gpio_to_desc) from [<bf44501c>]
>> >> > (gpio_irq_handler+0x1c/0x48 [rtdm_test])
>> >> > [   75.223238] [<bf44501c>] (gpio_irq_handler [rtdm_test]) from
>> >> > [<c0259bd0>] (xnintr_irq_handler+0xfc/0x4f4)
>> >> > [   75.232872] [<c0259bd0>] (xnintr_irq_handler) from [<c02121d4>]
>> >> > (__ipipe_do_sync_stage+0x134/0x218)
>> >> > [   75.241980] [<c02121d4>] (__ipipe_do_sync_stage) from
>> >> > [<c02123ac>]
>> >> > (__ipipe_do_sync_pipeline+0x88/0xf8)
>> >> > [   75.251437] [<c02123ac>] (__ipipe_do_sync_pipeline) from
>> >> > [<c01179c0>] (__ipipe_grab_irq+0x4c/0xac)
>> >> > [   75.260455] [<c01179c0>] (__ipipe_grab_irq) from [<c0101b2c>]
>> >> > (__irq_svc+0x6c/0x78)
>> >> > [   75.268161] Exception stack(0xc0d01e38 to 0xc0d01e80)
>> >> > [   75.273252] 1e20:
>> >> >     0000040c 00000000
>> >> > [   75.281488] 1e40: 00000001 c15127c0 df94ccdc c14ff280 00000001
>> >> > c14ff280 0000040d 00000001
>> >> > [   75.289723] 1e60: 00000020 0000000c df94ccec c0d01e88 df94cce4
>> >> > c02121c0 600b0113 ffffffff
>> >> > [   75.297958] [<c0101b2c>] (__irq_svc) from [<c02121c0>]
>> >> > (__ipipe_do_sync_stage+0x120/0x218)
>> >> > [   75.306281] [<c02121c0>] (__ipipe_do_sync_stage) from
>> >> > [<c02122f4>]
>> >> > (ipipe_unstall_root+0x3c/0x48)
>> >> > [   75.315215] [<c02122f4>] (ipipe_unstall_root) from [<c08cb98c>]
>> >> > (_raw_spin_unlock_irqrestore+0x34/0x40)
>> >> > [   75.324672] [<c08cb98c>] (_raw_spin_unlock_irqrestore) from
>> >> > [<c055a314>] (omap_gpio_irq_handler+0x100/0x138)
>> >> > [   75.334564] [<c055a314>] (omap_gpio_irq_handler) from
>> >> > [<c0212a9c>]
>> >> > (__ipipe_dispatch_irq+0xe0/0x21c)
>> >> > [   75.343757] [<c0212a9c>] (__ipipe_dispatch_irq) from [<c01179c0>=
]
>> >> > (__ipipe_grab_irq+0x4c/0xac)
>> >> > [   75.352427] [<c01179c0>] (__ipipe_grab_irq) from [<c0101b2c>]
>> >> > (__irq_svc+0x6c/0x78)
>> >> > [   75.360132] Exception stack(0xc0d01f28 to 0xc0d01f70)
>> >> > [   75.365226] 1f20:                   1eccd000 00000001 df94ccdc
>> >> > 00000000 c0c7fcdc c0d089b4
>> >> > [   75.373462] 1f40: 00000001 c0d089fc c0dc8155 c0abf870 c0c5ea4c
>> >> > c0d08980 00000000 c0d01f78
>> >> > [   75.381693] 1f60: c02122c8 c02122ec 600b0013 ffffffff
>> >> > [   75.386788] [<c0101b2c>] (__irq_svc) from [<c02122ec>]
>> >> > (ipipe_unstall_root+0x34/0x48)
>> >> > [   75.394677] [<c02122ec>] (ipipe_unstall_root) from [<c017009c>]
>> >> > (do_idle+0xd8/0x1d4)
>> >> > [   75.402475] [<c017009c>] (do_idle) from [<c0170414>]
>> >> > (cpu_startup_entry+0x18/0x1c)
>> >> > [   75.410102] [<c0170414>] (cpu_startup_entry) from [<c0c00da0>]
>> >> > (start_kernel+0x3f8/0x4a8)
>> >> > [   75.418341] GPIO interrupt
>> >> >
>> >> > Looks like we are returning from the ipipe domain into the Linux
>> >> > domain.  This is probably causing the system to lock up.  I'll
>> >> > hopefully finish this up this week unless someone else sees the
>> >> > problem.
>> >> >
>> >> > Thanks
>> >> >
>> >> > Greg
>> >>
>> >> I think I have this solved, patch up tonight or tomorrow depending on
>> >> testing.
>> >>
>> >> -Greg
>> >
>> > This issue ends up being two issues.  The first is the stack trace
>> > above.  It's being caused by calling a Linux call while in the head
>> > domain.  This scenario is described in the ipipe documentation, where
>> > the head domain tries to return into the root domain.  To fix this
>> > don't use gpio_set_value in the interrupt handler to set the gpio
>> > value use gpiod_set_raw_value instead.  The xenomai gpio driver
>> > (gpio-core.c) can be used as a guide when using the Linux gpiolib in
>> > the RTDM context.  I'm not sure if the trace_printk is safe to have
>> > there as well, but I'm assuming that's just there for debug purposes.
>> > The second issue is trickier to debug and is what is causing the lock
>> > up.  From my test runs with limit debugging tools, since printascii
>> > isn't working great on beaglebone for some reason, it looks like the
>> > gpio interrupt is flooding the system and causing it to be
>> > unresponsive.  This is probably to do with not holding the irq or
>> > possibly there's an issue when the driver is suppose to ack it.
>> > Anyway, I'll dig into that now and hopefully wrap that up this
>> > weekend.  If anyone has gotten printascii to work with beaglebone and
>> > could post there config to get it working that would be greatly
>> > appreciated.
>> >
>> > -Greg
>> >
>
> I sent a patch that should address the issue, I have a second patch
> that should be ready this week that will add a RTDM gpio driver for
> the beaglbone family.  Let me know if there are any issues.
>
> thanks
>
> Greg
>

