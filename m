From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Handling a interrupt from user space on PPC405
Date: Thu, 14 Dec 2006 13:43:56 +0100
References: <200612132315.54899.niklaus.giger@domain.hid>
	<4580F7B2.8060600@domain.hid>
In-Reply-To: <4580F7B2.8060600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141343.57539.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>, Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Am Donnerstag, 14. Dezember 2006 08:05 schrieb Heikki Lindholm:
> Niklaus Giger kirjoitti:
> > Hi
> >
> > I tried to use the FIT (Fixed Interrupt Timer) on my PPC405GPr board,
> > which uses 0x1010 as its interrupt vector in a user space (vxworks-skin)
> > application.
> > <..>
> >   RT_INTR FITnterrupt;
> >   res = rt_intr_create(&FITnterrupt, 0, 0x1010, I_NOAUTOENA);
> > <..>
> > But I got -22 EINVAL as error.
> > Could somebody please tell me, what is wrong with my example.
>
> The 0x1010 is the HW interrupt vector, but the argument should be the
> interrupt _line_. Besides, last time I checked, the ppc405 FIT isn't
> even 'wired' in the kernel; actually, there's no space for the interrupt
> prologue code, which basically results that no handler is called when
> the FIT interrupt occurs.
>
Thanks a lot for your tip. 
I did now test using IPIPE_TRAP_UNKNOWN, where my main test routine looks like 
this.
>   int res, j;
>   RT_INTR FITnterrupt;
>   printf("\n%s:", __FUNCTION__);
>   // res = rt_intr_create(&FITnterrupt, "sysAuxClk", 0x1010, I_NOAUTOENA);
>   // returns -22 EINVAL
>   res = rt_intr_create(&FITnterrupt, 0, IPIPE_TRAP_UNKNOWN, I_NOAUTOENA);
>   perror("rt_intr_create returned " );
>   printf("%s: rt_intr_create return %d errno %s\n", __FUNCTION__, res,
> strerror(res)); if (res != 0) exit(1);
>
>   res = rt_intr_enable(&FITnterrupt);
>   printf("%s: rt_intr_enable return %d errno %s\n", __FUNCTION__, res,
> strerror(res));
>
>   for (j=0; j < 3; j++)
>   {
>     /* Timeout is one second in timer jiffies, as with vxworks we have the
> periodic time */ res = rt_intr_wait(&FITnterrupt, sysClkRateGet());
>     printf("%s: rt_intr_wait return %d errno %s\n", __FUNCTION__, res,
> strerror(res)); }
>   res = rt_intr_disable(&FITnterrupt);
>   printf("%s: rt_intr_disable return %d errno %s\n", __FUNCTION__, res,
> strerror(res));
>
>   res = rt_intr_delete(&FITnterrupt);
>   printf("%s: rt_intr_delete return %d errno %s\n", __FUNCTION__, res,
> strerror(res)); exit(0);

My output at the target now looks like.
> __xeno_user_init: rt_intr_enable return 0 errno Success
> __xeno_user_init: rt_intr_wait return -110 errno Unknown error 4294967186
> __xeno_user_init: rt_intr_wait return -110 errno Unknown error 4294967186
> __xeno_user_init: rt_intr_wait return -110 errno Unknown error 4294967186
> __xeno_user_init: rt_intr_disable return 0 errno Success
> __xeno_user_init: rt_intr_delete return 0 errno Success

This is what I expect, as this interrupt should not occur.
IPIPE_TRAP_UNKNOWN however cannot be found in any *.h exported 
to /usr/xenomai/include. I found it in include/asm-ppc/ipipe.h in the patched 
Linux kernel.
So I suppose, that some how Xenomai should export this definition to user 
space, too. 

Dealing with FIT and other interrupts will take some more time. But I would 
like to thank you and Wolfgang for your help, as your answers helped me a lot 
to see the problem.

Best regards

-- 
Niklaus Giger

