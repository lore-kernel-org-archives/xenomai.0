Message-ID: <440FE276.2080609@domain.hid>
Date: Thu, 09 Mar 2006 10:08:22 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
References: <440F5F23.7000703@domain.hid> <440F7B35.1050107@domain.hid>
In-Reply-To: <440F7B35.1050107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka kirjoitti:
> Jeff Webb wrote:
> 
>>Xenomai developers and users,
>>
>>Our company is looking at the possibility of porting our
>>hardware-in-the-loop (HWIL) simulations from RTLinuxFree to a new
>>real-time operating system.  We are currently considering Xenomai and
>>RTLinuxPro as possible options.  I am personally biased towards free
>>software, but our customers do not necessarily share this bias.  I am
>>attempting to put together a presentation comparing the advantages and
>>disadvantages of the two systems  as they would be used in our HWIL
>>simulations.  Any comments you have would be appreciated.
>>
>>We are currently using RTLinuxFree-3.2-pre3 running on Fedora Core 1
>>(2.4.22 linux kernel) for our in-house HWIL simulations on rack-mounted
>>x86 PC hardware.  We have been satisfied with the functionality of
>>RTLinuxFree over the past few years, although we have been disappointed
>>by the lack of maintenance and development that has occurred since the
>>primary developers focused their efforts on developing RTLinuxPro. 
>>Because there is no RTLinuxFree release that supports the 2.6 kernel,
> 
> 
> Well, I'm not following this in every details, but there is something
> now for RTLinux/GPL (the independent community RTLinux). Anyway, the
> maintenance situation is not significantly better there - too few users,
> too few developers.

I did some investigation of these things last year and at least then 
only thing available
for linux 2.6 was a patch from fsmlabs, which (1) didn't work, (2) 
nobody maintained,
(3) nobody cared about, (4) was x86 only. The word from rtlinux/gpl folk 
was that they're probably going to use some more generic virtualizer- 
type-of-thing for 2.6 support instead of porting the existing rtlinux 
2.4 stuff over.


>>I wrote some simple test programs to compare the scheduling jitter and
>>interrupt latency for RTLinuxFree, Xenomai-kernel-space, and
>>Xenomai-user-space applications.  My tests are not rigorous by any
>>means, but it seems that the worst-case measurements are pretty
>>similar.  Xenomai *may* be slightly better from the limited data I have
>>taken.  Does anyone care to share their own observations?
> 
> 
> Would surprises me. From what I know of RTLinux/GPL (RTAI is similar
> here, BTW), the critical paths are involving less code than Xenomai.
> That's due to the different IRQ redirection layers, the nucleus
> abstraction of Xenomai, maybe also to some yet missing optimisations.
> Anyway, Xenomai is favouring flexibility and maintainability here over
> the last microsecond.

But if the target platform is something beginning with x86_64, few 
instructions here and there probably won't matter..

-- Heikki Lindholm

