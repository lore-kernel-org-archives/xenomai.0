From: "Terry Fryar" <terry.fryar@domain.hid>
References: <28CCC3D1EEE841E184D8E5663EBDCCBE@TerryHP>
	<4F171C09.8010908@domain.hid>
In-Reply-To: <4F171C09.8010908@domain.hid>
Date: Wed, 18 Jan 2012 15:44:55 -0600
Message-ID: <E80344556EFF403586E4B8CAE727382F@TerryHP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compile error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I knew I wouldn't get enough...but I have other projects in between those
timing requirements and I wanted to see how little latency I could get.
Using an RTDM driver we wrote, I am measuring about 2us (not 20us) by
triggering an irq off a gpio and pulsing another gpio line and measuring the
difference between the irq edge and the pulsed edge using a logic analyzer.


I have a board that runs a suhdol linux sbc that is somehow handling gpio
interactions within nanosecond ranges, and I have no idea how that is being
done.  Even flipping a gpio pin with direct register access inside a KLM is
around 62ns.  I just don't know how they are managing to detect a gpio pin
state change and respond to several things all within a couple hundred ns??

I've looked at their app files and it's just a gpio driver and what appears
to be a single userspace app.  A mystery I guess.....



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Wednesday, January 18, 2012 1:23 PM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Compile error

On 01/18/2012 04:12 PM, Terry Fryar wrote:
> Using xenomai 2.6.0 with 2.6.38 kernel.  Turned off 
> CONFIG_XENO_OPT_PERVASIVE, and now I can't compile kernel:
>  
> CC      kernel/xenomai/nucleus/synch.o
> kernel/xenomai/nucleus/synch.c: In function 'xnsynch_release_thread':
> kernel/xenomai/nucleus/synch.c:688:3: error: implicit declaration of 
> function 'xnthread_get_rescnt'
> kernel/xenomai/nucleus/synch.c:689:4: error: implicit declaration of 
> function 'xnshadow_send_sig'
> 
> There are some ifdef's for this flag....how to compile xenomai kernel 
> without pervasive user support?  Only using kernel modules with 
> xenomai at this point, and I'm trying to optimize the kernel
performance....

I am afraid nobody has tried compiling without pervasive support for a long
time. Anyway, you will not gain enough that way: you will not reduce the
interrupt latency from 20us to 500ns. As I said, you can not have a 500ns
latency on any processor where xenomai is available.

-- 
                                                                Gilles.


