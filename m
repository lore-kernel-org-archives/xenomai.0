MIME-Version: 1.0
References: <CAK+-5=KE5pa1NUE4VY0uEVLH1+2P3dtbGWOBk9YxWLmAa16Juw@mail.gmail.com>
 <dcqod1d4ju4sjjl1d9q0fhov.1533726738829@embeddedgreg.com>
 <CAK+-5=L5_xoXskX2ZOww5zj=2=Ou2COwcsH=7MkfRcQ6y2dwuA@mail.gmail.com>
 <bc12761e-b015-5f48-580c-c4503650c7c3@embeddedgreg.com>
In-Reply-To: <bc12761e-b015-5f48-580c-c4503650c7c3@embeddedgreg.com>
Reply-To: mophong@gmail.com
From: Ho Tam <mophong@gmail.com>
Date: Thu, 9 Aug 2018 14:48:12 +0900
Message-ID: <CAK+-5=JO2mX2-XtOG5b6Yc2Bat-oU+q3ALag1reQiEF=Cfb72A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Xenomai on Raspberry pi 2,
 3 - Userspace task is interrupted?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: greg@embeddedgreg.com
Cc: xenomai@xenomai.org

Hello Greg,
Thanks for your answer. There is still something unclear. So far I have
worked with mmap + xenomai task on several platforms like Beaglebone
(single core), IMX6Q (quad-core), and as you can see, RPI0,1 (BCM2835), it
works just fine.
Still, I don't understand why this situation ONLY happens on RPI2,3
(BCM2857).
Regards,

On Thu, Aug 9, 2018 at 12:52 AM greg gallagher <greg@embeddedgreg.com>
wrote:

> If you use these functions your test will run in secondary mode. You
> need to install the rtdm bcm2835_gpio driver for your test to stay in
> the primary domain.  Your tests at the moment are running as normal
> linux applications even though you have built them with the Xenomai
> libraries.  You'll need enable the gpio module in the kernel build.  You
> should see the gpio pins under /dev/rtdm once the module is loaded.  It
> might be worth while posting your steps for building the application so
> you can ensure you are indeed building the application to correctly
> interface with Xenomai.
>
>
> -Greg
>
>
> On 2018-08-08 11:41 AM, Ho Tam wrote:
> > I used bcm2835 library for test, that library is implemented using
> > memory map (mmap). You may check its copied code here:
> > https://github.com/smart-facility/bcm2835/tree/master/src
> > The function I used bcm2835_gpio_write:
> > void bcm2835_gpio_write(uint8_t pin, uint8_t on)
> > {
> >     if (on)
> > bcm2835_gpio_set(pin);
> >     else
> > bcm2835_gpio_clr(pin);
> > }
> >
> > I have also tested by direct using of bcm2835_gpio_set
> > and bcm2835_gpio_clr fucntions, but result was same as previous test:
> > for (i=0; i<500; ++i)
> > {
> > bcm2835_gpio_set(TEST_PIN);
> > bcm2835_gpio_clr(TEST_PIN);
> > }
> >
> > Since functions in bcm2835 library usually call many other functions,
> > I have also implemented my own gpio library which directly read/write
> > value to GPSET and GPCLR:
> > for (i=0; i<3000; ++i)
> > {
> > *(rpi_gpio_mem_base+7) =(1<<TEST_PIN);    //rpi_gpio_mem_base+7 ~ GPSET0
> > *(rpi_gpio_mem_base+10) =(1<<TEST_PIN);  //rpi_gpio_mem_base+10 ~ GPCLR0
> > }
> > Here rpi_gpio_mem_base has been initialized with mmap before. In this
> > case, both process time and worst time reduce (for sure). But again,
> > worst time on rpi2,3 is larger than 350% process time, while for
> > rpi0,1 worst time ~ 120% process time.
> > Regards,
> >
> >
> > On Wed, Aug 8, 2018 at 8:12 PM Greg Gallagher <greg@embeddedgreg.com
> > <mailto:greg@embeddedgreg.com>> wrote:
> >
> >
> >     How are you setting up the gpio read and write? Is it possible to
> >     post a code snippet for the read and write?
> >
> >     Greg
> >
> >       Original Message
> >     From: mophong@gmail.com <mailto:mophong@gmail.com>
> >     Sent: August 8, 2018 6:45 AM
> >     To: xenomai@xenomai.org <mailto:xenomai@xenomai.org>
> >     Reply-to: mophong@gmail.com <mailto:mophong@gmail.com>
> >     Subject: [Xenomai] Xenomai on Raspberry pi 2, 3 - Userspace task
> >     is interrupted?
> >
> >     Hello all,
> >     I make a simple code to measure process time on Raspberry pi
> >     0,1,2,3 like:
> >
> >     * previous = rt_timer_read();*
> >     * for (i=0; i<500; ++i)*
> >     * {*
> >     * bcm2835_gpio_write(TEST_PIN, HIGH);*
> >     * bcm2835_gpio_write(TEST_PIN, LOW);*
> >     * }*
> >     * now = rt_timer_read();*
> >     * process_time = (long) (now - previous);*
> >     * if (process_time>worst_time)*
> >     * worst_time=process_time;*
> >
> >     And I result after several hours running:
> >     rpi           process_time (us)             worst_time (us)
> >     0,1           ~100                                     115
> >     2,3           ~90                                        373
> >
> >     It is clear that process time on rpi2,3 is shorter than that on
> >     rpi0,1 due
> >     to higher speed CPU. However, I don't understand why worst case on
> >     rpi2,3
> >     is much larger than that on rpi0,1. I have repeated this test on both
> >     xenomai 2 and 3, kernel  4.1 and 4.9 (only xenomai 3 in this case)
> >     and with
> >     different task priority, the result is quite consistent.
> >     Does anyone have explanation and solution?
> >     Thanks and regards,
> >     _______________________________________________
> >     Xenomai mailing list
> >     Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
> >     https://xenomai.org/mailman/listinfo/xenomai
> >
> >
> >
> > --
> > http://www.mophong.com
>
>

-- 
http://www.mophong.com
