Message-ID: <7289437c0710170748i426c859djd80306468d87389c@domain.hid>
Date: Wed, 17 Oct 2007 16:48:22 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <46827843.8000405@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_33024_19246683.1192632502417"
References: <7289437c0706270727m41d21637tc3030ae2c4f6cf06@domain.hid>
	<46827843.8000405@domain.hid>
Subject: Re: [Xenomai-help] Problem to compile rtdm module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-help <xenomai@xenomai.org>

------=_Part_33024_19246683.1192632502417
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have a question about the Makefile you advise to me.
I used this Makefile until now to compile my RTDM module.
And I want to know how to compile my module and application in the Makefile
directory, not in the source directory.
My Makefile and the sources are in different directories.

Thanks

On 6/27/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Perrine Martignoni wrote:
> > Hello,
> >
> > Currently, I use xenomai 2.3.1 on an ARM9.
> > I try to cross compile a module for my kernel and I don't find the right
> > way
> > to do it, I guess.
> >
> > Here is the code (it's to put the led off and on) :
> >
> > #include <rtdm/rtdm_driver.h>
> > MODULE_LICENSE("GPL");
> >
> > rtdm_task_t heartbeat_task;
> > int         end = 0;
> >
> > #define HEARTBEAT_PERIOD    100000000   /* 100 ms */
> > void heartbeat(void *cookie)
> > {
> > int state = 0;
> > int led_state[] = { 0, 1 };
> > while (!end) {
> >  rtdm_task_wait_period();
> >
> >  at91_set_gpio_value(AT91_PIN_PB2,led_state[state++]);
> >
> >  if (state > 1)
> >   state = 0;
> > }
> > }
> >
> > int init_module(void)
> > {
> >
> > leds_init();
> > return rtdm_task_init(&heartbeat_task, "heartbeat", heartbeat, NULL,99,
> > HEARTBEAT_PERIOD);
> > }
> >
> > void cleanup_module(void)
> > {
> > end = 1;
> > rtdm_task_join_nrt(&heartbeat_task, 100);
> > at91_led_off(AT91_PIN_PB2);
> > }
> >
> > And here is my Makefile :
> >
> > CFLAGS = -g -D__KERNEL__ -DMODULE -I/usr/xenomai_arm-2.3.1uClibc/include
> >
> > LDFLAGS = -D__KERNEL__ -DMODULE
> >
> > test:test_leds.o
> >
> > ld -r -o test.ko -L/usr/xenomai_arm-2.3.1uClibc/lib -lnative -lrtdm
> > test_leds.o
> >
> > test_leds.o:test_leds.c
> >
> > arm-linux-gcc $(CFLAGS) -c test_leds.c
> >
> >
> > When I compile, I have a lot of errors whose the begin is :
> >
> >
> > In file included from
> > /usr/src/ELDK_arm/usr/../arm/usr/include/linux/capability.h:45,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:46,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
> >
> > from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,
> >
> > from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,
> >
> > from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,
> >
> > from test_leds.c:21:
> >
> > /usr/src/ELDK_arm/usr/../arm/usr/include/linux/spinlock.h:280: error:
> parse
> > error before '*' token
> >
> > In file included from
> > /usr/src/ELDK_arm/usr/../arm/usr/include/linux/jiffies.h:4,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
> >
> > from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,
> >
> > from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,
> >
> > from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,
> >
> > from test_leds.c:21:
> >
> > /usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h: In function
> > 'do_div_llr':
> >
> > /usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h:25: error: parse
> > error before '__asmeq'
> >
> > In file included from
> > /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
> >
> > from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,
> >
> > from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,
> >
> >
> >
> > I think it's a problem of option in the Makefile but I don't see. It's
> the
> > first time I do a module for Linux so ...
>
> Have you seen this version of "hearbeat" already?
>
> http://svn.gna.org/viewcvs/xenomai/trunk/examples/rtdm/driver-api/
>
> It's now prepared to handle more than just x86 keyboards. Maybe you want
> to put your LED show into this framework as well.
>
> You can build it with the provided Makefile, calling "make
> KSRC=<kernel-srcdir> XENO=<xenomai-userland-instdir> CROSS_COMPILE=..
> ARCH=...".
>
> Jan
>
>
>

------=_Part_33024_19246683.1192632502417
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, <br><br>I have a question about the Makefile you advise to me.<br>I used this Makefile until now to compile my RTDM module.<br>And I want to know how to compile my module and application in the Makefile directory, not in the source directory.
<br>My Makefile and the sources are in different directories.<br><br>Thanks<br><br><div><span class="gmail_quote">On 6/27/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Perrine Martignoni wrote:<br>&gt; Hello,<br>&gt;<br>&gt; Currently, I use xenomai 
2.3.1 on an ARM9.<br>&gt; I try to cross compile a module for my kernel and I don&#39;t find the right<br>&gt; way<br>&gt; to do it, I guess.<br>&gt;<br>&gt; Here is the code (it&#39;s to put the led off and on) :<br>&gt;
<br>&gt; #include &lt;rtdm/rtdm_driver.h&gt;<br>&gt; MODULE_LICENSE(&quot;GPL&quot;);<br>&gt;<br>&gt; rtdm_task_t heartbeat_task;<br>&gt; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end = 0;<br>&gt;<br>&gt; #define HEARTBEAT_PERIOD&nbsp;&nbsp;&nbsp;&nbsp;100000000&nbsp;&nbsp; /* 100 ms */
<br>&gt; void heartbeat(void *cookie)<br>&gt; {<br>&gt; int state = 0;<br>&gt; int led_state[] = { 0, 1 };<br>&gt; while (!end) {<br>&gt;&nbsp;&nbsp;rtdm_task_wait_period();<br>&gt;<br>&gt;&nbsp;&nbsp;at91_set_gpio_value(AT91_PIN_PB2,led_state[state++]);
<br>&gt;<br>&gt;&nbsp;&nbsp;if (state &gt; 1)<br>&gt;&nbsp;&nbsp; state = 0;<br>&gt; }<br>&gt; }<br>&gt;<br>&gt; int init_module(void)<br>&gt; {<br>&gt;<br>&gt; leds_init();<br>&gt; return rtdm_task_init(&amp;heartbeat_task, &quot;heartbeat&quot;, heartbeat, NULL,99,
<br>&gt; HEARTBEAT_PERIOD);<br>&gt; }<br>&gt;<br>&gt; void cleanup_module(void)<br>&gt; {<br>&gt; end = 1;<br>&gt; rtdm_task_join_nrt(&amp;heartbeat_task, 100);<br>&gt; at91_led_off(AT91_PIN_PB2);<br>&gt; }<br>&gt;<br>&gt; And here is my Makefile :
<br>&gt;<br>&gt; CFLAGS = -g -D__KERNEL__ -DMODULE -I/usr/xenomai_arm-2.3.1uClibc/include<br>&gt;<br>&gt; LDFLAGS = -D__KERNEL__ -DMODULE<br>&gt;<br>&gt; test:test_leds.o<br>&gt;<br>&gt; ld -r -o test.ko -L/usr/xenomai_arm-
2.3.1uClibc/lib -lnative -lrtdm<br>&gt; test_leds.o<br>&gt;<br>&gt; test_leds.o:test_leds.c<br>&gt;<br>&gt; arm-linux-gcc $(CFLAGS) -c test_leds.c<br>&gt;<br>&gt;<br>&gt; When I compile, I have a lot of errors whose the begin is :
<br>&gt;<br>&gt;<br>&gt; In file included from<br>&gt; /usr/src/ELDK_arm/usr/../arm/usr/include/linux/capability.h:45,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:46,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
<br>&gt;<br>&gt; from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,
<br>&gt;<br>&gt; from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,<br>&gt;<br>&gt; from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,<br>&gt;<br>&gt; from test_leds.c:21:<br>&gt;<br>&gt; /usr/src/ELDK_arm/usr/../arm/usr/include/linux/spinlock.h:280: error: parse
<br>&gt; error before &#39;*&#39; token<br>&gt;<br>&gt; In file included from<br>&gt; /usr/src/ELDK_arm/usr/../arm/usr/include/linux/jiffies.h:4,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,
<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,<br>&gt;<br>&gt; from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,
<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,<br>&gt;<br>&gt; from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,<br>&gt;<br>&gt; from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,
<br>&gt;<br>&gt; from test_leds.c:21:<br>&gt;<br>&gt; /usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h: In function<br>&gt; &#39;do_div_llr&#39;:<br>&gt;<br>&gt; /usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h:25: error: parse
<br>&gt; error before &#39;__asmeq&#39;<br>&gt;<br>&gt; In file included from<br>&gt; /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
<br>&gt;<br>&gt; from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,<br>&gt;<br>&gt; from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,<br>&gt;<br>&gt;<br>&gt;<br>&gt; I think it&#39;s a problem of option in the Makefile but I don&#39;t see. It&#39;s the
<br>&gt; first time I do a module for Linux so ...<br><br>Have you seen this version of &quot;hearbeat&quot; already?<br><br><a href="http://svn.gna.org/viewcvs/xenomai/trunk/examples/rtdm/driver-api/">http://svn.gna.org/viewcvs/xenomai/trunk/examples/rtdm/driver-api/
</a><br><br>It&#39;s now prepared to handle more than just x86 keyboards. Maybe you want<br>to put your LED show into this framework as well.<br><br>You can build it with the provided Makefile, calling &quot;make<br>KSRC=&lt;kernel-srcdir&gt; XENO=&lt;xenomai-userland-instdir&gt; CROSS_COMPILE=..
<br>ARCH=...&quot;.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_33024_19246683.1192632502417--

