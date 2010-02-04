From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
References: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Feb 2010 17:14:57 +0100
Message-ID: <1265300097.2348.158.camel@domain.hid>
Mime-Version: 1.0
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

On Thu, 2010-02-04 at 21:21 +0530, Saravanan S wrote:
> Hi,
> 
>     I tried to implement the hardware interrupt handling feature of
> xenomai in user space.I read the native-api document and ran the
> user_irq.c program with one change ,i tried to intercept the eth0
> interrupt on my system(using interrupt number from
> cat /proc/interrupts).When i ran the program the system froze!!!!!
> 
> What am i doing wrong??

The thing is that your tiny little change has some impact. You just
can't intercept a random interrupt without knowing how it interacts with
the Linux kernel, and expect this to work.

The Linux NIC driver won't get interrupts because of this, since
usr_irq.c does not care of propagating them to the standard kernel, so
your device is likely going to bury your box under an interrupt storm.

What is in snippets/ is not meant to be run blindly. Those are pieces of
code to illustrate the use of services in a general way, not examples
tailored to run on any platform, not even yours.

Read the "Life with Adeos" doc to understand why it can't work the way
you did it.

> 
> What  is the purpose of this feature of allowing user space handling
> of interrupts.Can a user space driver be written using this???
> 

Sure. When done properly.

> Thanks in advance.
> 
> With regards,
> 
> S Saravanan
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



