Message-ID: <b647ffbd0601180119p3921a79h@domain.hid>
Date: Wed, 18 Jan 2006 11:19:31 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] shared irqs v.3
In-Reply-To: <43CCF1FF.5040709@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_13485_21751412.1137575971107"
References: <b647ffbd0601150050k573ef53fu@domain.hid>
	<43CCF1FF.5040709@domain.hid>
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

------=_Part_13485_21751412.1137575971107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,

> As lighter may mean that reducing the structure size also
> reduces the number of used cache lines, it might be a good
> idea. The additional complexity for entry removal is negligible.

My current working version is already lighter when it comes to the size of
additional data structures. It's implemented via the one-way linked list
instead of xnqueue_t. This way, it's 3 times lighter for UP and 2 times for
SMP systems.

I'll try to post it today later. The only problem remaining is the
compilation issues so I should fix it before posting, namely:

it looks like some code in kscr/nucleus (e.g. intr.c) is used for compiling
both kernel-mode code (of cousre) and user-mode (maybe for UVM, though I
haven't looked at it thoroughly yet). The link to ksrc/nucleus is created i=
n
the src/ directory.

Both the IPIPE_NR_IRQS macro and rthal_critical_enter/exit() calls are
undefined when intr.c is compiled for the user-mode side. That's why it so
far contains those __IPIPE_NR_IRQS and "external int
rthal_critical_enter/exit()" definitions.

I hope that also answers your another question later on this mail.

> >
> >     Beleive it or not, I have considered different ways to
> >guarantee that a  passed "cookie" param is valid
> >     (xnintr_detach() has not deleted it) and remains to be so
> > while the xnintr_irq_handler() is running.
> >     And there are some obstacles there... I'll post them later if > >
someone is interested since I'm short of time now :)
> >     ...

> I'm interested...

Ok. So I will have at least a reader :) Actually, I still hope to find out
some solution so to make use of the recently extended ipipe interface as it
was supposed to be used (then there is no need for any per-irq "xnshirqs"
array in intr.c).

Otherwise, I have to admit that my recent work with that ipipe extension (I
can ay it since I made it) is of no big avail.
Maybe we together will find out a solution.

> > That code is compiled for the user-mode code also and the
> >originals are not available. So consider it a temp
> > solution for test purposes, I guess it's easily fixable.
> >
> > test/shirq.c - is a test module.
> >
> > SHIRQ_VECTOR must be the one used by Linux, e.g. I have > >used 12
that's used
> > by the trackball device.
> >
> >
> I haven't tried your code yet, but in the preparation of a real
>scenario I stumbled over a problem in my serial driver regarding > IRQ
sharing: In case you want to use xeno_16550A for ISA >devices with shared
IRQs, an iteration over the list of registered >handlers would be required
/until/ no device reported that it >handled something. This is required so
that the IRQ line gets
> released for a while and system obtains a chance to
> detect a new /edge/ triggered IRQ - ISA oddity.
>
> That's the way most serial drivers work, but they do it internally.
> So the question arose for me if this edge-specific handling
> shouldn't be moved to the nucleus as well (so that I don't have > to fix
my 16550A ;)).

Brrr... frankly speaking, I haven't got it clearly so don't want to make
pure speculations. Probably I have to take a look at the xeno_16550A driver
keeping in mind your words.

> Another optimisation idea, which I once also realised in my
> own shared IRQ wrapper, is to use specialised trampolines at >the nucleus
level, i.e. to not apply the full sharing logic with its >locking and list
iterations for non-shared IRQs. What do you >think? Worth it? Might be when
the ISA/edge handling adds >further otherwise unneeded overhead.

Yep, maybe. But let's take something working first..

> Jan

--
Best regards,
Dmitry Adamushko

------=_Part_13485_21751412.1137575971107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,<br>
<br>
&gt; As lighter may mean that reducing the structure size also <br>
&gt; reduces the number of used cache lines, it might be a good <br>
&gt; idea. The additional complexity for entry removal is negligible.<br>
<br>
My current working version is already lighter when it comes to the size
of additional data structures. It's implemented via the one-way linked
list instead of xnqueue_t. This way, it's 3 times lighter for UP and 2
times for SMP systems.<br>
<br>
I'll try to post it today later. The only problem remaining is the compilat=
ion issues so I should fix it before posting, namely:<br>
<br>
it looks like some code in kscr/nucleus (e.g. intr.c) is used for
compiling both kernel-mode code (of cousre) and user-mode (maybe for
UVM, though I haven't looked at it thoroughly yet). The link to
ksrc/nucleus is created in the src/ directory.<br>
<br>
Both the IPIPE_NR_IRQS macro and rthal_critical_enter/exit() calls are
undefined when intr.c is compiled for the user-mode side. That's why it
so far contains those __IPIPE_NR_IRQS and &quot;external int
rthal_critical_enter/exit()&quot; definitions.<br>
<br>
I hope that also answers your another question later on this mail.<br>
<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Beleive it or not, I have considered diff=
erent ways to <br>
&gt; &gt;guarantee that a&nbsp; passed &quot;cookie&quot; param is valid<br=
>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; (xnintr_detach() has not deleted it) and =
remains to be so <br>
&gt; &gt; while the xnintr_irq_handler() is running.<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; And there are some obstacles there...
I'll post them later if &gt; &gt; someone is interested since I'm short
of time now :)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>
<br>
&gt; I'm interested...<br>
<br>
Ok. So I will have at least a reader :) Actually, I still hope to find
out some solution so to make use of the recently extended ipipe
interface as it was supposed to be used (then there is no need for any
per-irq &quot;xnshirqs&quot; array in intr.c).<br>
<br>
Otherwise, I have to admit that my recent work with that ipipe extension (I=
 can ay it since I made it) is of no big avail.<br>
Maybe we together will find out a solution.<br>
<br>
&gt; &gt; That code is compiled for the user-mode code also and the <br>
&gt; &gt;originals are not available. So consider it a temp<br>
&gt; &gt; solution for test purposes, I guess it's easily fixable.<br>
&gt; &gt;<br>
&gt; &gt; test/shirq.c - is a test module.<br>
&gt; &gt;<br>
&gt; &gt; SHIRQ_VECTOR must be the one used by Linux, e.g. I have &gt; &gt;=
used 12 that's used<br>
&gt; &gt; by the trackball device.<br>
&gt; &gt;<br>
&gt; &gt; <br>
&gt; I haven't tried your code yet, but in the preparation of a real <br>
&gt;scenario I stumbled over a problem in my serial driver regarding
&gt; IRQ sharing: In case you want to use xeno_16550A for ISA
&gt;devices with shared IRQs, an iteration over the list of registered
&gt;handlers would be required /until/ no device reported that it
&gt;handled something. This is required so that the IRQ line gets <br>
&gt; released for a while and system obtains a chance to<br>
&gt; detect a new /edge/ triggered IRQ - ISA oddity.<br>
&gt; <br>
&gt; That's the way most serial drivers work, but they do it internally. <b=
r>
&gt; So the question arose for me if this edge-specific handling <br>
&gt; shouldn't be moved to the nucleus as well (so that I don't have &gt; t=
o fix my 16550A ;)).<br>
<br>
Brrr... frankly speaking, I haven't got it clearly so don't want to
make pure speculations. Probably I have to take a look at the
xeno_16550A driver keeping in mind your words.<br>
<br>
&gt; Another optimisation idea, which I once also realised in my <br>
&gt; own shared IRQ wrapper, is to use specialised trampolines at
&gt;the nucleus level, i.e. to not apply the full sharing logic with
its &gt;locking and list iterations for non-shared IRQs. What do you
&gt;think? Worth it? Might be when the ISA/edge handling adds
&gt;further otherwise unneeded overhead.<br>
<br>
Yep, maybe. But let's take something working first..<br>
<br>
&gt; Jan<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_13485_21751412.1137575971107--

