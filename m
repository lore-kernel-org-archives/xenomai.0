Message-ID: <4B6C65C3.3080403@domain.hid>
Date: Fri, 05 Feb 2010 19:38:59 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>	
	<4B6AF2D5.1000908@domain.hid>
	<1aa9845a1002050823s2b1efe26hb17987f09f93c94@domain.hid>
In-Reply-To: <1aa9845a1002050823s2b1efe26hb17987f09f93c94@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] User interrupt handling in Xenomai running into
 probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saravanan S <sarans1987@domain.hid>
Cc: xenomai@xenomai.org

Saravanan S schrieb:
> 
> 
> On Thu, Feb 4, 2010 at 9:46 PM, Stefan Kisdaroczi <kisda@domain.hid
> <mailto:kisda@domain.hid>> wrote:
> 
>     Hi,
> 
>     Am 04.02.2010 16:51, schrieb Saravanan S:
>     > Hi,
>     >
>     >     I tried to implement the hardware interrupt handling feature of
>     > xenomai in user space.I read the native-api document and ran the
>     > user_irq.c program with one change ,i tried to intercept the eth0
>     > interrupt on my system(using interrupt number from cat
>     > /proc/interrupts).When i ran the program the system froze!!!!!
> 
>     The rt_intr_* interface is disabled by default in the kernel
>     configuration, please check.
>     That would mean that rt_intr_wait returns immediately, now look at
>     this loop from user_irq.c:
>        for (;;) {
> 
>           /* Wait for the next interrupt on channel #7. */
>           err = rt_intr_wait(&intr_desc,TM_INFINITE);
> 
>           if (!err) {
>               /* Process interrupt. */
>           }
> 
> 
> Can you please indicate which variable in the kernel config controls
> that setting???

The variable name in the config file is: CONFIG_XENO_OPT_NATIVE_INTR

If you use 'make menuconfig' to configure the kernel,
from the main menu, go to:
 Real-time sub-system ---> Interfaces ---> Native API
 There is a option called 'Interrupts' at the end of the list

>     > What am i doing wrong??
>     >
>     > What  is the purpose of this feature of allowing user space
>     handling of
>     > interrupts.Can a user space driver be written using this???
> 
>     You should use the rtdm interface for drivers.
> 
> 
> I know very little in kernel programming so thought it would be easier
> to process interrrupts in user space.....

look here for starting points:
  https://mail.gna.org/public/xenomai-help/2009-05/msg00168.html


Stefan


