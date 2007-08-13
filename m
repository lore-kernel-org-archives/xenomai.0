Message-ID: <e39c9190708130508u76c2a131rb5a661e1e034d35e@domain.hid>
Date: Mon, 13 Aug 2007 14:08:36 +0200
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <46C03F62.30009@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_54735_4468676.1187006916369"
References: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>
	<46C01909.5020308@domain.hid>
	<e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
	<46C03F62.30009@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_54735_4468676.1187006916369
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/13/07, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> juanba romance wrote:
> [...]
> > After review your current user interface i can not understand how a RF
> > cycle flows through the user application
> > holding as much as possible the latency at the receiver side. Maybe it's
> > my own misunderstanding.
>
> Your just send a "remote transmission request" message and receive the
> response as a normal message.

I was pointing to the receiver node software. The requester node flow seems
quite standard/clear.


> > The point is one node requests an information to another one issuing a
> > RF, the CAN specification says that the RF receptor will handshake the
> > cycle issuing the corresponding DF, and right here is when/where i am
> > fuzzy. We use this capability using real time as much as possible only
> > relying on the CANbus network load, i mean we perform the RF handshake
> > using the RF receptor mailbox auto-reply capability, feedbacking the
> > user software only when the DF handshake is decoded at the network, this
> > event will trigger the user actions i.e. the message data update with
> > the new local variables state. This feature is requested through  the
> > configuration stage, this kind of information is labeled as "quick.ack"
> > responses , cause are not related with software at all. The RF requester
> > has the guarantee  that the information is sampled with any jitter
> > software coupled. The typical approach found in other stacks is labelled
> > as " slow.ack", it avoids to response the RF-request up to reach any
> > software area (kernel/user spaces) that explicitly issue the data-frame
> > as usual, this is how can-festival currently works.
>
> Can you point me to the code in CAN-Festival supporting directly that
> feature of the i82527?

It doesn't.  All the incoming RTR flow must be handshaked by the user space,
i.e. take a look on lifegrd.c at the src directory entry and review the
first filter based on the .rtr message struct field located on the symbol
proceedNODE_GUARD(CO_Data* d, Message* m ), the symbol context drive me to
think in a "soft" ack..
But the point is:
should one remove this powerful issue from the design/implementation cause
one specific user library doesn't provide the feature ?
>From my point of view this restriction is too much.
The consider the can-festival stuff is a facility to attach the CANopen
specification nothing else, we already have applications that smoothly run
using the raw CAN bus 2.0 specification. May be other CANopen stack be
available sometime, maybe we write our own, maybe we remove the CANopen
layer, i mean, nobody knows..
In fact in a first approach, we plan that the can-festival related driver
layer not use the high speed ACK. We will measure the latencies using the
layer as it is and then will take a final decision..

RTR message handling of the i82527 is very special and I do not know any
> other (non-compatible) CAN controller doing it in a similar way. The
> feature you like so much makes it actually a nightmare to support the
> i82527 in a generic framework (like RT-Socket-CAN or Socket-CAN),
> especially receiving RTR messages by justs using send and receive.

Fully agree. We have thought a lot about this feature at our company before
start this stuff long, long, long time ago. But the stuff was solved and
fixed and it has been part of our functional specifications along this time,
we still would like to hold it..


> Anyhow, supporting the RTR auto-reply capability in (RT-)Socket-CAN is
> feasible and would be a "nice to have". It could be supported by a
> generic RTR update object. Would be nice, if you bring-up the idea on
> the Socket-CAN mailing list to share it between other CAN experts with
> the goal to define an CAN-API extension.
>
Fully agree. I think that the driver documentation will help a lot, uhmm let
me do some pictures and write some formal document about and you will have
a  a better point of view..


> Wolfgang.
>

------=_Part_54735_4468676.1187006916369
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/13/07, <b class="gmail_sendername">Wolfgang Grandegger</b> &lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
juanba romance wrote:<br>[...]<br>&gt; After review your current user interface i can not understand how a RF<br>&gt; cycle flows through the user application<br>&gt; holding as much as possible the latency at the receiver side. Maybe it&#39;s
<br>&gt; my own misunderstanding.<br><br>Your just send a &quot;remote transmission request&quot; message and receive the<br>response as a normal message.</blockquote><div>I was pointing to the receiver node software. The requester node flow seems quite standard/clear.
<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; The point is one node requests an information to another one issuing a<br>&gt; RF, the CAN specification says that the RF receptor will handshake the
<br>&gt; cycle issuing the corresponding DF, and right here is when/where i am<br>&gt; fuzzy. We use this capability using real time as much as possible only<br>&gt; relying on the CANbus network load, i mean we perform the RF handshake
<br>&gt; using the RF receptor mailbox auto-reply capability, feedbacking the<br>&gt; user software only when the DF handshake is decoded at the network, this<br>&gt; event will trigger the user actions i.e. the message data update with
<br>&gt; the new local variables state. This feature is requested through&nbsp;&nbsp;the<br>&gt; configuration stage, this kind of information is labeled as &quot;quick.ack&quot;<br>&gt; responses , cause are not related with software at all. The RF requester
<br>&gt; has the guarantee&nbsp;&nbsp;that the information is sampled with any jitter<br>&gt; software coupled. The typical approach found in other stacks is labelled<br>&gt; as &quot; slow.ack&quot;, it avoids to response the RF-request up to reach any
<br>&gt; software area (kernel/user spaces) that explicitly issue the data-frame<br>&gt; as usual, this is how can-festival currently works.<br><br>Can you point me to the code in CAN-Festival supporting directly that<br>
feature of the i82527?</blockquote><div>It doesn&#39;t.&nbsp; All the incoming RTR flow must be handshaked by the user space, i.e. take a look on lifegrd.c at the src directory entry and review the first filter based on the .rtr message struct field located on the symbol proceedNODE_GUARD(CO_Data* d, Message* m ), the symbol context drive me to  think in a &quot;soft&quot; ack..
<br>But the point is: <br>should one remove this powerful issue from the design/implementation cause one specific user library doesn&#39;t provide the feature ?<br>From my point of view this restriction is too much. <br>The consider the can-festival stuff is a facility to attach the CANopen specification nothing else, we already have applications that smoothly run using the raw CAN bus 
2.0 specification. May be other CANopen stack be available sometime, maybe we write our own, maybe we remove the CANopen layer, i mean, nobody knows..  <br>In fact in a first approach, we plan that the can-festival related driver layer not use the high speed ACK. We will measure the latencies using the layer as it is and then will take a final decision..
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">RTR message handling of the i82527 is very special and I do not know any<br>other (non-compatible) CAN controller doing it in a similar way. The
<br>feature you like so much makes it actually a nightmare to support the<br>i82527 in a generic framework (like RT-Socket-CAN or Socket-CAN),<br>especially receiving RTR messages by justs using send and receive.</blockquote>
<div>Fully agree. We have thought a lot about this feature at our company before start this stuff long, long, long time ago. But the stuff was solved and fixed and it has been part of our functional specifications along this time, we still would like to hold it..
<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Anyhow, supporting the RTR auto-reply capability in (RT-)Socket-CAN is<br>feasible and would be a &quot;nice to have&quot;. It could be supported by a
<br>generic RTR update object. Would be nice, if you bring-up the idea on<br>the Socket-CAN mailing list to share it between other CAN experts with<br>the goal to define an CAN-API extension.<br></blockquote><div>Fully agree. I think that the driver documentation will help a lot, uhmm let me do some pictures and write some formal document about and you will have a&nbsp; a better point of view.. 
<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Wolfgang.<br></blockquote></div><br>

------=_Part_54735_4468676.1187006916369--

