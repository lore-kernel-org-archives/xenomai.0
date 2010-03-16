Message-ID: <20100316183247.34995yxgivc3ilj4@domain.hid>
Date: Tue, 16 Mar 2010 18:32:47 +0100
From: Michel He <michel.he@domain.hid>
References: <20100316150037.11405209mnid677k@domain.hid>
	<4B9FB4A8.6000903@domain.hid>
In-Reply-To: <4B9FB4A8.6000903@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Mini2440 on the kernel 2.6.30.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Still not working after reactivation of Timer 3. Here's the codes :


/*
  * Set up timer interrupt.
  *
  * Currently we use timer4 as event timer and timer3 as tick counter which
  * permanently counts ticks without interrupt generation.
  */
static void s3c2410_timer_setup (void)
{
         unsigned long tcon;
         unsigned long tcnt;
         unsigned long tcfg1;
         unsigned long tcfg0;
=09unsigned long intmask;

         tcnt =3D TICK_MAX;  /* default value for tcnt */

         /* configure the system for whichever machine is in use */

         if (use_tclk1_12()) {
                 /* timer is at 12MHz, scaler is 1 */
                 timer_usec_ticks =3D timer_mask_usec_ticks(1, 12000000);
                 tcnt =3D 12000000 / HZ;

=09=09tcfg1 =3D __raw_readl(S3C2410_TCFG1);
=09=09tcfg1 &=3D ~S3C2410_TCFG1_MUX4_MASK;
=09=09tcfg1 |=3D S3C2410_TCFG1_MUX4_TCLK1;
=09=09__raw_writel(tcfg1, S3C2410_TCFG1);

=09=09/* timer 3 */

=09=09tcfg1 =3D __raw_readl(S3C2410_TCFG1);
=09=09tcfg1 &=3D ~S3C2410_TCFG1_MUX3_MASK;
=09=09tcfg1 |=3D S3C2410_TCFG1_MUX3_TCLK1;
=09=09__raw_writel(tcfg1, S3C2410_TCFG1);


         } else {
                 unsigned long pclk;
                 struct clk *tscaler;

                 /* for the h1940 (and others), we use the pclk from the cor=
e
                  * to generate the timer values. since values around 50 to
                  * 70MHz are not values we can directly generate the timer
                  * value from, we need to pre-scale and divide before =20
using it.
                  *
                  * for instance, using 50.7MHz and dividing by 6 gives 8.45=
MHz
                  * (8.45 ticks per usec)
                  */
                 pclk =3D clk_get_rate(timerclk);

                 /* configure clock tick */

                 timer_usec_ticks =3D timer_mask_usec_ticks(6, pclk);

                 tscaler =3D clk_get_parent(tdiv);

                 clk_set_rate(tscaler, pclk / 3);
                 clk_set_rate(tdiv, pclk / 6);
                 clk_set_parent(tin, tdiv);

                 tcnt =3D clk_get_rate(tin) / HZ;

=09=09/* timer 3 */
=09=09tcfg1 =3D __raw_readl(S3C2410_TCFG1);
=09=09tcfg1 &=3D ~S3C2410_TCFG1_MUX3_MASK;
=09=09tcfg1 |=3D S3C2410_TCFG1_MUX3_TCLK1;
=09=09__raw_writel(tcfg1, S3C2410_TCFG1);


         }

         tcon =3D __raw_readl(S3C2410_TCON);
         tcfg0 =3D __raw_readl(S3C2410_TCFG0);
         tcfg1 =3D __raw_readl(S3C2410_TCFG1);

#ifdef CONFIG_IPIPE
=09tsc =3D (unsigned long long *)__ipipe_tsc_area;
=09last_cnt =3D (unsigned *)(tsc + 1);=09=09/* means: +8 bytes */
=09barrier();

=09__ipipe_mach_ticks_per_jiffy =3D tcnt;
#endif /* CONFIG_IPIPE */

=09/* timers reload after counting zero, so reduce the count by 1 */

=09tcnt--;

=09printk(KERN_DEBUG "timer tcon=3D%08lx, tcnt %04lx, tcfg %08lx,%08lx, =20
usec %08lx\n",
=09       tcon, tcnt, tcfg0, tcfg1, timer_usec_ticks);

=09/* check to see if timer is within 16bit range... */
=09if (tcnt > TICK_MAX) {
=09=09panic("setup_timer: HZ is too small, cannot configure timer!");
=09=09return;
=09}

=09__raw_writel(tcfg1, S3C2410_TCFG1);
=09__raw_writel(tcfg0, S3C2410_TCFG0);


=09/* ensure timer stopped... */

=09//tcon &=3D ~(7<<20);
=09tcon &=3D ~(0x3f<<17);
=09free_running_tcon =3D tcon |  S3C2410_TCON_T3RELOAD | S3C2410_TCON_T3STAR=
T;

=09tcon |=3D S3C2410_TCON_T4RELOAD;
=09tcon |=3D S3C2410_TCON_T4MANUALUPD;

=09__raw_writel(tcon, S3C2410_TCON);
=09__raw_writel(tcnt, S3C2410_TCNTB(4));
=09__raw_writel(tcnt, S3C2410_TCMPB(4));

=09/* start the timer 4 */
=09tcon |=3D S3C2410_TCON_T4START;
=09tcon &=3D ~S3C2410_TCON_T4MANUALUPD;
=09__raw_writel(tcon, S3C2410_TCON);

=09/* timer 3 */
=09tcon |=3D S3C2410_TCON_T3RELOAD;
=09tcon |=3D S3C2410_TCON_T3MANUALUPD;

=09/* Mask timer3 interrupt. */
=09intmask =3D __raw_readl(S3C2410_INTMSK);
=09intmask |=3D 1UL << (IRQ_TIMER3 - IRQ_EINT0);
=09__raw_writel(intmask, S3C2410_INTMSK);

=09__raw_writel(tcon, S3C2410_TCON);
=09__raw_writel(0xffff, S3C2410_TCNTB(3));
=09__raw_writel(0xffff, S3C2410_TCMPB(3));

=09/* start the timer 3 */
=09tcon |=3D S3C2410_TCON_T3START;
=09//tcon &=3D ~S3C2410_TCON_T3MANUALUPD;
=09__raw_writel(tcon, S3C2410_TCON);

=09last_free_running_tcnt =3D 0xffff;
}



The system boot shows :
......
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
yaffs: dev is 32505859 name is "mtdblock3"
yaffs: passed flags ""
yaffs: Attempting MTD mount on 31.3, "mtdblock3"
block 191 is bad
block 651 is bad
yaffs_read_super: isCheckpointed 0
VFS: Mounted root (yaffs2 filesystem) on device 31:3.
Freeing init memory: 112K
Warning: unable to open an initial console.
<-----   stucked here ----->


thank you for your advice.



Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =E9crit=A0:

> Michel He wrote:
>> Hello Gilles,
>>
>>    I read out on your site that issue regarding to the adeos port of S3C
>> comes from the Timer. Here the problem is Timer 3, which has been
>> already reserved by the sound driver (maybe also other drivers). So I
>> did some slight changes in arch/arm/plat-s3c/time.c to get rid of it
>> (actually not knowing the real utility of it), and Adeos get going on.
>> Adeos seems to be working without Xenomai. So I reactivate Xenomai in
>> the Kernel.
>>
>>   However again it's stucked in the FrameBuffer (S3C) and the Ethernet
>> (dm9000) initializations. I make the FrameBuffer desactivated. We need
>> the networking, the Ethernet is now the problem :
>>
>> TCP cubic registered
>> NET: Registered protocol family 17
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> <----- kernel stucked  here ------>
>> if passed, it should show that :
>> eth0: link down
>> IP-Config: Complete:...
>>
>>
>> Thank you for your advice.
>
> Actually, xenomai needs a hardware timer. So, if you removed timer 3
> without using something else instead, it is normal that the system is
> not working.
>
>>
>>
>
>
> --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>



