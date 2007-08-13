Message-ID: <e39c9190708130134w78c3529aw222b87584f8b1486@domain.hid>
Date: Mon, 13 Aug 2007 10:34:23 +0200
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <46BF9427.2040809@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_52190_29132257.1186994063052"
References: <e39c9190708121302t5a14d577k9ca2d14f616df4@domain.hid>
	<46BF6D82.9010208@domain.hid>
	<e39c9190708121456v16ff4ff2jf48771bb1d8129bf@domain.hid>
	<46BF9427.2040809@domain.hid>
Subject: [Xenomai-core] Fwd: i82527 CANbus RTDM driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: lwg@domain.hid
Cc: xenomai@xenomai.org

------=_Part_52190_29132257.1186994063052
Content-Type: multipart/alternative; 
	boundary="----=_Part_52191_33136819.1186994063052"

------=_Part_52191_33136819.1186994063052
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Wolfgang this is the previous mail thread maintained with Jan and i
hope it answer your question

---------- Forwarded message ----------
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Aug 13, 2007 1:13 AM
Subject: Re: i82527 CANbus RTDM driver
To: juanba romance <juanba.romance@domain.hid>

juanba romance wrote:
> On 8/12/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Hi Juanba,
>>
>> I won't go much into technical and design details in this reply, because
>> I'm hoping we can continue this discussion on some public list.
>> Xenomai-core e.g.?
>
> I think that right now the sources are not too useful in a first "public"
> post, may be better to announce in the list that i am developing the stuff
and
> wait if somebody else shows any interest would be better
>
>  Would you like to re-post? With or without code
> (there is likely some size limit, so pushing code to a webserver is
better)?
> Of course, yes..
>
> Some questions I'm going to ask then:
>> - Is your API compatible to any pre-existing one?
> I don't think so, the stuff use specific objects/interfaces of the
Xenomai-framework
> to exchange the control and data flow between the user and kernel address
> spaces.

I was referring to the API the user of the CAN driver sees, not its
internal design. On first sight, I don't see Xenomai specifics in the
interface.

> In fact the objects/system calls were selected having in mind the driver
> capabilities which also income from our previous designs/products around
the 82527
> chipset
>
> > Did you consider the *official* RTDM CAN profile?
> Yes. I study your framework, but to be sincere i think that the
> capabilities/specifications are too far between. In particular all the
stuff
> related with the remote frame data exchange. The expected latencies and
the
> porting to other frameworks/platforms are also important to the
> re-usage-design. I have reviewed the official one as a reference to
> programming with the new symbols set and to check different approaches to
> solve our stuff.

Don't fully get your requirements yet - food for discussion on the
public list I guess.

>
>> If yes and something was missing/insufficient in that profile:
>>    Why was it impossible to extend it (so that at least basic CAN
>>    operations remain portable, tools can be reused)?
>
> I think that two matters were around my mind, time and optimal design.
> You must consider also the opposite situation. we already have a design
> implemented with the necessary tools to check/verify/validate; the point
is
> that we like/need to add it real time capabilities. This
> implementation/ideas ha/s/ve been ported from things like uclinux-mcf5282,
> linux-i386 including also MC51 micro controllers.

See, Socket-CAN is close to mainline Linux, and RT-Socket-CAN (ie.
RTDM's CAN profile) is compatible with it, just making it deterministic
under the hood. Older CAN frameworks for Linux, including commercial
ones, will more and more become obsolete.

If there are technical deficits, specifically compared to pre-existing
approaches, _that_ would be very interesting to discuss with the aim to
improve the design wherever feasible. Maybe it turns out that certain
scenarios simply require different approaches. But as long as deficits
aren't really discussed and, at best, quantified, we make no progress.

> Other important issue is my time and the required one to write the sources
> following the profile specification, which must be also fully understood.
> i.e. the sources don't consider at any stage the 11 and 29 bits stuff, our
> application is 29 bits focused on, so the stuff is removed
> I mean, we need to have the driver ready to the application purposes ASAP
> and this could be contradictory also with other generalist issues. Of
> course, I assume that i.e. that fix will be easy but i like to clarify
that
> this kind of things are minors from our point of view. The documentation
> that i need to build any case, will present these design issues in terms
of
> functional operation and provided tools.

Looking forward.

>
>> What are your plans with the driver? How/where are you planning to
>> maintain it?
>
> Right now i am worry about it's reliability on stress. This is one of the
> things that we have checked once and again at our company, a design is
> proposed, implemented, verified and validated but not under the worst case
> when all the software is fully weird, then the people cry.
>
> To be honest i haven't thought about the external issues in terms of
> maintenance, this is new for me. If the Xenomai crew like the stuff of
> course your control version repositories would be the best place. At our

For Xenomai integration, we either need a patch against the existing
stack, enhancing it in favour of creating a second one. Or we need
evidence that only a different approach is adequate for certain CAN
controllers and/or CAN applications.

> company we hold the driver stuff as much as possible, all the changes are
> biased to the application level, we don't add too much functionalities in
> the kernel space from the validation stage.
> I think you should guide me about the possibilities..

Or course, you can always stick with "grow your own". That's often
cheaper to start with, but wastes resources on the long term - as you
loose community participation, including a far broader testing, review,
and enhancement you generally can organise on your own.

>
>> So, my question will surely be critical :),
> Of curse not, it's only a matter to share/clarify points o view.. your
> comments are welcome..
>
>> but that shall not mean I don't appreciate your work! It's yet another
>> nice driver that may help people to build solutions. Well, and maybe we
can
>> still find common ground.
>
> That's it. I hope to have enough time to manage the stuff. To be
confidence
> i think that the stuff give a different point of view so could useful to
> somebody..
>
>> Thanks!
>> Jan
>
> I am grateful to ear your comments/opinions,
> Cheers
>
> So, I will post something related on in the  xenomai-core list.. OK?

Yep.

>
> PS: Your archive name should end like ...tar.bz2.
>
> Guau.. uups sorry...
>

Jan

------=_Part_52191_33136819.1186994063052
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello <span id="_user_wg@domain.hid" style="color: rgb(121, 6, 25);">Wolfgang</span> this is the previous mail thread maintained with Jan and i hope it answer your question<br><br>---------- Forwarded message ----------
<br><span class="gmail_quote">From: <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;<br>Date: Aug 13, 2007 1:13 AM<br>Subject: Re: i82527 CANbus RTDM driver<br>To: juanba romance &lt;
<a href="mailto:juanba.romance@domain.hid">juanba.romance@domain.hid</a>&gt;<br><br></span>juanba romance wrote:<br>&gt; On 8/12/07, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;&gt; Hi Juanba,
<br>&gt;&gt;<br>&gt;&gt; I won&#39;t go much into technical and design details in this reply, because<br>&gt;&gt; I&#39;m hoping we can continue this discussion on some public list.<br>&gt;&gt; Xenomai-core e.g.?<br>&gt;<br>
&gt; I think that right now the sources are not too useful in a first &quot;public&quot;<br>&gt; post, may be better to announce in the list that i am developing the stuff and<br>&gt; wait if somebody else shows any interest would be better
<br>&gt;<br>&gt;&nbsp; Would you like to re-post? With or without code<br>&gt; (there is likely some size limit, so pushing code to a webserver is better)?<br>&gt; Of course, yes..<br>&gt;<br>&gt; Some questions I&#39;m going to ask then:
<br>&gt;&gt; - Is your API compatible to any pre-existing one?<br>&gt; I don&#39;t think so, the stuff use specific objects/interfaces of the Xenomai-framework<br>&gt; to exchange the control and data flow between the user and kernel address
<br>&gt; spaces.<br><br>I was referring to the API the user of the CAN driver sees, not its<br>internal design. On first sight, I don&#39;t see Xenomai specifics in the<br>interface.<br><br>&gt; In fact the objects/system calls were selected having in mind the driver
<br>&gt; capabilities which also income from our previous designs/products around the 82527<br>&gt; chipset<br>&gt;<br>&gt; &gt; Did you consider the *official* RTDM CAN profile?<br>&gt; Yes. I study your framework, but to be sincere i think that the
<br>&gt; capabilities/specifications are too far between. In particular all the stuff<br>&gt; related with the remote frame data exchange. The expected latencies and the<br>&gt; porting to other frameworks/platforms are also important to the
<br>&gt; re-usage-design. I have reviewed the official one as a reference to<br>&gt; programming with the new symbols set and to check different approaches to<br>&gt; solve our stuff.<br><br>Don&#39;t fully get your requirements yet - food for discussion on the
<br>public list I guess.<br><br>&gt;<br>&gt;&gt; If yes and something was missing/insufficient in that profile:<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;Why was it impossible to extend it (so that at least basic CAN<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;operations remain portable, tools can be reused)?
<br>&gt;<br>&gt; I think that two matters were around my mind, time and optimal design.<br>&gt; You must consider also the opposite situation. we already have a design<br>&gt; implemented with the necessary tools to check/verify/validate; the point is
<br>&gt; that we like/need to add it real time capabilities. This<br>&gt; implementation/ideas ha/s/ve been ported from things like uclinux-mcf5282,<br>&gt; linux-i386 including also MC51 micro controllers.<br><br>See, Socket-CAN is close to mainline Linux, and RT-Socket-CAN (ie.
<br>RTDM&#39;s CAN profile) is compatible with it, just making it deterministic<br>under the hood. Older CAN frameworks for Linux, including commercial<br>ones, will more and more become obsolete.<br><br>If there are technical deficits, specifically compared to pre-existing
<br>approaches, _that_ would be very interesting to discuss with the aim to<br>improve the design wherever feasible. Maybe it turns out that certain<br>scenarios simply require different approaches. But as long as deficits
<br>aren&#39;t really discussed and, at best, quantified, we make no progress.<br><br>&gt; Other important issue is my time and the required one to write the sources<br>&gt; following the profile specification, which must be also fully understood.
<br>&gt; i.e. the sources don&#39;t consider at any stage the 11 and 29 bits stuff, our<br>&gt; application is 29 bits focused on, so the stuff is removed<br>&gt; I mean, we need to have the driver ready to the application purposes ASAP
<br>&gt; and this could be contradictory also with other generalist issues. Of<br>&gt; course, I assume that i.e. that fix will be easy but i like to clarify that<br>&gt; this kind of things are minors from our point of view. The documentation
<br>&gt; that i need to build any case, will present these design issues in terms of<br>&gt; functional operation and provided tools.<br><br>Looking forward.<br><br>&gt;<br>&gt;&gt; What are your plans with the driver? How/where are you planning to
<br>&gt;&gt; maintain it?<br>&gt;<br>&gt; Right now i am worry about it&#39;s reliability on stress. This is one of the<br>&gt; things that we have checked once and again at our company, a design is<br>&gt; proposed, implemented, verified and validated but not under the worst case
<br>&gt; when all the software is fully weird, then the people cry.<br>&gt;<br>&gt; To be honest i haven&#39;t thought about the external issues in terms of<br>&gt; maintenance, this is new for me. If the Xenomai crew like the stuff of
<br>&gt; course your control version repositories would be the best place. At our<br><br>For Xenomai integration, we either need a patch against the existing<br>stack, enhancing it in favour of creating a second one. Or we need
<br>evidence that only a different approach is adequate for certain CAN<br>controllers and/or CAN applications.<br><br>&gt; company we hold the driver stuff as much as possible, all the changes are<br>&gt; biased to the application level, we don&#39;t add too much functionalities in
<br>&gt; the kernel space from the validation stage.<br>&gt; I think you should guide me about the possibilities..<br><br>Or course, you can always stick with &quot;grow your own&quot;. That&#39;s often<br>cheaper to start with, but wastes resources on the long term - as you
<br>loose community participation, including a far broader testing, review,<br>and enhancement you generally can organise on your own.<br><br>&gt;<br>&gt;&gt; So, my question will surely be critical :),<br>&gt; Of curse not, it&#39;s only a matter to share/clarify points o view.. your
<br>&gt; comments are welcome..<br>&gt;<br>&gt;&gt; but that shall not mean I don&#39;t appreciate your work! It&#39;s yet another<br>&gt;&gt; nice driver that may help people to build solutions. Well, and maybe we can<br>
&gt;&gt; still find common ground.<br>&gt;<br>&gt; That&#39;s it. I hope to have enough time to manage the stuff. To be confidence<br>&gt; i think that the stuff give a different point of view so could useful to<br>&gt; somebody..
<br>&gt;<br>&gt;&gt; Thanks!<br>&gt;&gt; Jan<br>&gt;<br>&gt; I am grateful to ear your comments/opinions,<br>&gt; Cheers<br>&gt;<br>&gt; So, I will post something related on in the&nbsp;&nbsp;xenomai-core list.. OK?<br><br>Yep.<br>
<br>&gt;<br>&gt; PS: Your archive name should end like ...tar.bz2.<br>&gt;<br>&gt; Guau.. uups sorry...<br>&gt;<br><br>Jan<br><br>

------=_Part_52191_33136819.1186994063052--

------=_Part_52190_29132257.1186994063052
Content-Type: text/plain; name=signature.asc; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: 0.1
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC42IChNaW5n
VzMyKQpDb21tZW50OiBVc2luZyBHbnVQRyB3aXRoIE1vemlsbGEgLSBodHRwOi8vZW5pZ21haWwu
bW96ZGV2Lm9yZwoKaUQ0REJRRkd2NVFwbmlET29NSFRBK2tSQWtHQUFKamQyNG85RjErVXJvdnhR
SEZiZVoxekpKekNBSjBYY0MvMApRdUpJdjVTa21hYWRxSnovNHd3Nkp3PT0KPXN1Z2QKLS0tLS1F
TkQgUEdQIFNJR05BVFVSRS0tLS0tCg==
------=_Part_52190_29132257.1186994063052--

