Message-ID: <7289437c0706270727m41d21637tc3030ae2c4f6cf06@domain.hid>
Date: Wed, 27 Jun 2007 16:27:27 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32894_7753881.1182954447986"
Subject: [Xenomai-help] Problem to compile rtdm module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_32894_7753881.1182954447986
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Currently, I use xenomai 2.3.1 on an ARM9.
I try to cross compile a module for my kernel and I don't find the right way
to do it, I guess.

Here is the code (it's to put the led off and on) :

#include <rtdm/rtdm_driver.h>
MODULE_LICENSE("GPL");

rtdm_task_t heartbeat_task;
int         end = 0;

#define HEARTBEAT_PERIOD    100000000   /* 100 ms */
void heartbeat(void *cookie)
{
 int state = 0;
 int led_state[] = { 0, 1 };
 while (!end) {
  rtdm_task_wait_period();

  at91_set_gpio_value(AT91_PIN_PB2,led_state[state++]);

  if (state > 1)
   state = 0;
 }
}

int init_module(void)
{

leds_init();
return rtdm_task_init(&heartbeat_task, "heartbeat", heartbeat, NULL,99,
HEARTBEAT_PERIOD);
}

void cleanup_module(void)
{
 end = 1;
 rtdm_task_join_nrt(&heartbeat_task, 100);
 at91_led_off(AT91_PIN_PB2);
}

And here is my Makefile :

CFLAGS = -g -D__KERNEL__ -DMODULE -I/usr/xenomai_arm-2.3.1uClibc/include

LDFLAGS = -D__KERNEL__ -DMODULE

test:test_leds.o

ld -r -o test.ko -L/usr/xenomai_arm-2.3.1uClibc/lib -lnative -lrtdm
test_leds.o

test_leds.o:test_leds.c

arm-linux-gcc $(CFLAGS) -c test_leds.c


When I compile, I have a lot of errors whose the begin is :


In file included from
/usr/src/ELDK_arm/usr/../arm/usr/include/linux/capability.h:45,

from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:46,

from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,

from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,

from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,

from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,

from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,

from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,

from test_leds.c:21:

/usr/src/ELDK_arm/usr/../arm/usr/include/linux/spinlock.h:280: error: parse
error before '*' token

In file included from
/usr/src/ELDK_arm/usr/../arm/usr/include/linux/jiffies.h:4,

from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,

from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,

from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,

from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,

from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,

from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,

from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,

from test_leds.c:21:

/usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h: In function
'do_div_llr':

/usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h:25: error: parse
error before '__asmeq'

In file included from
/usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,

from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,

from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,

from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,



I think it's a problem of option in the Makefile but I don't see. It's the
first time I do a module for Linux so ...

thanks

------=_Part_32894_7753881.1182954447986
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><font face="arial,sans-serif">Hello, </font></div>
<div><font face="arial,sans-serif"></font>&nbsp;</div>
<div><font face="arial,sans-serif">Currently, I use xenomai 2.3.1 on an ARM9.</font></div>
<div><font face="arial,sans-serif">I try to cross&nbsp;compile a module for my kernel and I don&#39;t find the right way to do it, I guess.</font></div>
<div><font face="arial,sans-serif"></font>&nbsp;</div>
<div><font face="arial,sans-serif">Here is the code (it&#39;s to put the led off and on) : </font></div>
<div>&nbsp;</div>
<div><font face="courier new,monospace">#include &lt;rtdm/rtdm_driver.h&gt;</font></div>
<div><font face="courier new,monospace">MODULE_LICENSE(&quot;GPL&quot;);</font></div>
<div>
<p><font face="courier new,monospace">rtdm_task_t heartbeat_task;<br>int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end = 0;</font></p>
<p><font face="courier new,monospace">#define HEARTBEAT_PERIOD&nbsp;&nbsp;&nbsp; 100000000&nbsp;&nbsp; /* 100 ms */<br>void heartbeat(void *cookie)<br>{<br>&nbsp;int state = 0;<br>&nbsp;int led_state[] = { 0, 1 };<br>&nbsp;while (!end) {<br>&nbsp;&nbsp;rtdm_task_wait_period();
<br>&nbsp;<br>&nbsp;&nbsp;at91_set_gpio_value(AT91_PIN_PB2,led_state[state++]);<br>&nbsp;<br>&nbsp;&nbsp;if (state &gt; 1)<br>&nbsp;&nbsp;&nbsp;state = 0;<br>&nbsp;}<br>}</font></p>
<p><font face="courier new,monospace">int init_module(void)<br>{</font></p>
<p><font face="courier new,monospace">leds_init();<br>return rtdm_task_init(&amp;heartbeat_task, &quot;heartbeat&quot;, heartbeat, NULL,99, HEARTBEAT_PERIOD);<br>}</font></p>
<p><font face="courier new,monospace">void cleanup_module(void)<br>{<br>&nbsp;end = 1;<br>&nbsp;rtdm_task_join_nrt(&amp;heartbeat_task, 100);<br>&nbsp;at91_led_off(AT91_PIN_PB2);<br>}<br></font><font face="courier new,monospace"><font face="">
<font face="arial,sans-serif"></font></font></font></p>
<p><font face="courier new,monospace"><font face=""><font face="arial,sans-serif">And here is my Makefile : </font></font></font></p><font face="courier new,monospace"><font face=""><font face="Arial"><font size="2">
<p align="left"><font face="courier new,monospace">CFLAGS = -g -D__KERNEL__ -DMODULE -I/usr/xenomai_arm-2.3.1uClibc/include</font></p>
<p align="left"><font face="courier new,monospace">LDFLAGS = -D__KERNEL__ -DMODULE</font></p>
<p align="left"><font face="courier new,monospace"></font></p>
<p align="left"><font face="courier new,monospace">test:test_leds.o</font></p>
<p align="left"><font face="courier new,monospace">ld -r -o test.ko -L/usr/xenomai_arm-2.3.1uClibc/lib -lnative -lrtdm test_leds.o</font></p>
<p align="left"><font face="courier new,monospace">test_leds.o:test_leds.c</font></p>
<p align="left"><font face="courier new,monospace">arm-linux-gcc $(CFLAGS) -c test_leds.c</font></p>
<p align="left"><font face="Courier New"></font>&nbsp;</p></font></font>
<div><font face="arial,sans-serif">When I compile, I have a lot of errors whose the begin is : </font></div>
<div><font face="Arial"></font>&nbsp;</div>
<div><font size="2">
<p align="left">In file included from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/capability.h:45,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:46,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,</p>
<p align="left">from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,</p>
<p align="left">from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,</p>
<p align="left">from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,</p>
<p align="left">from test_leds.c:21:</p>
<p align="left">/usr/src/ELDK_arm/usr/../arm/usr/include/linux/spinlock.h:280: error: parse error before &#39;*&#39; token</p>
<p align="left">In file included from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/jiffies.h:4,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,</p>
<p align="left">from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,</p>
<p align="left">from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,</p>
<p align="left">from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,</p>
<p align="left">from test_leds.c:21:</p>
<p align="left">/usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h: In function &#39;do_div_llr&#39;:</p>
<p align="left">/usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h:25: error: parse error before &#39;__asmeq&#39;</p>
<p align="left">In file included from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,</p>
<p align="left">from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,</p>
<p align="left">from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,</p>
<p>from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,</p>
<p>&nbsp;</p>
<p><font face="arial,sans-serif">I think it&#39;s a problem of option in the Makefile but I don&#39;t see. </font><font face="Arial">It&#39;s the first time I do a module for Linux so ...</font></p></font></div></font></font>

<p><font face="arial,sans-serif">thanks</font></p></div>

------=_Part_32894_7753881.1182954447986--

