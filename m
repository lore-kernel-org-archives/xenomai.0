Message-ID: <e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
Date: Mon, 13 Aug 2007 11:54:51 +0200
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <46C01909.5020308@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_53123_27300548.1186998891861"
References: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>
	<46C01909.5020308@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_53123_27300548.1186998891861
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/13/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> juanba romance wrote:
> > Hello, all,
> > I am currently developing a RTDM/xenomai driver for the CANbus chipset
> 82527
> > that i think it could have some interest
> > it has the next features:
>
> Thanks for moving our private thread here! See, now we know that
> Wolfgang is already working on 82527 support for RT-Socket-CAN -
> something I wasn't aware of as well.
>
> >
> >    1. Specific management for the remote frames CANbus feasibility, it
> >    couple the real-time data bus flow with a user software feedback to
> >    handshake remote frames and update mailbox callback for the
> auto-replied
> >    messages
>
> Mind to elaborate what you precisely gain here compared to "open-coded"
> designs (loop closed over the application)? Can you quantify the
> improvements?


After review your current user interface i can not understand how a RF cycle
flows through the user application
holding as much as possible the latency at the receiver side. Maybe it's my
own misunderstanding.
The point is one node requests an information to another one issuing a RF,
the CAN specification says that the RF receptor will handshake the cycle
issuing the corresponding DF, and right here is when/where i am fuzzy. We
use this capability using real time as much as possible only relying on the
CANbus network load, i mean we perform the RF handshake using the RF
receptor mailbox auto-reply capability, feedbacking the user software only
when the DF handshake is decoded at the network, this event will trigger the
user actions i.e. the message data update with the new local variables
state. This feature is requested through  the configuration stage, this kind
of information is labeled as "quick.ack" responses , cause are not related
with software at all. The RF requester has the guarantee  that the
information is sampled with any jitter software coupled. The typical
approach found in other stacks is labelled as "slow.ack", it avoids to
response the RF-request up to reach any software area (kernel/user spaces)
that explicitly issue the data-frame as usual, this is how can-festival
currently works.

Both operations are included in the proposal.

>    2. Transparent use to push/suck data from the driver using a common
> >    data format
> >    3. Capability to push a bunch of CANbus messages in a single system
> >    call. The bunch is copied to a kernel domain ring buffer to guarantee
> low
> >    latencies at the user side. A specific kernel thread  sucks the ring
> pushing
> >    the user request into the chipset
>
> That was discussed before in the context of Socket-CAN. My feeling is
> that it /could/ be useful in case you have to issue longer streams of
> CAN frames at high rates, and specifically if your CAN hardware can
> handle these streams autonomously. Is the 82527 able to do so?
>
> In any case, this would complicate the existing stack and driver and
> would first require careful evaluation of the achievable improvement
> (lower latency, lower system load?).

The i82527 has 15 mailboxes with fixed priority, the lowest one is hardwared
to the RX operation. So theoretically  you can pipeline up to 14 TX
messages. When the stuff is full, we are labeled it as a  "pileup"  because
the hardware handler has to wait up to get some free one, this operation is
performed in our case through the either the mailbox-alarm mechanism or the
ISR transmission side . I have mention the "low latency" term, cause i have
decoupled the loopback-tx feedback from the ISR to a kernel RT thread/task
so the ISR only cleans/stops the mailbox software/hardware resources. The
user call is only blocked the time required to push the message bunch into
the transmission ring. The physical user transmission is performed in
open-loop if no error/alarm is sampled..


> >    4. Driver readout using a native RT message queue where the control
> >    and data flow is published
>
> And this way you make your driver unportable, e.g. to move it over the
> RTDM layer Wolfgang wrote for the -rt kernel. RTDM drivers are ought to
> use RTDM services (or Linux ones), not other skins. If a generally
> useful service is lacking, we need to think about adding it - to RTDM.
>
Fully deliberated. this is one the reason cause i labelled the stuff as
"xenomai-RTDM" instead of "RTDM". I assume that the native layer is
available to be used at all. My first intention is not to build something
fully compliance with the RTDM layer, this is a second step from my point of
view. I need ASAP the driver ready to be used in a Xenomai framework  where
our applications are running..

>    5. Multichipset capabilities, right now a commercial PC104 board with
> >    two devices is used. The on board CPU is a SBC VIA C3 1GHz processor
> >    softwared with the stack xenomai-2.3,1/vanilla-2.6.20-15/Adeos-
> >    ipipe-1.7-03
> >    6. board monitoring through the /proc file system entry
> >    7. Local Data Transfers controlled with RT-alarms
>
> Another violation - but this one is easily avoidable with RTDM timers
> that come with API revision 6 (upcoming Xenomai 2.4).

Same as above


>    8. Virtual support to check applications/driver usage/design, right
> >    now only the chipset is virtualised, but plans to have network
> transactions
> >    are on going
> >    9. ISR hardware optimizations focused on the network readout to
> >    gurantee low latencies
>
> Any numbers?

Right now i am on holidays and i can't not run any scope test, but i
remember that the worst case was around to 100usec to fully read the mailbox
plenty of 8 bytes. It is fully coupled to the hardware ISA mapping, every
chipset register read cycle requires three io operations to write the
addressed register, perform a dummy read  and the valid read one. This
killer takes 500nsec to each chipset select activation, but the most burner
is 1000nsec between each in,out IO address space instruction so around
4usec/sucked byte,
We have implementing the chipset clearing and data sucking with ~ 20 io
cycles , so the numbers fit quite with the xenomai-i386 latencies.

>    10. Easy porting to other i82527 based on boards
> >    11. Full transmission operation handling the 16 message object set
> >
> > We have in plan also
> >
> >    1. Capabilities to filtering/masking the incoming flow at the driver
> >    stage allowing that the same context, using the "xenomai
> nomenclature" feed
> >    specific threads using some kind of binding/configuration process.
> This is
> >    an open issue cause i don't have a clear approach to follow..
> >    2. can-festival coupling
>
> Look, with Socket-CAN, you would now already have CAN-Festival binding. :)

Yes, i know it's clear motivation to use it ;-)


> But maybe this library scenario can be used to explain why you need to
> do things in a special way and what you can gain that way. Looking
> forward!

>From my point of view the RTDM layout is ideal to perform linux porting
The fact related on with the missed chipset support and the gained
experience developing standard linux drivers using this chipset biased my
approach a lot. For sure, that if the chipset support were provided in time
we will re-consider the stuff to re-usage/patch the official stack if the
latencies are similar..

>
> > I think this is the full picture, i look forward..
> >
> > Best regards..
> >
> Jan
>

IHTH..
Best regards..

Juanba

------=_Part_53123_27300548.1186998891861
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/13/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
juanba romance wrote:<br>&gt; Hello, all,<br>&gt; I am currently developing a RTDM/xenomai driver for the CANbus chipset 82527<br>&gt; that i think it could have some interest<br>&gt; it has the next features:<br><br>Thanks for moving our private thread here! See, now we know that
<br>Wolfgang is already working on 82527 support for RT-Socket-CAN -<br>something I wasn&#39;t aware of as well.<br><br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Specific management for the remote frames CANbus feasibility, it<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;couple the real-time data bus flow with a user software feedback to
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;handshake remote frames and update mailbox callback for the auto-replied<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;messages<br><br>Mind to elaborate what you precisely gain here compared to &quot;open-coded&quot;<br>designs (loop closed over the application)? Can you quantify the
<br>improvements?</blockquote><div><br>After review your current user interface i can not understand how a RF cycle flows through the user application<br>holding as much as possible the latency at the receiver side. Maybe it&#39;s my own misunderstanding. 
<br>The point is one node requests an information to another one issuing a RF, the CAN specification says that the RF receptor will handshake the cycle issuing the corresponding DF, and right here is when/where i am fuzzy. We use this capability using real time as much as possible only relying on the CANbus network load, i mean we perform the RF handshake using the RF receptor mailbox auto-reply capability, feedbacking the user software only when the DF handshake is decoded at the network, this event will trigger the user actions 
i.e. the message data update with the new local variables state. This feature is requested through&nbsp; the configuration stage, this kind of information is labeled as &quot;quick.ack&quot; responses , cause are not related with software at all. The RF requester has the guarantee&nbsp; that the information is sampled with any jitter software coupled. The typical approach found in other stacks is labelled as &quot;
slow.ack&quot;, it avoids to response the RF-request up to reach any software area (kernel/user spaces) that explicitly issue the data-frame as usual, this is how can-festival currently works.<br><br>Both operations are included in the proposal.
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;2. Transparent use to push/suck data from the driver using a common<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;data format<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;3. Capability to push a bunch of CANbus messages in a single system<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;call. The bunch is copied to a kernel domain ring buffer to guarantee low<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;latencies at the user side. A specific kernel thread&nbsp;&nbsp;sucks the ring pushing
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;the user request into the chipset<br><br>That was discussed before in the context of Socket-CAN. My feeling is<br>that it /could/ be useful in case you have to issue longer streams of<br>CAN frames at high rates, and specifically if your CAN hardware can
<br>handle these streams autonomously. Is the 82527 able to do so?<br><br>In any case, this would complicate the existing stack and driver and<br>would first require careful evaluation of the achievable improvement<br>(lower latency, lower system load?).
</blockquote><div>The i82527 has 15 mailboxes with fixed priority, the lowest one is hardwared to the RX operation. So theoretically&nbsp; you can pipeline up to 14 TX messages. When the stuff is full, we are labeled it as a&nbsp; &quot;pileup&quot;&nbsp; because the hardware handler has to wait up to get some free one, this operation is performed in our case through the either the mailbox-alarm mechanism or the ISR transmission side . I have mention the &quot;low latency&quot; term, cause i have decoupled the loopback-tx feedback from the ISR to a kernel RT thread/task so the ISR only cleans/stops the mailbox software/hardware resources. The user call is only blocked the time required to push the message bunch into the transmission ring. The physical user transmission is performed in open-loop if no error/alarm is sampled..&nbsp; &nbsp;  
<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;4. Driver readout using a native RT message queue where the control<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;and data flow is published
<br><br>And this way you make your driver unportable, e.g. to move it over the<br>RTDM layer Wolfgang wrote for the -rt kernel. RTDM drivers are ought to<br>use RTDM services (or Linux ones), not other skins. If a generally
<br>useful service is lacking, we need to think about adding it - to RTDM.<br></blockquote><div>Fully deliberated. this is one the reason cause i labelled the stuff as &quot;xenomai-RTDM&quot; instead of &quot;RTDM&quot;. I assume that the native layer is available to be used at all. My first intention is not to build something fully compliance with the RTDM layer, this is a second step from my point of view. I need ASAP the driver ready to be used in a Xenomai framework&nbsp;  where our applications are running..
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;5. Multichipset capabilities, right now a commercial PC104 board with<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;two devices is used. The on board CPU is a SBC VIA C3 1GHz processor<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;softwared with the stack xenomai-2.3,1/vanilla-2.6.20-15/Adeos-<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;ipipe-1.7-03<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;6. board monitoring through the /proc file system entry
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;7. Local Data Transfers controlled with RT-alarms<br><br>Another violation - but this one is easily avoidable with RTDM timers<br>that come with API revision 6 (upcoming Xenomai 2.4).</blockquote><div>Same as above
<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;8. Virtual support to check applications/driver usage/design, right<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;now only the chipset is virtualised, but plans to have network transactions<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;are on going<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;9. ISR hardware optimizations focused on the network readout to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;gurantee low latencies<br><br>
Any numbers?</blockquote><div>Right now i am on holidays and i can&#39;t not run any scope test, but i remember that the worst case was around to 100usec to fully read the mailbox plenty of 8 bytes. It is fully coupled to the hardware ISA mapping, every chipset register read cycle requires three io operations to write the addressed register, perform a dummy read&nbsp; and the valid read one. This killer takes 500nsec to each chipset select activation, but the most burner is 1000nsec between each in,out IO address space instruction so around 4usec/sucked byte,&nbsp;&nbsp;  
<br>We have implementing the chipset clearing and data sucking with ~ 20 io cycles , so the numbers fit quite with the xenomai-i386 latencies.<br> </div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;&nbsp;&nbsp;&nbsp;&nbsp;10. Easy porting to other i82527 based on boards<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;11. Full transmission operation handling the 16 message object set<br>&gt;<br>&gt; We have in plan also<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Capabilities to filtering/masking the incoming flow at the driver
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;stage allowing that the same context, using the &quot;xenomai nomenclature&quot; feed<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;specific threads using some kind of binding/configuration process. This is<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;an open issue cause i don&#39;t have a clear approach to follow..
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;2. can-festival coupling<br><br>Look, with Socket-CAN, you would now already have CAN-Festival binding. :)</blockquote><div>Yes, i know it&#39;s clear motivation to use it ;-)<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
But maybe this library scenario can be used to explain why you need to<br>do things in a special way and what you can gain that way. Looking forward!</blockquote><div>From my point of view the RTDM layout is ideal to perform linux porting
<br>The fact related on with the missed chipset support and the gained experience developing standard linux drivers using this chipset biased my approach a lot. For sure, that if the chipset support were provided in time we will re-consider the stuff to re-usage/patch the official stack if the latencies are similar..
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt; I think this is the full picture, i look forward..<br>&gt;<br>&gt; Best regards..
<br>&gt;<br>Jan<br></blockquote></div><br>IHTH..<br>Best regards..<br><br>Juanba<br>

------=_Part_53123_27300548.1186998891861--

