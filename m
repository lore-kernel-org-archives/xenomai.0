MIME-Version: 1.0
References: <4707bb12-658a-f74c-84b6-332424be2bb9@cs.ru.nl>
 <844c96f4-191f-dd82-8a02-d3a99ac74fef@cs.ru.nl>
 <CALLqZ8RM0_yLbM+K=Wo4SVa46a7Dp8SYBLdAMxGWfAbrtR5hQg@mail.gmail.com>
 <9dd68ccb-054a-5ccb-91d9-55267145a34f@cs.ru.nl>
 <CALLqZ8R9o356vp0pcbkfbqFJt09ENDLwnd62ziUTW86SSbKw8g@mail.gmail.com>
 <41dedf13-0136-b905-d70d-fef1ade4dbe7@cs.ru.nl>
 <bac8728d-459b-ad23-3bd4-362494ccc615@web.de>
 <c677c9b5-67ed-ee87-1e95-3ee3185c73c4@cs.ru.nl>
In-Reply-To: <c677c9b5-67ed-ee87-1e95-3ee3185c73c4@cs.ru.nl>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 20 Jun 2019 10:45:28 -0400
Message-ID: <CALLqZ8T9B2Wxeu=w-Or_iYqY-spCZCN5xv+81cUbjaPS+c-vLw@mail.gmail.com>
Subject: Re: linux not getting gpio interrupts on xenomai 3.0.8 on raspberrypi
 raspbian/stretch kernel 4.9
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Harco Kuppens <h.kuppens@cs.ru.nl>
Cc: Jan Kiszka <jan.kiszka@web.de>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Thu, Jun 20, 2019 at 10:36 AM Harco Kuppens <h.kuppens@cs.ru.nl> wrote:
>
>
>
> Op 20/06/2019 om 09:37 schreef Jan Kiszka:
> > On 19.06.19 23:52, Harco Kuppens via Xenomai wrote:
> >>
> >>
> >> Op 19/06/2019 om 17:00 schreef Greg Gallagher:
> >>> On Wed, Jun 19, 2019 at 8:44 AM Harco Kuppens <h.kuppens@cs.ru.nl>
> >>> wrote:
> >>>> The ipipe patched not entirely cleanly on the rpi kernel source; I
> >>>> had to
> >>>> make little changes in the patch, but not anything really
> >>>> seriously. So I
> >>>> expect it to be fine.
> >>>>
> >>>> I used the rasbpian kernel source because it has better support for
> >>>> the
> >>>> raspberry pi's and mainly because it has better support for the
> >>>> gpio pins in
> >>>> its kernel.
> >>>>
> >>>> However to help you debug I did a similar install using the
> >>>> mainline kernel
> >>>> source. The ipipe patch just worked smoothly, however to get the
> >>>> gpio pins
> >>>> running in xenomai I had to still port some code of the file
> >>>>
> >>>>      ./drivers/pinctrl/bcm/pinctrl-bcm2835.c
> >>>>
> >>> What did you have to change here to get the pins to work with Xenomai?
> >>> You shouldn't need to change anything here.  If you did then it may be
> >>> a bug in the ipipe.  Can you try with 4.14 ipipe ?
> >> I did try with ipipe 4.19 and when compiling the kernel I got lot of
> >> errors.
> >> Some I could solve, but at the end I gave up.
> >>
> >> See my notes on
> >> https://github.com/harcokuppens/xenomai3_rpi_gpio/blob/master/install/__INSTALL_FAILURES__/install__compile_vanilla_kernel_4.19_with_xenomai_3.0.8__assert_error.txt
> >>
> >> Maybe this is also interesting for you.
> >>
> >
> > 4.19 requires Xenomai master. See our CI (e.g.
> > https://travis-ci.com/xenomai-ci/xenomai/jobs/209347407) for a working
> > setup.
> >
> > Jan
>
> ok, I used the master branch of xenomai,  and yes it compiles the kernel
> ok!!
>
> You find my installation description and findings at:
>
> https://github.com/harcokuppens/xenomai3_rpi_gpio/blob/master/install/installation_of_xenomai_master_on_mainline_kernel_branch_v4.19.33_from_kernel.org__problem_linux_gpio.md
>
> However I still get the same problem that the xenomai gpio ports are
> wrongly numbered!
> And within linux the gpio pins are also not working.
> In my other builds I fixed this with the pinctrl_bcm2835.c file I
> patched for rpi(raspbian) 4.9  kernel.
> You can find this file at :
> https://github.com/harcokuppens/xenomai3_rpi_gpio/blob/master/install/how_pinctrl-bcm2835_patch_for_rpi-4.9_is_derived/rpi-4.9.y.ipipe-patched/pinctrl-bcm2835.c
>
> However using that file didn't work here, because I got errors about
> irq_set_lockdep_class function. However this function wasn't even used
> in the mainline version of pinctrl_bcm2835.c .
> I probably have to patch it somehow to match the much newer kernel.
>
> But I will wait first if Greg Gallagher finds something for the 4.9.51
> build.
> Hopefully he finds what is wrong with  that build.
>

Do you have sysfs interface turned on when building the mainline
kernels?  Dumb question but it was turned off by default when I was
doing my builds.
Should be under Device Drivers => GPIO Support -> /sys/class/gpio
(sysfs interface) when you do a menuconfig.

> Anyway all builds I did for the raspberry pi 2/3  with  mainline kernels
> 4.9/4.14/4.19 with the official pipeline/xenomai patched have xenomai
> running ok. However they don't have the gpio pins working for the
> raspberry pi. Neither in linux nor for the realtime cobalt kernel.
>
> Best regards,
> Harco Kuppens
>

-Greg

