Date: Thu, 09 Aug 2018 07:16:30 -0400
Message-ID: <u03olq1bdcdfuvta6b6389uk.1533813390462@embeddedgreg.com>
From: Greg Gallagher <greg@embeddedgreg.com>
In-Reply-To: <CAK+-5=JO2mX2-XtOG5b6Yc2Bat-oU+q3ALag1reQiEF=Cfb72A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
To: Ho Tam <mophong@gmail.com>
Cc: xenomai <xenomai@xenomai.org>


   It's possible the domains don't have much to do with your issue. Can
   you confirm if you are switching modes in the case of the rpi2\3? There
   isn't anything unique about the rpi2\3 that would impact it only. Are
   you able to get some info on what the system is doing during the worst
   case run? This is the only application running at the time?
   Greg

   From: mophong@gmail.com
   Sent: August 9, 2018 1:48 AM
   To: greg@embeddedgreg.com
   Reply-to: mophong@gmail.com
   Cc: xenomai@xenomai.org
   Subject: Re: [Xenomai] Xenomai on Raspberry pi 2, 3 - Userspace task is
   interrupted?

   Hello Greg,
   Thanks for your answer. There is still something unclear. So far I have
   worked with mmap + xenomai task on several platforms like Beaglebone
   (single core), IMX6Q (quad-core), and as you can see, RPI0,1 (BCM2835),
   it works just fine.
   Still, I don't understand why this situation ONLY happens on RPI2,3
   (BCM2857).
   Regards,
   On Thu, Aug 9, 2018 at 12:52 AM greg gallagher
   <[1]greg@embeddedgreg.com> wrote:

     If you use these functions your test will run in secondary mode. You
     need to install the rtdm bcm2835_gpio driver for your test to stay
     in
     the primary domain.  Your tests at the moment are running as normal
     linux applications even though you have built them with the Xenomai
     libraries.  You'll need enable the gpio module in the kernel build.
     You
     should see the gpio pins under /dev/rtdm once the module is loaded.
     It
     might be worth while posting your steps for building the application
     so
     you can ensure you are indeed building the application to correctly
     interface with Xenomai.
     -Greg
     On 2018-08-08 11:41 AM, Ho Tam wrote:
     > I used bcm2835 library for test, that library is implemented using
     > memory map (mmap). You may check its copied code here:
     > [2]https://github.com/smart-facility/bcm2835/tree/master/src
     > The function I used bcm2835_gpio_write:
     > void bcm2835_gpio_write(uint8_t pin, uint8_t on)
     > {
     >     if (on)
     > bcm2835_gpio_set(pin);
     >     else
     > bcm2835_gpio_clr(pin);
     > }
     >
     > I have also tested by direct using of bcm2835_gpio_set
     > and bcm2835_gpio_clr fucntions, but result was same as previous
     test:
     > for (i=0; i<500; ++i)
     > {
     > bcm2835_gpio_set(TEST_PIN);
     > bcm2835_gpio_clr(TEST_PIN);
     > }
     >
     > Since functions in bcm2835 library usually call many other
     functions,
     > I have also implemented my own gpio library which directly
     read/write
     > value to GPSET and GPCLR:
     > for (i=0; i<3000; ++i)
     > {
     > *(rpi_gpio_mem_base+7) =(1<<TEST_PIN);    //rpi_gpio_mem_base+7 ~
     GPSET0
     > *(rpi_gpio_mem_base+10) =(1<<TEST_PIN);  //rpi_gpio_mem_base+10 ~
     GPCLR0
     > }
     > Here rpi_gpio_mem_base has been initialized with mmap before. In
     this
     > case, both process time and worst time reduce (for sure). But
     again,
     > worst time on rpi2,3 is larger than 350% process time, while for
     > rpi0,1 worst time ~ 120% process time.
     > Regards,
     >
     >
     > On Wed, Aug 8, 2018 at 8:12 PM Greg Gallagher
     <[3]greg@embeddedgreg.com
     > <mailto:[4]greg@embeddedgreg.com>> wrote:
     >
     >
     >     How are you setting up the gpio read and write? Is it possible
     to
     >     post a code snippet for the read and write?
     >
     >     Greg
     >
     >       Original Message
     >     From: [5]mophong@gmail.com <mailto:[6]mophong@gmail.com>
     >     Sent: August 8, 2018 6:45 AM
     >     To: [7]xenomai@xenomai.org <mailto:[8]xenomai@xenomai.org>
     >     Reply-to: [9]mophong@gmail.com <mailto:[10]mophong@gmail.com>
     >     Subject: [Xenomai] Xenomai on Raspberry pi 2, 3 - Userspace
     task
     >     is interrupted?
     >
     >     Hello all,
     >     I make a simple code to measure process time on Raspberry pi
     >     0,1,2,3 like:
     >
     >     * previous = rt_timer_read();*
     >     * for (i=0; i<500; ++i)*
     >     * {*
     >     * bcm2835_gpio_write(TEST_PIN, HIGH);*
     >     * bcm2835_gpio_write(TEST_PIN, LOW);*
     >     * }*
     >     * now = rt_timer_read();*
     >     * process_time = (long) (now - previous);*
     >     * if (process_time>worst_time)*
     >     * worst_time=process_time;*
     >
     >     And I result after several hours running:
     >     rpi           process_time (us)             worst_time (us)
     >     0,1           ~100                                     115
     >     2,3           ~90                                        373
     >
     >     It is clear that process time on rpi2,3 is shorter than that
     on
     >     rpi0,1 due
     >     to higher speed CPU. However, I don't understand why worst
     case on
     >     rpi2,3
     >     is much larger than that on rpi0,1. I have repeated this test
     on both
     >     xenomai 2 and 3, kernel  4.1 and 4.9 (only xenomai 3 in this
     case)
     >     and with
     >     different task priority, the result is quite consistent.
     >     Does anyone have explanation and solution?
     >     Thanks and regards,
     >     _______________________________________________
     >     Xenomai mailing list
     >     [11]Xenomai@xenomai.org <mailto:[12]Xenomai@xenomai.org>
     >     [13]https://xenomai.org/mailman/listinfo/xenomai
     >
     >
     >
     > --
     > [14]http://www.mophong.com

   --
   [15]http://www.mophong.com

References

   1. mailto:greg@embeddedgreg.com
   2. https://github.com/smart-facility/bcm2835/tree/master/src
   3. mailto:greg@embeddedgreg.com
   4. mailto:greg@embeddedgreg.com
   5. mailto:mophong@gmail.com
   6. mailto:mophong@gmail.com
   7. mailto:xenomai@xenomai.org
   8. mailto:xenomai@xenomai.org
   9. mailto:mophong@gmail.com
  10. mailto:mophong@gmail.com
  11. mailto:Xenomai@xenomai.org
  12. mailto:Xenomai@xenomai.org
  13. https://xenomai.org/mailman/listinfo/xenomai
  14. http://www.mophong.com/
  15. http://www.mophong.com/
