Message-ID: <4D348625.2050607@domain.hid>
Date: Mon, 17 Jan 2011 19:10:45 +0100
From: Joerg Mohre <jmohre@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------080307090605010603050809"
Subject: [Xenomai-help] Ext. Interrupt with POSIX skin from user - space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080307090605010603050809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

i am using a MPC52000 and try to handle external interrupts (IRQ1) with 
linux kernel 2.6.32 and Xenomai 2.5.5.2.
I use the POSIX skin functions to setup interrupt and wait for interrupt 
in user-space.

First for testing, i wrote a kernel module to setup and handle the 
interrupts.
This worked well.

Now it tried to do the same from user-space with the posix functions.
But unfortunately this wasn't successful.

I have to load the kernel module before i use my user-space application 
(see code).
Otherwise pthread_intr_control_np will fail with error -1 and errono = -19.


static int mpc5200_intr_setup(void)
{
     int                     iret = 0;
         int                                        err = 0;
     pthread_attr_t          ThreadAttribute;
         struct sched_param        sched_param;
         unsigned char                 byPriority;

         unsigned int                i = 0;

         byPriority = 90;
         sched_param.sched_priority = byPriority;
         memset (&sched_param, 0, sizeof (sched_param));

     if ( (pRegsIntCtrl = (int_ctrl_regs*)ioremap( MBAR_VALUE + 
MBAR_INT_CTRL, REMAP_SIZE )) == NULL) {
                 printf("ioremap failed for MBAR_INT_CTRL\n");
         return -1;
         }

     //pRegsIntCtrl->irqctl =  0x00201401; //bit 10,21 => 1: IRQ1 rising 
edge active; enable IRQ1
     pRegsIntCtrl->irqctl =  0x00201001; //bit 10 => 1: IRQ1 rising edge 
active; disbable IRQ1

         if (pthread_intr_attach_np (&irq_object, 65, 0)) {
         printf("Interrupt source not found!\n");
         return -1;
     }
         else {
                 printf("Interrupt source found!\n");
         }

         printf("pregs->irqctl = %08X\n",pRegsIntCtrl->irqctl);

         sleep(5);

         printf("%i\n", i+=1);
     pthread_attr_init( &ThreadAttribute);
         printf("%i\n", i+=1);
     if (pthread_attr_setstacksize(&ThreadAttribute,0x80000)) {
                 printf("Failed to set stack size\n");
                 return -1;
         }
         printf("%i\n", i+=1);
            if (pthread_create( &Thread, &ThreadAttribute, 
cyclic_interrupt_receiver, NULL)) {
                 printf("Failed to create thread\n");
                 return -1;
         }
         printf("%i\n", i+=1);
         if (pthread_setschedparam (Thread,SCHED_FIFO,&sched_param)) {
                 printf("Failed to set scheduling parameter\n");
                 return -1;
         }
         printf("%i\n", i+=1);
         iret = pthread_intr_control_np (irq_object, PTHREAD_IENABLE);
         if (iret)
         {
                 err = errno;
                 printf("Failed to enable interrupt (%i, errno = %i)\n", 
iret, err);
                 return -1;
         }

         printf("%i\n", i+=1);
     return iret;
}

If i enable IRQ1 with
//pRegsIntCtrl->irqctl =  0x00201401; //bit 10,21 => 1: IRQ1 rising edge 
active; enable IRQ1
the CPU seams to be blocked.

I searched the internet but i couldn't find any help for handling 
external interrupts with posix skin in user-space.

Is it necessary to request an irq with native functions from kernel module?

I would expect that all (request, enable setup type ....) is done by the 
posix functions.

Does any one have some ideas?

Thanks




--------------080307090605010603050809
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <font size="2" color="#4f4f4f" face="Verdana">Hi all,</font>
    <p><font size="2" color="#4f4f4f" face="Verdana">i am using a
        MPC52000 and
        try to handle external interrupts (IRQ1) with linux kernel
        2.6.32 and Xenomai
        2.5.5.2.<br>
        I use the POSIX skin functions to setup interrupt and wait for
        interrupt
        in user-space.</font>
    </p>
    <p><font size="2" color="#4f4f4f" face="Verdana">First for testing,
        i wrote
        a kernel module to setup and handle the interrupts.<br>
        This worked well.</font>
    </p>
    <p><font size="2" color="#4f4f4f" face="Verdana">Now it tried to do
        the same
        from user-space with the posix functions.<br>
        But unfortunately this wasn't successful.</font>
    </p>
    <p><font size="2" color="#4f4f4f" face="Verdana">I have to load the
        kernel
        module before i use my user-space application (see code).<br>
        Otherwise pthread_intr_control_np will fail with error -1 and
        errono =
        -19.</font>
      <br>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">static int
        mpc5200_intr_setup(void)</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">{</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; int &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; iret
        = 0;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        int &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp;err = 0;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; pthread_attr_t
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ThreadAttribute;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        struct sched_param &nbsp; &nbsp; &nbsp; &nbsp;sched_param;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        unsigned char &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; byPriority;</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        unsigned int &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp;i = 0;</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        byPriority = 90;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        sched_param.sched_priority = byPriority;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        memset (&amp;sched_param, 0, sizeof (sched_param));</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; if (
        (pRegsIntCtrl
        = (int_ctrl_regs*)ioremap( MBAR_VALUE + MBAR_INT_CTRL,
        REMAP_SIZE )) ==
        NULL) {</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; printf("ioremap failed
        for MBAR_INT_CTRL\n");</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        return -1; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        }</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp;
        //pRegsIntCtrl-&gt;irqctl
        = &nbsp;0x00201401; //bit 10,21 =&gt; 1: IRQ1 rising edge active;
        enable
        IRQ1</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp;
        pRegsIntCtrl-&gt;irqctl
        = &nbsp;0x00201001; //bit 10 =&gt; 1: IRQ1 rising edge active;
        disbable
        IRQ1</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        if (pthread_intr_attach_np (&amp;irq_object, 65, 0)) {</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("Interrupt source not found!\n");</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        return -1;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; }</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        else {</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; printf("Interrupt source
        found!\n");</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        }</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("pregs-&gt;irqctl = %08X\n",pRegsIntCtrl-&gt;irqctl);</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        sleep(5);</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("%i\n", i+=1);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp;
        pthread_attr_init(
        &amp;ThreadAttribute);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("%i\n", i+=1);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; if
        (pthread_attr_setstacksize(&amp;ThreadAttribute,0x80000))
        {</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; printf("Failed to set
        stack size\n");</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; return -1;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        }</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("%i\n", i+=1);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp;if (pthread_create( &amp;Thread, &amp;ThreadAttribute,
        cyclic_interrupt_receiver, NULL)) {</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; printf("Failed to create
        thread\n");</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; return -1;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        } </font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("%i\n", i+=1);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        if (pthread_setschedparam (Thread,SCHED_FIFO,&amp;sched_param))
        {</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; printf("Failed to set
        scheduling parameter\n");</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; return -1;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        }</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("%i\n", i+=1);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        iret = pthread_intr_control_np (irq_object, PTHREAD_IENABLE); </font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        if (iret)</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        {</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; err = errno;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; printf("Failed to enable
        interrupt (%i, errno = %i)\n", iret, err);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; return -1;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        }</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
      </font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
        printf("%i\n", i+=1);</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">&nbsp; &nbsp; return iret;</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">}</font>
    </p>
    <p>
    </p>
    <p><font size="2" color="#4f4f4f" face="Verdana">If i enable IRQ1
        with</font>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">//pRegsIntCtrl-&gt;irqctl
=
        &nbsp;0x00201401; //bit 10,21 =&gt; 1: IRQ1 rising edge active;
        enable
        IRQ1<br>
        the CPU seams to be blocked.</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">I searched the
        internet but
        i couldn't find any help for handling external interrupts with
        posix skin
        in user-space.</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">Is it necessary to
        request
        an irq with native functions from kernel module?</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">I would expect that
        all (request,
        enable setup type ....) is done by the posix functions.</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">Does any one have
        some ideas?</font>
      <br>
      <br>
      <font size="2" color="#4f4f4f" face="Verdana">Thanks</font>
      <br>
    </p>
    <p>
    </p>
    <p><br>
    </p>
    <br>
  </body>
</html>

--------------080307090605010603050809--

