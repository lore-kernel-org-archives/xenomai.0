Message-ID: <44118EDC.2010003@domain.hid>
Date: Fri, 10 Mar 2006 15:36:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
References: <440F5F23.7000703@domain.hid>
In-Reply-To: <440F5F23.7000703@domain.hid>
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

Jeff Webb wrote:
>

<snip>

> The worst-case scheduling latency for the xenomai user-space application 
> was only a few microseconds worse than the kernel-space version.  Is 
> this what you would expect?
> 

Usually, yes. The gap may increase on low-end systems though, especially for those 
exhibiting unfriendly cache behaviour for instance. But the worst-case latency is 
still predictable, albeit higher.

> I did not do a very thorough test with my interrupt handler, but the 
> results seemed similar to what I described above for the scheduler.  Is 
> there a big penalty in terms of worst-case latency for user-space 
> interrupt handlers that I may not have seen?  I'm just looking for any 
> major problems that I might encounter if we port our real-time 
> applications to user-space.
> 
> Is RTLinuxPro's PSDD (user-space) development environment similar to 
> xenomai's user-space real-time threads?  Any known 
> advantages/disadvantages to either system?

My knowledge of PSDD being limited to the contents of the press releases, which 
are the services PSDD provides to applications, roughly?

> 
> We currently use C and FORTRAN in our RTLinuxFree modules, and would 
> like to be able to add C++ and FORTRAN as well.  Are there any problems 
> you see with using these languages in xenomai user-space real-time 
> programs?

None, provided your runtime environment can invoke callouts written in C in order 
to start Xenomai system calls. Those syscalls use the very same channel to 
re-enter the kernel than normal Linux system calls.

> 
> Is there planned support for native AMD x86_64 support?  We have several 
> of these machines on our desktops and would like to upgrade our HWIL 
> machines as well.

Not planned, yet.

> 
> We are also concerned about "future-proofing" as someone else put it the 
> other day.  I hope that xenomai will not suffer the fate of RTLinuxFree 
> in a few years.  Of course, I understand there are no guarantees.  Do 
> you see any advantages to xenomai over RTLinuxPro in this respect?
> 

I would rephrase your question this way: "what would prevent Xenomai from becoming 
a proprietary technology?". Short answer: critical pieces of the Xenomai codebase 
bear various GPL copyrights from different people or organizations having very 
little or no common interests, aside of keeping Xenomai free, that is. Another 
form of the famous "divide and conquer" approach.

> Another issue is technical support and documentation.  The xenomai 
> documentation seems good enough to me, although it sounds like 
> RTLinuxPro is quite a bit more substantial.  It also looks like the 
> developers on this list are very responsive and helpful, but I don't 
> know how that compares to what we would get from FSMLabs.  Any input on 
> these topics?
> 
> It appears that xenomai is released under the LGPL and can be used with 
> proprietary applications.  Although our simulations are just for 
> internal use, and I would always advocate releasing free software, I was 
> wondering if xenomai is subject to the RTLinux patent, or if it uses a 
> different process.

My answer must be awfully biased, but:
http://www.linuxdevices.com/news/NS7320885236.html

> 
> My first impression of xenomai is very positive.  I like the clean API, 
> and the user-space real-time would make life *much* nicer for me.  I'm 
> glad there is a such nice piece of free software available for real-time 
> programming under GNU/Linux.  Thanks!
> 

You are definitely welcome.

> Thank you for taking the time to read these questions and comments.  Any 
> comments or testimonies regarding xenomai or RTLinuxPro would be 
> appreciated.
> 
> Thanks again,
> 
> Jeff Webb
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

