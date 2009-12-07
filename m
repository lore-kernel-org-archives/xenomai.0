From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B1D066C.1030702@domain.hid>
References: <4B1663B9.8030306@domain.hid>
	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>
	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>
	<4B167B4B.3010804@domain.hid> <4B167FC4.8080904@domain.hid>
	<4B1681DA.3090108@domain.hid> <4B1684D7.2080501@domain.hid>
	<4B1690EC.8030002@domain.hid> <4B16949B.2040806@domain.hid>
	<4B169CF7.2060108@domain.hid> <4B16D403.1070202@domain.hid>
	<4B16E417.3000400@domain.hid> <4B16E813.6050906@domain.hid>
	<36FCBE44-88E0-4AAA-9E83-1A9F9AB3F5D9@domain.hid>
	<4B17980A.3060503@domain.hid> <4B17B8E6.1060108@domain.hid>
	<4B17B9B1.3070606@domain.hid>
	<F41A4C16-8EF2-4B29-B79D-4549F0106D37@domain.hid>
	<4B17BF4E.7080509@domain.hid> <4B18201D.30003@domain.hid>
	<4B1830BD.7050804@domain.hid>
	<1260029489.2174.87.camel@domain.hid>
	<4B1CC76C.9030700@domain.hid>  <4B1D066C.1030702@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Dec 2009 15:07:11 +0100
Message-ID: <1260194831.2370.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wm@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, 2009-12-07 at 14:43 +0100, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >> On Thu, 2009-12-03 at 22:42 +0100, Gilles Chanteperdrix wrote:
> >>> Wolfgang Mauerer wrote:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> Wolfgang Mauerer wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 03.12.2009, at 14:14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org 
> >>>>>>  > wrote:
> >>>>>>
> >>>>>>> Wolfgang Mauerer wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Gilles Chanteperdrix wrote:
> >>>>>>>>> Wolfgang Mauerer wrote:
> >>>>>>>>>> So that means, in essence, that you would accept probabilistic
> >>>>>>>>>> algorithms in realtime context?
> >>>>>>>>> Ah, today's troll!
> >>>>>>>> though it seems that I have to replace Jan this time ;-)
> >>>>>>>>> As I think I explained, the use of a seqlock in real-time context  
> >>>>>>>>> when
> >>>>>>>>> the seqlock writer only happens in linux context is not  
> >>>>>>>>> probabilistic.
> >>>>>>>>> It will work every time the first pass.
> >>>>>>>> I still don't see why it should succeed every time: What about
> >>>>>>>> the case that the Linux kernel on CPU0 updates the data, while
> >>>>>>>> Xenomai accesses them on another CPU? This can lead to
> >>>>>>>> inconsistent data, and they must be reread on the Xenomai side.
> >>>>>>> Yeah, right. I was not thinking about SMP. But admit that in this  
> >>>>>>> case,
> >>>>>>> there will be only one retry, there is nothing pathological.
> >>>> that's right. Which makes it bounded again, so it's maybe
> >>>> the best way to go.
> >>>>>>>> I'm asking because if this case can not happen, then there's
> >>>>>>>> nothing left to to as I have the code already at hand.
> >>>>>>> You have reworked the nucleus timers handling to adapt to this new
> >>>>>>> real-time clock ?
> >>>>>> Nope. Sorry, I was a bit unclear: I'm just referring to the gtod  
> >>>>>> syscall that does the timer handling, Not any other adaptions.
> >>>>> Ok, but what good is the gtod syscall if you can not use it as a time
> >>>>> reference for other timing related services?
> >>>> it suffices for our project's current purposes ;-)
> >>>>
> >>>> But it's certainly not the full solution. Before, we
> >>>> should have a decision wrt. the design issues, but I
> >>>> won't be able to continue working on this before
> >>>> mid of next week to look at the changed required for timer
> >>>> handling and come up with code.
> >>> Ok. To summarize what we have said, here is how I see we could implement
> >>> the NTP synchronized clock fully, and portably:
> >>> 1- allocate at nucleus init time, an area in the global sem heap for
> >>> this clock house-keeping
> >>> 2- add an event to the I-pipe patch when vsyscall_update is called
> >>> 3- implement the nucleus callback for the I-pipe event which copies
> >>> relevant data with our own version of seqlock called with hardware irqs
> >>> off, to the area allocated in 1 if the current clock source is the tsc
> >>> 4- rework the nucleus clocks and timers handling to use these data
> >>> 5- pass the offset of the data allocated in 1 to user-space through the
> >>> xnsysinfo, or xnfeatinfo structures
> >>> 6- rework clock_gettime to use these data, using the user-space
> >>> counterpart of the seqlock used in 3
> >>>
> >>> The real hard work is 4, and note that something which I did not mention
> >>> yesterday, is that we not only have to change the real-time clock
> >>> implementation, we also have to change the monotonic clock
> >>> implementation, otherwise the two clocks will drift apart.
> >>>
> >>> I think making such a change now is unreasonable.
> >>>
> >>> So, solution 1, we can implement 5, passing a null offset to mean that
> >>> the support is unimplemented by the kernel and not even use it in
> >>> user-space. Keeping the work for later in the 2.5 life cycle.
> >>>
> >>> Solution 2, we keep this change for 3.0.
> >>>
> >>> Solution 3, we implement a way to read that clock without synchronizing
> >>> the nucleus with it (that is, everything but 4). One way to do this,
> >>> which I do not like, is to add a dummy clock id to the posix skin, for
> >>> instance CLOCK_LINUX_NTP_REALTIME, and implement the clock reading for
> >>> that clock id in clock_gettime. This clock id, when passed to any other
> >>> service, causes EINVAL to be returned, making it clear that this clock
> >>> can not be used for anything else. Note that if we do that, even if we
> >>> implement the full support later, we will have to keep that dummy clock
> >>> id forever.
> >>>
> >>> My preference goes to solution 1. Philippe, what do you think?
> >> Way too late for this kind of change; 2.5.0 will be out this month.
> >> Timer related issues are prone to introduce nasty subtle regressions.
> >> Let's plan this for 3.0. The earlier 2.5.0 will be out, the earlier 3.0
> >> will start.
> > 
> > No, this was not about turning the nucleus timer handling upside down
> > for 2.5.0, this was first of all about establishing the required kernel
> > to user space ABI for 2.5. Can we agree on the latter?
> 
> Ok. It is solution 1 then. In order to get things evolving more easily
> than my first solution, here is what is proposed.
> 
> We define a structure which will be shared between kernel and user,
> which contains all data exported by kernel to user, as well as flags
> indicating which member of the structure is available. The definition of
> the struct for 2.5.0 will be:
> 
> struct xnshared  {
> 	unsigned long long features;
> };
> 
> This struct will be allocated in the global sem heap, and features will
> be null for the time being.
> 
> Every time we need to share some data between kernel and user (including
> for the ntp support), we will add data to the structure, and use a
> "features" bit to mean that the data are available from kernel. It will
> work as long as we add data from release to release and never remove it.
> 
> So, for 2.5.0, the xnshared structure will be allocated, but the
> features member will be null. We will pass the offset of this structure
> in the global sem heap in the sysinfo structure.
> 

Go for this. Ack.

-- 
Philippe.



