MIME-Version: 1.0
In-Reply-To: <mailman.23791.1308732965.23203.xenomai@xenomai.org>
References: <mailman.23791.1308732965.23203.xenomai@xenomai.org>
Date: Wed, 22 Jun 2011 23:12:26 +0800
Message-ID: <BANLkTi=44ph9OPPO_DBmcPZOXLdjwLqqEQ@mail.gmail.com>
From: Fang Qiang <fq0237@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307f377a71cd4504a64e65da
Subject: Re: [Xenomai-help] Xenomai-help Digest, Vol 69, Issue 30
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

--20cf307f377a71cd4504a64e65da
Content-Type: text/plain; charset=ISO-8859-1

Hi Gills,

    Thank you for your reply.

    I did not try xenomai2.5.6. I will try it and hope it works.

Qiang

2011/6/22 <xenomai-help-request@domain.hid>

> Send Xenomai-help mailing list submissions to
>        xenomai@xenomai.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://mail.gna.org/listinfo/xenomai-help
> or, via email, send a message with subject or body 'help' to
>        xenomai-help-request@domain.hid
>
> You can reach the person managing the list at
>        xenomai-help-owner@domain.hid
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai-help digest..."
>
>
> Today's Topics:
>
>   1. Re: Xenomai-Driver (sanjay anvekar)
>   2. Re: ask help for xenomai-2.5.5.1 (Gilles Chanteperdrix)
>   3. Re: Xenomai-Driver (Gilles Chanteperdrix)
>   4. Re: mprotect in Xenomai (Michael Thalmeier)
>   5. Re: regarding ARMv.s error (Gilles Chanteperdrix)
>   6. rt_dev_ioctl (David Wiebe)
>   7. Re: Xenomai 2.5.6 and 2.6.38.8 kernel (VEYSSIERE Nicolas)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 21 Jun 2011 20:29:04 -0700 (PDT)
> From: sanjay anvekar <sanjayanvekar@domain.hid>
> Subject: Re: [Xenomai-help] Xenomai-Driver
> To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Message-ID: <858255.34222.qm@domain.hid>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi Gilles,
> ???? Thanks for your reply. With GDB I am able to run the application but
> it never hits configured breakpoints
> and it takes little longer time to start application. I tried changing
> priority of tasks, but it didn't help.
> In my application program I have not configured any interrupts and
> completely dependent on Linux drivers.
> If I do not use rt_task_sleep() my program does not work correctly. I tried
> to suspend each task instead of
>
> using rt_task_sleep and resume them in shadow task but some how it did not
> work .
>
> 'rt_task_set_mode(0,XNRRB ,NULL)' didn't return any error , but when I
> tried with T_RRB parameter
> instead of XNRRB it failed.
>
> Best Regards,
> Sanjay
>
>
>
>
> ________________________________
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> To: sanjay anvekar <sanjayanvekar@domain.hid>
> Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Sent: Wednesday, 22 June 2011 2:24 AM
> Subject: Re: [Xenomai-help] Xenomai-Driver
>
> On 06/21/2011 02:02 PM, sanjay anvekar wrote:
> > Hi Gilles, Thanks for your reply. I am using 'rt_task_sleep(100us)'
> > at the end of every task to let Linux task run. With this I am able
> > to run my application program , but I am not able to debug using
> > 'GDB'.
>
> What happens when you try and debug with gdb?
>
> > Also is there any better way to allow Linux task run instead
> > of using 'rt_task_sleep' ? My application has got 5 different task of
>
> First, the application should wait interrupts and react upon them, not
> do any polling, this should normally leave some time for Linux to run if
> the system is well dimensioned.
>
> >
> >
> > equal priority and I want to run these in Round Robin fashion , I
> > used 'rt_task_set_mode(0,XNRRB ,NULL)' to enable Round Robin
> > scheduling mode, but task are not getting executed in Round Robin
> > fashion.
>
> I do not think round-robin is what you want: it will not let linux run.
> rt_task_set_mode probably returns an error when you use XNRRB, because
> it does not expect this bit to be set.
>
> --
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? Gilles.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: </public/xenomai-help/attachments/20110621/cac1ced8/attachment.htm>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 22 Jun 2011 08:54:44 +0200
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-help] ask help for xenomai-2.5.5.1
> To: Fang Qiang <fq0237@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <4E0191B4.7020005@domain.hid>
> Content-Type: text/plain; charset=UTF-8
>
> On 06/22/2011 03:03 AM, Fang Qiang wrote:
> > Dear all,
> >
> >        I installed xenomai-2.5.5.1 on x86 with kernel 2.6.35.7 by
> following
> > the instruction of Readme.Install.
> >
> >       After that, I ran the latency test, and got the following results.
> I
> > have no idea about whether results are correct or not?
> >
> >       Is there anybody help me with this? Thanks in advance.
>
> Do you observe the same behaviour with xenomai 2.5.6 ?
>
> --
>                                                                Gilles.
>
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 22 Jun 2011 09:02:00 +0200
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-help] Xenomai-Driver
> To: sanjay anvekar <sanjayanvekar@domain.hid>
> Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Message-ID: <4E019368.9020800@domain.hid>
> Content-Type: text/plain; charset=UTF-8
>
> On 06/22/2011 05:29 AM, sanjay anvekar wrote:
> > Hi Gilles, Thanks for your reply. With GDB I am able to run the
> > application but it never hits configured breakpoints and it takes
> > little longer time to start application. I tried changing priority of
> > tasks, but it didn't help. In my application program I have not
> > configured any interrupts and completely dependent on Linux drivers.
> > If I do not use rt_task_sleep() my program does not work correctly. I
> > tried to suspend each task instead of
>
> Without seeing any code it is hard to give any definite answer, but from
> the way you describe it, you do not need Xenomai: as soon as a real-time
> thread uses a Linux driver, it is no longer deterministic. A typical
> real-time application waits for an external event, be it a timer event
> or a real-time driver, and so suspend naturally to let Linux run.
>
> --
>                                                                Gilles.
>
>
>
> ------------------------------
>
> Message: 4
> Date: Wed, 22 Jun 2011 09:08:47 +0200
> From: Michael Thalmeier <michael@domain.hid>
> Subject: Re: [Xenomai-help] mprotect in Xenomai
> To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Cc: xenomai@xenomai.org
> Message-ID: <4c54d6289dd4237b16e9dab98d96bde1@domain.hid>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
>  On Wed, 22 Jun 2011 00:17:13 +0200, Gilles Chanteperdrix wrote:
> > On 06/21/2011 11:08 AM, Michael Thalmeier wrote:
> >> Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:
> >>
> >>>
> >>> On 06/20/2011 04:14 PM, Michael Thalmeier wrote:
> >>>>  Hello !
> >>>>  ...
> >>>
> >>> I am afraid this is platform dependent, on what architecture do you
> >>> get
> >>> this behaviour?
> >>>
> >> I have only tested this behaviour on x86 until now.
> >> The system runs a kernel 2.6.32.15 with xenomai 2.5.6.
> >
> > Issue reproduced, and seem specific to x86 (32, the application
> > segfaults on x86_64).
> >
> > The answer to the original question is no: we do not provide any
> > service
> > to do the same thing as mprotect, so, if you want this application to
> > work, you will have to dig in the kernel mm code and find exactly
> > what
> > is going on.
>
>  Thanks for your efforts.
>  I am already studying the kernel mm code to find the cause of our
>  problem.
>
> --
>  Michael Thalmeier
>
>
>
> ------------------------------
>
> Message: 5
> Date: Wed, 22 Jun 2011 09:19:26 +0200
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-help] regarding ARMv.s error
> To: suresh reddy <sureshreddy.balijepalli@domain.hid>
> Cc: Xenomai help <xenomai@xenomai.org>
> Message-ID: <4E01977E.1080202@domain.hid>
> Content-Type: text/plain; charset=UTF-8
>
> On 06/21/2011 04:02 PM, Gilles Chanteperdrix wrote:
> > On 06/21/2011 03:11 PM, suresh reddy wrote:
> >> Dear all,
> >>
> >>
> >> i have downloaded ipipe patched kernel from xenomai git .and applied the
> >> patches to the xenomai 2.5.6 sources as mentioned .
> >>
> >> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build
> >> omap2plus_defconfig
> >> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build
> menuconfig
> >>
> >> i just removed all the other boards from TI except Pandaboard. I did not
> >> touched any other options.
> >>
> >> then I run the command
> >>
> >> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build uImage
> >>
> >> then it giving me the error as below
> >>
> >> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:
> Assembler
> >> messages:
> >> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407:
> Error:
> >> undefined symbol `.L99973' in operation setting `up_b_offset'
> >> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407:
> Error:
> >> undefined symbol `.L99973' in operation setting `up_b_offset'
> >> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407:
> Error:
> >> local label `"9997" (instance number 3 of a fb label)' is not defined
> >> make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
> >> make[1]: *** [arch/arm/kernel] Error 2
> >> make: *** [sub-make] Error 2
> >
> > Disable SMP kernel boot on UP system, you do not need it for OMAP4,
> > since OMAP4 is an SMP system.
> >
>
> It turns out the SMP on UP option can be enabled. Please try the .config
> I use:
> http://sisyphus.hd.free.fr/~gilles/omap4_panda_config
>
> --
>                                                                Gilles.
>
>
>
> ------------------------------
>
> Message: 6
> Date: Wed, 22 Jun 2011 01:43:24 -0700
> From: David Wiebe <dwiebe2@domain.hid>
> Subject: [Xenomai-help] rt_dev_ioctl
> To: xenomai@xenomai.org
> Message-ID: <4E01AB2C.4070409@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Hello,
>
> I'm re-writing my code to work with xenomai and I don't know how to get
> rt_dev_ioctl to compile in my program.
>
> #include <rtdk.h> in my program doesn't help
>
>
> david@domain.hid$
> arm-none-linux-gnueabi-gcc -o xenomai-spi-eth-00002 $CFLAGS
> xenomai-spi-eth-00002.c $LDFLAGS -I
> /home/david/122720101858-beagleboard-working-set/kernel/linux/include/
> xenomai-spi-eth-00002.c: In function 'main':
> xenomai-spi-eth-00002.c:137: warning: implicit declaration of function
> 'rt_dev_open'
> xenomai-spi-eth-00002.c:145: warning: implicit declaration of function
> 'rt_dev_ioctl'
> /tmp/ccZErCuj.o: In function `main':
> xenomai-spi-eth-00002.c:(.text+0x2c4): undefined reference to `rt_dev_open'
> xenomai-spi-eth-00002.c:(.text+0x318): undefined reference to
> `rt_dev_ioctl'
> collect2: ld returned 1 exit status
>
>
> David
>
>
>
>
> ------------------------------
>
> Message: 7
> Date: Wed, 22 Jun 2011 10:55:35 +0200
> From: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
> Subject: Re: [Xenomai-help] Xenomai 2.5.6 and 2.6.38.8 kernel
> To: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Message-ID:
>
>  <2157_1308732935_4E01AE07_2157_14293_1_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15@domain.hid
> >
>
> Content-Type: text/plain; charset="us-ascii"
>
> Same thing here, I tried to patch linux 2.6.38 with the latest adeos patch
> (
> http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.38.8-x86-2.10-00.patch)
> but the kernel compilation failed :
>
>
> ......
>  LD      arch/x86/pci/built-in.o
>  CC      arch/x86/power/cpu.o
>  CC      arch/x86/power/hibernate_32.o
>  AS      arch/x86/power/hibernate_asm_32.o
>  LD      arch/x86/power/built-in.o
>  CC      arch/x86/video/fbdev.o
>  LD      arch/x86/video/built-in.o
>  CC      arch/x86/xenomai/hal_32.o
> arch/x86/xenomai/hal_32.c: In function 'rthal_arch_init':
> arch/x86/xenomai/hal_32.c:341: error: 'nmi_watchdog' undeclared (first use
> in this function)
> arch/x86/xenomai/hal_32.c:341: error: (Each undeclared identifier is
> reported only once
> arch/x86/xenomai/hal_32.c:341: error: for each function it appears in.)
> arch/x86/xenomai/hal_32.c:341: error: 'NMI_IO_APIC' undeclared (first use
> in this function)
> At top level:
> cc1: warning: unrecognized command line option
> "-Wno-unused-but-set-variable"
> make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
> make: *** [arch/x86/xenomai] Error 2
>
>
>
> Can someone tell me what to do ?
>
> Thanks.
>
> Regards,
>
> --
> Nicolas VEYSSIERE
>
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: </public/xenomai-help/attachments/20110622/fa0e2b1c/attachment.htm>
>
> ------------------------------
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
> End of Xenomai-help Digest, Vol 69, Issue 30
> ********************************************
>



-- 
Qiang FANG
Phonetics Lab., Institute of Linguistics
Chinese Academy of Social Sciences
5#, Jian Guo Men Nei Da Jie, Beijing, China 100732
Tel: 86-10-65237408

--20cf307f377a71cd4504a64e65da
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gills,<br>
<br>
=A0=A0=A0 Thank you for your reply.=A0 <br>
<br>
=A0=A0=A0 I did not try xenomai2.5.6. I will try it and hope it works.<br>
<br>
Qiang <br><br><div class=3D"gmail_quote">2011/6/22  <span dir=3D"ltr">&lt;<=
a href=3D"mailto:xenomai-help-request@domain.hid">xenomai-help-request@domain.hid=
</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex;">
Send Xenomai-help mailing list submissions to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org=
g</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
 =A0 =A0 =A0 =A0<a href=3D"https://mail.gna.org/listinfo/xenomai-help" targ=
et=3D"_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:xenomai-help-request@domain.hid">xenomai-hel=
p-request@domain.hid</a><br>
<br>
You can reach the person managing the list at<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:xenomai-help-owner@domain.hid">xenomai-help-=
owner@domain.hid</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of Xenomai-help digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
 =A0 1. Re: Xenomai-Driver (sanjay anvekar)<br>
 =A0 2. Re: ask help for xenomai-2.5.5.1 (Gilles Chanteperdrix)<br>
 =A0 3. Re: Xenomai-Driver (Gilles Chanteperdrix)<br>
 =A0 4. Re: mprotect in Xenomai (Michael Thalmeier)<br>
 =A0 5. Re: regarding ARMv.s error (Gilles Chanteperdrix)<br>
 =A0 6. rt_dev_ioctl (David Wiebe)<br>
 =A0 7. Re: Xenomai 2.5.6 and 2.6.38.8 kernel (VEYSSIERE Nicolas)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Tue, 21 Jun 2011 20:29:04 -0700 (PDT)<br>
From: sanjay anvekar &lt;<a href=3D"mailto:sanjayanvekar@domain.hid">sanjaya=
nvekar@domain.hid</a>&gt;<br>
Subject: Re: [Xenomai-help] Xenomai-Driver<br>
To: Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
quot; &lt;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
gt;<br>
Message-ID: &lt;<a href=3D"mailto:858255.34222.qm@domain.hid=
om">858255.34222.qm@domain.hid</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
Hi Gilles,<br>
???? Thanks for your reply. With GDB I am able to run the application but i=
t never hits configured breakpoints<br>
and it takes little longer time to start application. I tried changing prio=
rity of tasks, but it didn&#39;t help.<br>
In my application program I have not configured any interrupts and complete=
ly dependent on Linux drivers.<br>
If I do not use rt_task_sleep() my program does not work correctly. I tried=
 to suspend each task instead of<br>
<br>
using rt_task_sleep and resume them in shadow task but some how it did not =
work .<br>
<br>
&#39;rt_task_set_mode(0,XNRRB ,NULL)&#39; didn&#39;t return any error , but=
 when I tried with T_RRB parameter<br>
instead of XNRRB it failed.<br>
<br>
Best Regards,<br>
Sanjay<br>
<br>
<br>
<br>
<br>
________________________________<br>
From: Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
ai.org">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
To: sanjay anvekar &lt;<a href=3D"mailto:sanjayanvekar@domain.hid">sanjayanv=
ekar@domain.hid</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
quot; &lt;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
gt;<br>
Sent: Wednesday, 22 June 2011 2:24 AM<br>
Subject: Re: [Xenomai-help] Xenomai-Driver<br>
<br>
On 06/21/2011 02:02 PM, sanjay anvekar wrote:<br>
&gt; Hi Gilles, Thanks for your reply. I am using &#39;rt_task_sleep(100us)=
&#39;<br>
&gt; at the end of every task to let Linux task run. With this I am able<br=
>
&gt; to run my application program , but I am not able to debug using<br>
&gt; &#39;GDB&#39;.<br>
<br>
What happens when you try and debug with gdb?<br>
<br>
&gt; Also is there any better way to allow Linux task run instead<br>
&gt; of using &#39;rt_task_sleep&#39; ? My application has got 5 different =
task of<br>
<br>
First, the application should wait interrupts and react upon them, not<br>
do any polling, this should normally leave some time for Linux to run if<br=
>
the system is well dimensioned.<br>
<br>
&gt;<br>
&gt;<br>
&gt; equal priority and I want to run these in Round Robin fashion , I<br>
&gt; used &#39;rt_task_set_mode(0,XNRRB ,NULL)&#39; to enable Round Robin<b=
r>
&gt; scheduling mode, but task are not getting executed in Round Robin<br>
&gt; fashion.<br>
<br>
I do not think round-robin is what you want: it will not let linux run.<br>
rt_task_set_mode probably returns an error when you use XNRRB, because<br>
it does not expect this bit to be set.<br>
<br>
--<br>
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? Gilles.<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: &lt;/public/xenomai-help/attachments/20110621/cac1ced8/attachment.htm&=
gt;<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Wed, 22 Jun 2011 08:54:44 +0200<br>
From: Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
ai.org">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
Subject: Re: [Xenomai-help] ask help for xenomai-2.5.5.1<br>
To: Fang Qiang &lt;<a href=3D"mailto:fq0237@domain.hid">fq0237@domain.hid</a>=
&gt;<br>
Cc: <a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br>
Message-ID: &lt;<a href=3D"mailto:4E0191B4.7020005@domain.hid">4E0191B4.70=
20005@domain.hid</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br>
<br>
On 06/22/2011 03:03 AM, Fang Qiang wrote:<br>
&gt; Dear all,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0I installed xenomai-2.5.5.1 on x86 with kernel 2.6.35.7=
 by following<br>
&gt; the instruction of Readme.Install.<br>
&gt;<br>
&gt; =A0 =A0 =A0 After that, I ran the latency test, and got the following =
results. I<br>
&gt; have no idea about whether results are correct or not?<br>
&gt;<br>
&gt; =A0 =A0 =A0 Is there anybody help me with this? Thanks in advance.<br>
<br>
Do you observe the same behaviour with xenomai 2.5.6 ?<br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Wed, 22 Jun 2011 09:02:00 +0200<br>
From: Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
ai.org">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
Subject: Re: [Xenomai-help] Xenomai-Driver<br>
To: sanjay anvekar &lt;<a href=3D"mailto:sanjayanvekar@domain.hid">sanjayanv=
ekar@domain.hid</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
quot; &lt;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
gt;<br>
Message-ID: &lt;<a href=3D"mailto:4E019368.9020800@domain.hid">4E019368.90=
20800@domain.hid</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br>
<br>
On 06/22/2011 05:29 AM, sanjay anvekar wrote:<br>
&gt; Hi Gilles, Thanks for your reply. With GDB I am able to run the<br>
&gt; application but it never hits configured breakpoints and it takes<br>
&gt; little longer time to start application. I tried changing priority of<=
br>
&gt; tasks, but it didn&#39;t help. In my application program I have not<br=
>
&gt; configured any interrupts and completely dependent on Linux drivers.<b=
r>
&gt; If I do not use rt_task_sleep() my program does not work correctly. I<=
br>
&gt; tried to suspend each task instead of<br>
<br>
Without seeing any code it is hard to give any definite answer, but from<br=
>
the way you describe it, you do not need Xenomai: as soon as a real-time<br=
>
thread uses a Linux driver, it is no longer deterministic. A typical<br>
real-time application waits for an external event, be it a timer event<br>
or a real-time driver, and so suspend naturally to let Linux run.<br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Wed, 22 Jun 2011 09:08:47 +0200<br>
From: Michael Thalmeier &lt;<a href=3D"mailto:michael@domain.hid">michael=
@thalmeier.at</a>&gt;<br>
Subject: Re: [Xenomai-help] mprotect in Xenomai<br>
To: Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
Cc: <a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br>
Message-ID: &lt;<a href=3D"mailto:4c54d6289dd4237b16e9dab98d96bde1@domain.hid=
r.at">4c54d6289dd4237b16e9dab98d96bde1@domain.hid</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
<br>
=A0On Wed, 22 Jun 2011 00:17:13 +0200, Gilles Chanteperdrix wrote:<br>
&gt; On 06/21/2011 11:08 AM, Michael Thalmeier wrote:<br>
&gt;&gt; Gilles Chanteperdrix &lt;gilles.chanteperdrix &lt;at&gt; <a href=
=3D"http://xenomai.org" target=3D"_blank">xenomai.org</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 06/20/2011 04:14 PM, Michael Thalmeier wrote:<br>
&gt;&gt;&gt;&gt; =A0Hello !<br>
&gt;&gt;&gt;&gt; =A0...<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am afraid this is platform dependent, on what architecture d=
o you<br>
&gt;&gt;&gt; get<br>
&gt;&gt;&gt; this behaviour?<br>
&gt;&gt;&gt;<br>
&gt;&gt; I have only tested this behaviour on x86 until now.<br>
&gt;&gt; The system runs a kernel 2.6.32.15 with xenomai 2.5.6.<br>
&gt;<br>
&gt; Issue reproduced, and seem specific to x86 (32, the application<br>
&gt; segfaults on x86_64).<br>
&gt;<br>
&gt; The answer to the original question is no: we do not provide any<br>
&gt; service<br>
&gt; to do the same thing as mprotect, so, if you want this application to<=
br>
&gt; work, you will have to dig in the kernel mm code and find exactly<br>
&gt; what<br>
&gt; is going on.<br>
<br>
=A0Thanks for your efforts.<br>
=A0I am already studying the kernel mm code to find the cause of our<br>
=A0problem.<br>
<br>
--<br>
=A0Michael Thalmeier<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Wed, 22 Jun 2011 09:19:26 +0200<br>
From: Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
ai.org">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
Subject: Re: [Xenomai-help] regarding ARMv.s error<br>
To: suresh reddy &lt;<a href=3D"mailto:sureshreddy.balijepalli@domain.hid">s=
ureshreddy.balijepalli@domain.hid</a>&gt;<br>
Cc: Xenomai help &lt;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org=
na.org</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:4E01977E.1080202@domain.hid">4E01977E.10=
80202@domain.hid</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br>
<br>
On 06/21/2011 04:02 PM, Gilles Chanteperdrix wrote:<br>
&gt; On 06/21/2011 03:11 PM, suresh reddy wrote:<br>
&gt;&gt; Dear all,<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; i have downloaded ipipe patched kernel from xenomai git .and appli=
ed the<br>
&gt;&gt; patches to the xenomai 2.5.6 sources as mentioned .<br>
&gt;&gt;<br>
&gt;&gt; make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D../bui=
ld<br>
&gt;&gt; omap2plus_defconfig<br>
&gt;&gt; make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D../bui=
ld menuconfig<br>
&gt;&gt;<br>
&gt;&gt; i just removed all the other boards from TI except Pandaboard. I d=
id not<br>
&gt;&gt; touched any other options.<br>
&gt;&gt;<br>
&gt;&gt; then I run the command<br>
&gt;&gt;<br>
&gt;&gt; make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D../bui=
ld uImage<br>
&gt;&gt;<br>
&gt;&gt; then it giving me the error as below<br>
&gt;&gt;<br>
&gt;&gt; /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S: As=
sembler<br>
&gt;&gt; messages:<br>
&gt;&gt; /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:140=
7: Error:<br>
&gt;&gt; undefined symbol `.L99973&#39; in operation setting `up_b_offset&#=
39;<br>
&gt;&gt; /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:140=
7: Error:<br>
&gt;&gt; undefined symbol `.L99973&#39; in operation setting `up_b_offset&#=
39;<br>
&gt;&gt; /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:140=
7: Error:<br>
&gt;&gt; local label `&quot;9997&quot; (instance number 3 of a fb label)&#3=
9; is not defined<br>
&gt;&gt; make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1<br>
&gt;&gt; make[1]: *** [arch/arm/kernel] Error 2<br>
&gt;&gt; make: *** [sub-make] Error 2<br>
&gt;<br>
&gt; Disable SMP kernel boot on UP system, you do not need it for OMAP4,<br=
>
&gt; since OMAP4 is an SMP system.<br>
&gt;<br>
<br>
It turns out the SMP on UP option can be enabled. Please try the .config<br=
>
I use:<br>
<a href=3D"http://sisyphus.hd.free.fr/%7Egilles/omap4_panda_config" target=
=3D"_blank">http://sisyphus.hd.free.fr/~gilles/omap4_panda_config</a><br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 6<br>
Date: Wed, 22 Jun 2011 01:43:24 -0700<br>
From: David Wiebe &lt;<a href=3D"mailto:dwiebe2@domain.hid">dwiebe2@domain.hid=
t</a>&gt;<br>
Subject: [Xenomai-help] rt_dev_ioctl<br>
To: <a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br>
Message-ID: &lt;<a href=3D"mailto:4E01AB2C.4070409@domain.hid">4E01AB2C.4070=
409@domain.hid</a>&gt;<br>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed<br>
<br>
Hello,<br>
<br>
I&#39;m re-writing my code to work with xenomai and I don&#39;t know how to=
 get<br>
rt_dev_ioctl to compile in my program.<br>
<br>
#include &lt;rtdk.h&gt; in my program doesn&#39;t help<br>
<br>
<br>
david@domain.hid$<br>
arm-none-linux-gnueabi-gcc -o xenomai-spi-eth-00002 $CFLAGS<br>
xenomai-spi-eth-00002.c $LDFLAGS -I<br>
/home/david/122720101858-beagleboard-working-set/kernel/linux/include/<br>
xenomai-spi-eth-00002.c: In function &#39;main&#39;:<br>
xenomai-spi-eth-00002.c:137: warning: implicit declaration of function<br>
&#39;rt_dev_open&#39;<br>
xenomai-spi-eth-00002.c:145: warning: implicit declaration of function<br>
&#39;rt_dev_ioctl&#39;<br>
/tmp/ccZErCuj.o: In function `main&#39;:<br>
xenomai-spi-eth-00002.c:(.text+0x2c4): undefined reference to `rt_dev_open&=
#39;<br>
xenomai-spi-eth-00002.c:(.text+0x318): undefined reference to `rt_dev_ioctl=
&#39;<br>
collect2: ld returned 1 exit status<br>
<br>
<br>
David<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 7<br>
Date: Wed, 22 Jun 2011 10:55:35 +0200<br>
From: VEYSSIERE Nicolas &lt;<a href=3D"mailto:nicolas.veyssiere@domain.hid=
.com">nicolas.veyssiere@domain.hid</a>&gt;<br>
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and 2.6.38.8 kernel<br>
To: &quot;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
quot; &lt;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&=
gt;<br>
Message-ID:<br>
 =A0 =A0 =A0 =A0&lt;2157_1308732935_4E01AE07_2157_14293_1_ECB646CBB62FD0449=
27FDEDF0252D3E701E388AD6F15@domain.hid&gt;<br>
<br>
Content-Type: text/plain; charset=3D&quot;us-ascii&quot;<br>
<br>
Same thing here, I tried to patch linux 2.6.38 with the latest adeos patch =
(<a href=3D"http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.=
38.8-x86-2.10-00.patch" target=3D"_blank">http://download.gna.org/adeos/pat=
ches/v2.6/x86/adeos-ipipe-2.6.38.8-x86-2.10-00.patch</a>) but the kernel co=
mpilation failed :<br>

<br>
<br>
......<br>
 =A0LD =A0 =A0 =A0arch/x86/pci/built-in.o<br>
 =A0CC =A0 =A0 =A0arch/x86/power/cpu.o<br>
 =A0CC =A0 =A0 =A0arch/x86/power/hibernate_32.o<br>
 =A0AS =A0 =A0 =A0arch/x86/power/hibernate_asm_32.o<br>
 =A0LD =A0 =A0 =A0arch/x86/power/built-in.o<br>
 =A0CC =A0 =A0 =A0arch/x86/video/fbdev.o<br>
 =A0LD =A0 =A0 =A0arch/x86/video/built-in.o<br>
 =A0CC =A0 =A0 =A0arch/x86/xenomai/hal_32.o<br>
arch/x86/xenomai/hal_32.c: In function &#39;rthal_arch_init&#39;:<br>
arch/x86/xenomai/hal_32.c:341: error: &#39;nmi_watchdog&#39; undeclared (fi=
rst use in this function)<br>
arch/x86/xenomai/hal_32.c:341: error: (Each undeclared identifier is report=
ed only once<br>
arch/x86/xenomai/hal_32.c:341: error: for each function it appears in.)<br>
arch/x86/xenomai/hal_32.c:341: error: &#39;NMI_IO_APIC&#39; undeclared (fir=
st use in this function)<br>
At top level:<br>
cc1: warning: unrecognized command line option &quot;-Wno-unused-but-set-va=
riable&quot;<br>
make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1<br>
make: *** [arch/x86/xenomai] Error 2<br>
<br>
<br>
<br>
Can someone tell me what to do ?<br>
<br>
Thanks.<br>
<br>
Regards,<br>
<br>
--<br>
Nicolas VEYSSIERE<br>
<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: &lt;/public/xenomai-help/attachments/20110622/fa0e2b1c/attachment.htm&=
gt;<br>
<br>
------------------------------<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
<br>
End of Xenomai-help Digest, Vol 69, Issue 30<br>
********************************************<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Qiang FANG<br>Phonetics=
 Lab., Institute of Linguistics<br>Chinese Academy of Social Sciences<br>5#=
, Jian Guo Men Nei Da Jie, Beijing, China 100732<br>Tel: 86-10-65237408<br>


--20cf307f377a71cd4504a64e65da--

