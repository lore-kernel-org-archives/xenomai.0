Message-ID: <e39c9190708130427o43ab7052g57d36e3771894a0d@domain.hid>
Date: Mon, 13 Aug 2007 13:27:51 +0200
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <e39c9190708130425j4aebe52aq2aa746fb7ed0f174@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_54295_7924162.1187004471090"
References: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>
	<46C01909.5020308@domain.hid>
	<e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
	<46C03422.10304@domain.hid>
	<e39c9190708130425j4aebe52aq2aa746fb7ed0f174@domain.hid>
Subject: Re: [Xenomai-core] RTDM 82527 Xenomai driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_54295_7924162.1187004471090
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/13/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> juanba romance wrote:
> > On 8/13/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> juanba romance wrote:
> >>> Hello, all,
> >>> I am currently developing a RTDM/xenomai driver for the CANbus chipset
>
> >> 82527
> >>> that i think it could have some interest
> >>> it has the next features:
> >> Thanks for moving our private thread here! See, now we know that
> >> Wolfgang is already working on 82527 support for RT-Socket-CAN -
> >> something I wasn't aware of as well.
> >>
> >>>    1. Specific management for the remote frames CANbus feasibility, it
> >>>    couple the real-time data bus flow with a user software feedback to
>
> >>>    handshake remote frames and update mailbox callback for the
> >> auto-replied
> >>>    messages
> >> Mind to elaborate what you precisely gain here compared to "open-coded"
>
> >> designs (loop closed over the application)? Can you quantify the
> >> improvements?
> >
> >
> > After review your current user interface i can not understand how a RF
> cycle
> > flows through the user application
> > holding as much as possible the latency at the receiver side. Maybe it's
> my
> > own misunderstanding.
> > The point is one node requests an information to another one issuing a
> RF,
> > the CAN specification says that the RF receptor will handshake the cycle
>
> > issuing the corresponding DF, and right here is when/where i am fuzzy.
> We
> > use this capability using real time as much as possible only relying on
> the
> > CANbus network load, i mean we perform the RF handshake using the RF
> > receptor mailbox auto-reply capability, feedbacking the user software
> only
> > when the DF handshake is decoded at the network, this event will trigger
> the
> > user actions i.e. the message data update with the new local variables
> > state. This feature is requested through  the configuration stage, this
> kind
> > of information is labeled as "quick.ack" responses , cause are not
> related
> > with software at all. The RF requester has the guarantee  that the
> > information is sampled with any jitter software coupled. The typical
> > approach found in other stacks is labelled as "slow.ack", it avoids to
> > response the RF-request up to reach any software area (kernel/user
> spaces)
> > that explicitly issue the data-frame as usual, this is how can-festival
> > currently works.
>
> The point is that quite a few CAN controllers do not support this
> hardware-based RF reply. And as Socket-CAN aims at a _generic_ API, not
> the n-th Intel or MSCAN or whatever CAN stack, we had to define the
> basic interface without such special support first.

But that doesn't mean we would be unable to extend the profile with
> optional or, when required, software-emulated accelerations like for RTR
> handling.
>
Fully agree. One of the reason to write the driver was to use it as our
current applications require it
IMHO this feature is powerful a lot, an could be really nice to allow some
kind of service attached to this feature
i.e.  we have measure less than 250usec to suck the full package from a
remote CANbus node .
(all the numbers are referenced to 1Mbit bus rate, and assuming full
packages it means ~100bits )

That's what we're interested in: How may such an extension
> look like to exploit the hardware to its limits where available,
> _without_ giving up CAN application portability?

In the cases where not be available at chipset level, i think that the
quick.ack could be implemented at kernel space using a private mailbox where
the driver itself could perform the data exchange.
Our proposal use the configuration stage to assign this reserved objects and
the standard input interface is used to update the  message data.
The transmission overhead on such kind of objects is really fast, it's a
good argument to be driver embedded. I think that the documentation and the
examples that i am producing/building right now should illustrate the
stuff.
I don't see too much different between two approaches from the user API
point of view. IHMO it should be a fully driver issue

>
> > Both operations are included in the proposal.
> >
> >>    2. Transparent use to push/suck data from the driver using a common
> >>>    data format
> >>>    3. Capability to push a bunch of CANbus messages in a single system
>
> >>>    call. The bunch is copied to a kernel domain ring buffer to
> guarantee
> >> low
> >>>    latencies at the user side. A specific kernel thread  sucks the
> ring
> >> pushing
> >>>    the user request into the chipset
> >> That was discussed before in the context of Socket-CAN. My feeling is
> >> that it /could/ be useful in case you have to issue longer streams of
> >> CAN frames at high rates, and specifically if your CAN hardware can
> >> handle these streams autonomously. Is the 82527 able to do so?
> >>
> >> In any case, this would complicate the existing stack and driver and
> >> would first require careful evaluation of the achievable improvement
> >> (lower latency, lower system load?).
> >
> > The i82527 has 15 mailboxes with fixed priority, the lowest one is
> hardwared
> > to the RX operation. So theoretically  you can pipeline up to 14 TX
> > messages. When the stuff is full, we are labeled it as
> a  "pileup"  because
> > the hardware handler has to wait up to get some free one, this operation
> is
> > performed in our case through the either the mailbox-alarm mechanism or
> the
> > ISR transmission side . I have mention the "low latency" term, cause i
> have
> > decoupled the loopback-tx feedback from the ISR to a kernel RT
> thread/task
> > so the ISR only cleans/stops the mailbox software/hardware resources.
> The
>
> So you already have task context here (+ the challenge to manage
> priorities). Did you measure the difference in latencies between kernel
> and user space on your platform?

The snapshots were taken from the first ISR instruction up to reach the last
one. I estimate 10~20usec from the 8259 hit up to reach the service, so the
100 usec are required to perform the ISR task including the RT message queue
management. Uhmm i need to measure/estimate the context switch up to get the
xeomai thread


> If your hardware is slow (ISA...)
> and/or the platform is fast, that doesn't make much difference anymore,
> thus you are already half way to use the standard API, maybe with some
> CAN library for the boring routine work.

Likely


> > user call is only blocked the time required to push the message bunch
> into
> > the transmission ring. The physical user transmission is performed in
> > open-loop if no error/alarm is sampled..
> >
> >
> >>>    4. Driver readout using a native RT message queue where the control
> >>>    and data flow is published
> >> And this way you make your driver unportable, e.g. to move it over the
> >> RTDM layer Wolfgang wrote for the -rt kernel. RTDM drivers are ought to
>
> >> use RTDM services (or Linux ones), not other skins. If a generally
> >> useful service is lacking, we need to think about adding it - to RTDM.
> >>
> > Fully deliberated. this is one the reason cause i labelled the stuff as
> > "xenomai-RTDM" instead of "RTDM". I assume that the native layer is
> > available to be used at all. My first intention is not to build
> something
> > fully compliance with the RTDM layer, this is a second step from my
> point of
> > view. I need ASAP the driver ready to be used in a Xenomai
> framework  where
> > our applications are running..
>
> Yeah, the old problem: "But we need it immediately!" However, keep in
> mind: CAN controllers come and go (just as SoC come an go), the
> programming model should be there to stay. And using a standard API,
> maybe tuning it in the direction you need, raises the chances that
> future hardware vendors get "inspired" by that interface as well.

Yes fully agree, but to be honest, at our company we have already checked
different strategies to control the stuff and the experiment always outputs
the Murphy's law
I hope someday your sentence be a real fact, it will save lot of headaches

>
> >>    5. Multichipset capabilities, right now a commercial PC104 board
> with
> >>>    two devices is used. The on board CPU is a SBC VIA C3 1GHz
> processor
> >>>    softwared with the stack xenomai-2.3,1/vanilla-2.6.20-15/Adeos-
> >>>    ipipe-1.7-03
> >>>    6. board monitoring through the /proc file system entry
> >>>    7. Local Data Transfers controlled with RT-alarms
> >> Another violation - but this one is easily avoidable with RTDM timers
> >> that come with API revision 6 (upcoming Xenomai 2.4).
> >
> > Same as above
> >
> >
> >>    8. Virtual support to check applications/driver usage/design, right
> >>>    now only the chipset is virtualised, but plans to have network
> >> transactions
> >>>    are on going
> >>>    9. ISR hardware optimizations focused on the network readout to
> >>>    gurantee low latencies
> >> Any numbers?
> >
> > Right now i am on holidays and i can't not run any scope test, but i
> > remember that the worst case was around to 100usec to fully read the
> mailbox
> > plenty of 8 bytes. It is fully coupled to the hardware ISA mapping,
> every
> > chipset register read cycle requires three io operations to write the
> > addressed register, perform a dummy read  and the valid read one. This
> > killer takes 500nsec to each chipset select activation, but the most
> burner
> > is 1000nsec between each in,out IO address space instruction so around
> > 4usec/sucked byte,
> > We have implementing the chipset clearing and data sucking with ~ 20 io
> > cycles , so the numbers fit quite with the xenomai-i386 latencies.
>


So the programming model of the driver is actually not the core issue
> (taking aside true hardware acceleration where available).

Yes that's it. You got it


> >
> >>    10. Easy porting to other i82527 based on boards
> >>>    11. Full transmission operation handling the 16 message object set
> >>>
> >>> We have in plan also
> >>>
> >>>    1. Capabilities to filtering/masking the incoming flow at the
> driver
> >>>    stage allowing that the same context, using the "xenomai
> >> nomenclature" feed
> >>>    specific threads using some kind of binding/configuration process.
> >> This is
> >>>    an open issue cause i don't have a clear approach to follow..
> >>>    2. can-festival coupling
> >> Look, with Socket-CAN, you would now already have CAN-Festival binding.
> :)
> >
> > Yes, i know it's clear motivation to use it ;-)
> >
> >
> >> But maybe this library scenario can be used to explain why you need to
> >> do things in a special way and what you can gain that way. Looking
> >> forward!
> >
> > From my point of view the RTDM layout is ideal to perform linux porting
> > The fact related on with the missed chipset support and the gained
> > experience developing standard linux drivers using this chipset biased
> my
> > approach a lot. For sure, that if the chipset support were provided in
> time
> > we will re-consider the stuff to re-usage/patch the official stack if
> the
> > latencies are similar..
>
> You will definitely be welcome to contribute!

Uhmm i would like provide some specific numbers about latencies soon..


> Jan
>

------=_Part_54295_7924162.1187004471090
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span><span class="e" id="q_1145ef8e92c3e0d2_0">On 8/13/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
jan.kiszka@domain.hid</a>&gt; wrote:</span><div><div><span class="e" id="q_1145ef8e92c3e0d2_2"><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

juanba romance wrote:<br>&gt; On 8/13/07, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;&gt; juanba romance wrote:
<br>&gt;&gt;&gt; Hello, all,<br>&gt;&gt;&gt; I am currently developing a RTDM/xenomai driver for the CANbus chipset
<br>&gt;&gt; 82527<br>&gt;&gt;&gt; that i think it could have some interest<br>&gt;&gt;&gt; it has the next features:<br>&gt;&gt; Thanks for moving our private thread here! See, now we know that<br>&gt;&gt; Wolfgang is already working on 82527 support for RT-Socket-CAN -
<br>&gt;&gt; something I wasn&#39;t aware of as well.<br>&gt;&gt;<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Specific management for the remote frames CANbus feasibility, it<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;couple the real-time data bus flow with a user software feedback to
<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;handshake remote frames and update mailbox callback for the<br>&gt;&gt; auto-replied<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;messages<br>&gt;&gt; Mind to elaborate what you precisely gain here compared to &quot;open-coded&quot;
<br>&gt;&gt; designs (loop closed over the application)? Can you quantify the<br>&gt;&gt; improvements?<br>&gt;<br>&gt;<br>&gt; After review your current user interface i can not understand how a RF cycle<br>&gt; flows through the user application
<br>&gt; holding as much as possible the latency at the receiver side. Maybe it&#39;s my<br>&gt; own misunderstanding.<br>&gt; The point is one node requests an information to another one issuing a RF,<br>&gt; the CAN specification says that the RF receptor will handshake the cycle
<br>&gt; issuing the corresponding DF, and right here is when/where i am fuzzy. We<br>&gt; use this capability using real time as much as possible only relying on the<br>&gt; CANbus network load, i mean we perform the RF handshake using the RF
<br>&gt; receptor mailbox auto-reply capability, feedbacking the user software only<br>&gt; when the DF handshake is decoded at the network, this event will trigger the<br>&gt; user actions i.e. the message data update with the new local variables
<br>&gt; state. This feature is requested through&nbsp;&nbsp;the configuration stage, this kind<br>&gt; of information is labeled as &quot;quick.ack&quot; responses , cause are not related<br>&gt; with software at all. The RF requester has the guarantee&nbsp;&nbsp;that the
<br>&gt; information is sampled with any jitter software coupled. The typical<br>&gt; approach found in other stacks is labelled as &quot;slow.ack&quot;, it avoids to<br>&gt; response the RF-request up to reach any software area (kernel/user spaces)
<br>&gt; that explicitly issue the data-frame as usual, this is how can-festival<br>&gt; currently works.<br><br>The point is that quite a few CAN controllers do not support this<br>hardware-based RF reply. And as Socket-CAN aims at a _generic_ API, not
<br>the n-th Intel or MSCAN or whatever CAN stack, we had to define the<br>basic interface without such special support first.</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

But that doesn&#39;t mean we would be unable to extend the profile with<br>optional or, when required, software-emulated accelerations like for RTR<br>handling.<br></blockquote></span></div><div>Fully agree. One of the reason to write the driver was to use it as our current applications require it
<br>IMHO this feature is powerful a lot, an could be really nice to allow some kind of service attached to this feature<br>i.e.&nbsp; we have measure less than 250usec to suck the full package from a remote CANbus node .<br>(all the numbers are referenced to 1Mbit bus rate, and assuming full packages it means ~100bits )
<br></div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">That&#39;s what we&#39;re interested in: How may such an extension
<br>look like to exploit the hardware to its limits where available,
<br>_without_ giving up CAN application portability?</blockquote></span><div>In the cases where not be available at chipset level, i think that the quick.ack could be implemented at kernel space using a private mailbox where the driver itself could perform the data exchange.
<br>Our proposal use the configuration stage to assign this reserved objects and the standard input interface is used to update the&nbsp; message data.<br>The transmission overhead on such kind of objects is really fast, it&#39;s a good argument to be driver embedded. I think that the documentation and the examples that i am producing/building right now should illustrate the stuff.&nbsp;
<br>I don&#39;t see too much different between two approaches from the user API point of view. IHMO it should be a fully driver issue<br><br></div><div><span class="e" id="q_1145ef8e92c3e0d2_6"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

&gt;<br>&gt; Both operations are included in the proposal.<br>&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;2. Transparent use to push/suck data from the driver using a common<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;data format<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;3. Capability to push a bunch of CANbus messages in a single system
<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;call. The bunch is copied to a kernel domain ring buffer to guarantee<br>&gt;&gt; low<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;latencies at the user side. A specific kernel thread&nbsp;&nbsp;sucks the ring<br>&gt;&gt; pushing<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;the user request into the chipset
<br>&gt;&gt; That was discussed before in the context of Socket-CAN. My feeling is<br>&gt;&gt; that it /could/ be useful in case you have to issue longer streams of<br>&gt;&gt; CAN frames at high rates, and specifically if your CAN hardware can
<br>&gt;&gt; handle these streams autonomously. Is the 82527 able to do so?<br>&gt;&gt;<br>&gt;&gt; In any case, this would complicate the existing stack and driver and<br>&gt;&gt; would first require careful evaluation of the achievable improvement
<br>&gt;&gt; (lower latency, lower system load?).<br>&gt;<br>&gt; The i82527 has 15 mailboxes with fixed priority, the lowest one is hardwared<br>&gt; to the RX operation. So theoretically&nbsp;&nbsp;you can pipeline up to 14 TX<br>

&gt; messages. When the stuff is full, we are labeled it as a&nbsp;&nbsp;&quot;pileup&quot;&nbsp;&nbsp;because<br>&gt; the hardware handler has to wait up to get some free one, this operation is<br>&gt; performed in our case through the either the mailbox-alarm mechanism or the
<br>&gt; ISR transmission side . I have mention the &quot;low latency&quot; term, cause i have<br>&gt; decoupled the loopback-tx feedback from the ISR to a kernel RT thread/task<br>&gt; so the ISR only cleans/stops the mailbox software/hardware resources. The
<br><br>So you already have task context here (+ the challenge to manage<br>priorities). Did you measure the difference in latencies between kernel<br>and user space on your platform? </blockquote></span></div><div>The snapshots were taken from the first ISR instruction up to reach the last one. I estimate 10~20usec from the 8259 hit up to reach the service, so the 100 usec are required to perform the ISR task including the RT message queue management. Uhmm i need to measure/estimate the context switch up to get the xeomai thread 
<br>&nbsp;</div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">If your hardware is slow (ISA...)<br>and/or the platform is fast, that doesn&#39;t make much difference anymore,
<br>thus you are already half way to use the standard API, maybe with some<br>CAN library for the boring routine work.</blockquote></span><div>Likely<br>&nbsp;</div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

&gt; user call is only blocked the time required to push the message bunch into<br>&gt; the transmission ring. The physical user transmission is performed in<br>&gt; open-loop if no error/alarm is sampled..<br>&gt;<br>&gt;
<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;4. Driver readout using a native RT message queue where the control<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;and data flow is published<br>&gt;&gt; And this way you make your driver unportable, e.g. to move it over the<br>
&gt;&gt; RTDM layer Wolfgang wrote for the -rt kernel. RTDM drivers are ought to
<br>&gt;&gt; use RTDM services (or Linux ones), not other skins. If a generally<br>&gt;&gt; useful service is lacking, we need to think about adding it - to RTDM.<br>&gt;&gt;<br>&gt; Fully deliberated. this is one the reason cause i labelled the stuff as
<br>&gt; &quot;xenomai-RTDM&quot; instead of &quot;RTDM&quot;. I assume that the native layer is<br>&gt; available to be used at all. My first intention is not to build something<br>&gt; fully compliance with the RTDM layer, this is a second step from my point of
<br>&gt; view. I need ASAP the driver ready to be used in a Xenomai framework&nbsp;&nbsp;where<br>&gt; our applications are running..<br><br>Yeah, the old problem: &quot;But we need it immediately!&quot; However, keep in<br>mind: CAN controllers come and go (just as SoC come an go), the
<br>programming model should be there to stay. And using a standard API,<br>maybe tuning it in the direction you need, raises the chances that<br>future hardware vendors get &quot;inspired&quot; by that interface as well.
</blockquote></span><div>Yes fully agree, but to be honest, at our company we have already checked different strategies to control the stuff and the experiment always outputs the Murphy&#39;s law<br>I hope someday your sentence be a real fact, it will save lot of headaches
<br></div><div><span class="e" id="q_1145ef8e92c3e0d2_12"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;5. Multichipset capabilities, right now a commercial PC104 board with
<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;two devices is used. The on board CPU is a SBC VIA C3 1GHz processor<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;softwared with the stack xenomai-2.3,1/vanilla-2.6.20-15/Adeos-<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;ipipe-1.7-03<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;6. board monitoring through the /proc file system entry
<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;7. Local Data Transfers controlled with RT-alarms<br>&gt;&gt; Another violation - but this one is easily avoidable with RTDM timers<br>&gt;&gt; that come with API revision 6 (upcoming Xenomai 2.4).<br>

&gt;<br>&gt; Same as above<br>&gt;<br>&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;8. Virtual support to check applications/driver usage/design, right<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;now only the chipset is virtualised, but plans to have network<br>&gt;&gt; transactions
<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;are on going<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;9. ISR hardware optimizations focused on the network readout to<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;gurantee low latencies<br>&gt;&gt; Any numbers?<br>&gt;<br>&gt; Right now i am on holidays and i can&#39;t not run any scope test, but i
<br>&gt; remember that the worst case was around to 100usec to fully read the mailbox<br>&gt; plenty of 8 bytes. It is fully coupled to the hardware ISA mapping, every<br>&gt; chipset register read cycle requires three io operations to write the
<br>&gt; addressed register, perform a dummy read&nbsp;&nbsp;and the valid read one. This<br>&gt; killer takes 500nsec to each chipset select activation, but the most burner<br>&gt; is 1000nsec between each in,out IO address space instruction so around
<br>&gt; 4usec/sucked byte,<br>&gt; We have implementing the chipset clearing and data sucking with ~ 20 io<br>&gt; cycles , so the numbers fit quite with the xenomai-i386 latencies.<br></blockquote><div><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">

&nbsp;</blockquote></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">So the programming model of the driver is actually not the core issue<br>

(taking aside true hardware acceleration where available).</blockquote></span></div><div>Yes that&#39;s it. You got it<br>&nbsp;</div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;10. Easy porting to other i82527 based on boards<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;11. Full transmission operation handling the 16 message object set<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; We have in plan also<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Capabilities to filtering/masking the incoming flow at the driver<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;stage allowing that the same context, using the &quot;xenomai<br>&gt;&gt; nomenclature&quot; feed<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;specific threads using some kind of binding/configuration process.
<br>&gt;&gt; This is<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;an open issue cause i don&#39;t have a clear approach to follow..<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;2. can-festival coupling<br>&gt;&gt; Look, with Socket-CAN, you would now already have CAN-Festival binding. :)
<br>&gt;<br>&gt; Yes, i know it&#39;s clear motivation to use it ;-)<br>&gt;<br>&gt;<br>&gt;&gt; But maybe this library scenario can be used to explain why you need to<br>&gt;&gt; do things in a special way and what you can gain that way. Looking
<br>&gt;&gt; forward!<br>&gt;<br>&gt; From my point of view the RTDM layout is ideal to perform linux porting<br>&gt; The fact related on with the missed chipset support and the gained<br>&gt; experience developing standard linux drivers using this chipset biased my
<br>&gt; approach a lot. For sure, that if the chipset support were provided in time<br>&gt; we will re-consider the stuff to re-usage/patch the official stack if the<br>&gt; latencies are similar..<br><br>You will definitely be welcome to contribute!
</blockquote></span><div>Uhmm i would like provide some specific numbers about latencies soon..<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Jan<br></blockquote></div><br>

------=_Part_54295_7924162.1187004471090--

