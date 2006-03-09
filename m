Message-ID: <44106DA5.5070405@domain.hid>
Date: Thu, 09 Mar 2006 12:02:13 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
References: <006f01c64312$a28ab730$a10a10ac@domain.hid>
In-Reply-To: <006f01c64312$a28ab730$a10a10ac@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Thanks to everyone for taking the time to share your thoughts and answer my questions.  I have added some comments below.


Jan Kiszka wrote:
>>means, but it seems that the worst-case measurements are pretty
>>similar.  Xenomai *may* be slightly better from the limited data I have
>>taken.  Does anyone care to share their own observations?
> 
> Would surprises me. From what I know of RTLinux/GPL (RTAI is similar
> here, BTW), the critical paths are involving less code than Xenomai.
> That's due to the different IRQ redirection layers, the nucleus
> abstraction of Xenomai, maybe also to some yet missing optimisations.


Thanks for your explanation and comparison.  If you are interested in my little tests, I put the source files and some output plots here: 

  http://www.judyandjeff.com/tech/xenotest

I ran the first test program (jitter2.c) under heavy disk activity and while playing the opengl tuxracer program.  You can see the results for RTLinux (rtlinuxfree1.png), xenomai-kernel (xenomai_kernel1.png), and xenomain-user (xenomai_user1.png) in the plots directory.  As you can see, the typical jitter of RTLinux task is quite a bit less, but the overall latency is higher, due to a fixed offset.  Perhaps this offset could be taken out by tweaking some RTLinux configuration.  I believe those big spikes (which occur in all three versions) are a result of switching video modes with those nasty proprietary NVIDIA drivers.  These spikes occur with the xenomai latency program as well.

I ran the second test program (irqtest.c) under the same conditions mentioned above, with a one-pulse-per-second interrupt source.  I would like to test with a higher-frequency interrupt, but that's all I have handy to apply externally at the moment.  The results can be seen in some o-scope captures (rtl_krn.png, xeno_krn.png, xeno_usr.png).  We don't see the big spikes here (likely due to the low interrupt frequency), but you can see the jitter.  The minimum interrupt latency seems pretty much the same for xenomai and rtlinux.  The average jitter seems less for RTLinux, but the worst case (for this run, anyway) is a little worse for RTLinux.


> Anyway, Xenomai is favouring flexibility and maintainability here over
> the last microsecond.


I agree with xenomai's approach.  The elegance of the design is worth a few clock cycles.  I just want to know the two systems are in the same ballpark.


>>The worst-case scheduling latency for the xenomai user-space application
>>was only a few microseconds worse than the kernel-space version.  Is
>>this what you would expect?
> 
> 
> Well, I guess it takes more information about your tests to comment on
> this. The hardware of the test system would be important, as well as the
> load scenario and the test duration.

I'm not really looking for hard numbers here, but more of a general answer.  Can you say in general, if there is any circumstance in which the user-space interrupt handler would perform much worse (percentage-wise) than a kernel-based handler?  Say an order of magnitude, factor of two, or something like that.  Can linux kernel interrupt handlers delay the handling of a real-time interrupt in user-space?

FYI, I'm running an AthlonXP system with that evil NVIDIA graphics card, along with a couple of synchronous serial cards and a counter/io board.  On board ethernet, etc.  Lots of devices on the PCI bus.  The real-time IRQ is shared with linux because of the way the PCI interrupts are assigned (and we have so many devices on the bus).
 

>>We currently use C and FORTRAN in our RTLinuxFree modules, and would
>>like to be able to add C++ and FORTRAN as well.  Are there any problems
>>you see with using these languages in xenomai user-space real-time
>>programs?
> 
> Based on the design of the userspace skins, there are no problems to
> expect. If minor compilation issues still pop up (I'm not aware of any),
> they will be easy to fix. There is even an ongoing effort to create a
> native skin class library for Xenomai: xeno-- (see xenomm at gna.org).


Very good.  That's what I concluded from reading the documentation, but it's nice to have that confirmed by someone with a good knowledge of the system.


> [Christopher Stone] I definitely plan to add AMD x86_64 support for my XLM
> project. I have a dual core AMD X2 chip I want to test XLM on. I don't have
> specific dates when it will be available yet.


It looks like several folks who have the expertise to contribute are interested.  That sounds very promising to me!


> [Christopher Stone] I think the fact that RTLinuxPro is maintained by a
> small company, with extremely limited resources...


Thanks for the arguments in favor of free software.  The support, stability, and longevity areas are where I am likely to face the most resistance.


> [Christopher Stone] I guarantee you that the rates that FSMlabs charges for support
> and consultancy are much higher than the rates you can get for Xenomai support
> and consultancy from any of a growing number of companies. 


No doubt.  I was just looking over the quotes they sent me...


> Vendor specific API's are like drugs, once you get hooked on them, it is
> difficult to incur the cost of kicking the habit. With Xenomai you can use
> any of a number of skins, but, would be wise to consider the POSIX skin. By
> using the industry standard POSIX API your code remains portable and more
> future proof. 


I am debating whether to use the native API or POSIX skins.  I have been using POSIX-type calls with RTLinux, but I really do prefer the simplicity and readability of the native API.  Some of the POSIX stuff seems a bit awkward and convoluted to me, but I suppose it is a standard.  Of course, the *_np calls aren't...  Does anyone else have an opinion on using native vs. POSIX?

Since my mind is on POSIX...  Is there a way to set up an RT_PIPE such that I could use fprintf from a real-time thread, or maybe even redirect the standard output so I could use printf from real-time?  This would greatly ease the porting of non-rt code to xenomai.  Maybe this idea is impossible or I'm very naive in my thinking.

> [Christopher Stone] Xenomai uses a different process that was specifically
> designed to circumvent the FSMlabs patent. I think that RTAI and Xenomai are
> prime examples of how robust and "future proof" the free software community
> is. RTAI was stung badly by the FSMlabs patent. However, instead of running
> away, the community responded by developing a new process, and the community
> is as strong as it ever was.

Good to hear.  Thanks for clearing that up.

-Jeff


