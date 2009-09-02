From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0909021611170.22914@domain.hid>
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
	<Pine.LNX.4.64.0909021359060.22914@domain.hid>
	<4A9E5424.9070500@domain.hid>
	<Pine.LNX.4.64.0909021418300.22914@domain.hid>
	<4A9E5917.8060200@domain.hid>
	<Pine.LNX.4.64.0909021441160.22914@domain.hid>
	<1251895278.3205.190.camel@domain.hid>
	<Pine.LNX.4.64.0909021611170.22914@domain.hid>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 16:40:26 +0200
Message-Id: <1251902426.3205.202.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deprecated kernel system calls in xenomai-head
 and new application development paradigm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, 2009-09-02 at 17:34 +0300, Rus V. Brushkoff wrote:
> On Wed, 2 Sep 2009, Philippe Gerum wrote:
> 
> :>  Next - I do not 
> :> understand why the previous model lets the _developer_ itself decide 
> :> which of the application tasks will be running in kernel and which will 
> :> be running in user space. The current model left the people without any 
> :> choice. So the current model itself decided instead of developer what is 
> :> better - I think this is wrong.
> :
> :With that kind of reasoning, you would keep on coding your RT
> :application fully in kernel space, but we made some progress since 1997,
> :fortunately.
> 
>  Sorry, but device drivers for hardware that need RT processing can't be 
> written in user space.

Please, would you mind re-reading my various answers again, and properly
interpret "application" and "driver" for what they really mean?

>  Dealing with interrupts, PCI, DMA, I/O ports can 
> be done only in kernel space. So it is not possible to decide at the 
> Xenomai architect level wich driver task are optimal to run in which mode 
> - it will depends from the particular development problem area.
>  So I think that forcing people to write the RT tasks only in user space 
> will make unneded latencies, which will be inserted by data passing 
> between user and kernel domains.
>  Next: the traditional and clean Unix programming concept suppose that 
> user space applications are simple and operate on the files/pipes that 
> are attached to kernel drivers. It will be better to leave this concept 
> live as it proved its architect efficiency.
> 
> :The point of Xenomai has always been about keeping the RT programming
> :model as close as possible to the one we would use to code common
> :applications not depending on any dual kernel support. Now we want to
> :break the last wall, which means enforcing a cleaner and safer
> :application / device driver split model. This will allow people to pick
> :the best option between dual kernel and PREEMPT_RT configurations,
> :depending on their requirements.
> 
>  No problem about breaking the wall - but you are breaking the existing 
> applications. So you will restrict the developers freedom. I see this as 
> the same that if, for example, Linux kernel developers will decide once 
> time to disable at all kernel modules development - all people will be 
> forced to write drivers in userspace, motivied for example - that "you 
> will never write the good driver or driver without bugs, and the kernel 
> will crash, and you will expect problems, but from that time - you are 
> free from this beacause module development is prohibited."
> 
> :To sum up, the point is not about losing any freedom to develop kernel
> :code at all, it is about being discouraged from perpetuating legacy
> :_application_ designs (not driver) that were only there to mitigate
> :restrictions  on legacy dual kernel systems which did not provide any
> :userland interface to applications.
> 
>  The freedom means posibility to develop selecting model as it is needed 
> by the current task conditions. It is good if some new paradigm exists - 
> people will select themselves what they will use. If the people can't 
> select the Xenomai development model - this is called enforcement, but 
> not the freedom.
> 
> :Said differently, implementing a complete application (RT or not) in
> :kernel space has always been sub-optimal with respect to the common
> :programming model. It just happened to be the only possible way to work
> :in the stone age of real-time Linux, when one had to trade separate
> :address spaces and tool availability off against better latencies. This
> :is no more required, and since we do have a sane and normalized
> :real-time driver model with RTDM, and the incentive to enforce a correct
> :application / driver split, the time has come to evolve.
> 
>  It is clear that developing all in kernel space is bad, but from other 
> side developing all in user space is bad too. Because you can't say now 
> where this margin will be - it fully depends from the particular task 
> requrements. It is very strange that it is not clear - how many kind of 
> RT programming tasks can exist in future.
> 
> :Even if Xenomai-wise, that evolution will only start with Xenomai v3,
> :application designers may want to integrate this fact as early as
> :possible, or disable CONFIG_XENO_OPT_NOWARN_DEPRECATED and stick with
> :v2.5.
> 
>  Better I will patch Xenomai with needed backport feature than will do 
> a plenty amount of unneded job in future.
> 
> :
> 
> 		Rus
-- 
Philippe.



