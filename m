MIME-Version: 1.0
In-Reply-To: <4AEE8FA7.7040804@domain.hid>
References: <ba9b368a0911012316h393aae27y7418e74b2c8a8428@domain.hid>
	<4AEE8FA7.7040804@domain.hid>
Date: Mon, 2 Nov 2009 16:20:38 +0800
Message-ID: <ba9b368a0911020020md0327eev89cf82edb8cdb88d@domain.hid>
From: Daniel Adams <dadams81@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd25c3c765e8804775f0d49
Subject: Re: [Xenomai-help] A few questions about rt_printf
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

--000e0cd25c3c765e8804775f0d49
Content-Type: text/plain; charset=ISO-8859-1

Ah of course :) I must of been not paying attention while reading the
pthread_getspecific calls. Thanks for the clarification.
Dan

On Mon, Nov 2, 2009 at 3:52 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Daniel Adams wrote:
> > Hi,
> >
> > I was looking at using the rt_printf / rt_fprintf for doing deferred
> logging
> > and I have a few questions.
> >
> > 1) I was reading through the source and I noticed there is no locking of
> the
> > buffer write_pos between tasks during the initial snprint into the
> buffer.
> > Is the rt_printf service thread safe? There are calls to
> > xnarch_read_memory_barrier() and xnarch_write_memory_barrier(), but I'm
> > assuming they are for SMP and IO ordering although I'm not 100% on what
> the
> > barriers imply as I'm fairly new to this kind of hardware.
>
> rt_printf buffers are single-writer/single-reader (one per thread)
> lock-less ring buffers, they are safe on both UP and SMP.
>
> >
> > 2) Can the service be called from Linux tasks and Xenomai tasks? We were
> > trying to get away with a common logging interface (wrapping the service)
> > which would allow writing to different streams. If it can't be called
> from a
> > Linux process then we will have an issue if we try to write to the same
> > stream from different write tasks.
>
> Yes, in fact the rr_printf/syslog services of rtdk even work without a
> single bit of Xenomai, so they can be used in any context.
>
> >
> > 3) Why is there multiple buffers allowing multiple FIFO's. I've read the
> > code and can't really see how the extra buffers are used from a users
> > perspective (I can see how the service prints / manages them). It appears
> > that whatever buffer you create with rt_print_init or rt_auto_init is the
> > buffer that get's used for writing too. Is there a way to select the
> buffer
> > you want to write to? Also a call to rt_print_init causes a pre-existing
> > buffer to be written to io from within the callers context and then
> creates
> > a new buffer / ring buffer, so that no matter what you are always writing
> to
> > the head of the linked list of buffers. How do I get access to an old
> buffer
> > once it has been printed? Is there something I'm missing?
>
> See above, buffers are per thread so that we don't need locking.
>
> >
> > I really think I must be missing something, sorry if these are obvious
> > questions.
> >
> > Thanks
> >
> > Dan Adams
> >
>
> HTH,
> Jan
>
>

--000e0cd25c3c765e8804775f0d49
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ah of course :) I must of been not paying attention while reading the pthre=
ad_getspecific calls. Thanks for the clarification.<br>Dan<br><br><div clas=
s=3D"gmail_quote">On Mon, Nov 2, 2009 at 3:52 PM, Jan Kiszka <span dir=3D"l=
tr">&lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Daniel Adams wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I was looking at using the rt_printf / rt_fprintf for doing deferred l=
ogging<br>
&gt; and I have a few questions.<br>
&gt;<br>
&gt; 1) I was reading through the source and I noticed there is no locking =
of the<br>
&gt; buffer write_pos between tasks during the initial snprint into the buf=
fer.<br>
&gt; Is the rt_printf service thread safe? There are calls to<br>
&gt; xnarch_read_memory_barrier() and xnarch_write_memory_barrier(), but I&=
#39;m<br>
&gt; assuming they are for SMP and IO ordering although I&#39;m not 100% on=
 what the<br>
&gt; barriers imply as I&#39;m fairly new to this kind of hardware.<br>
<br>
</div>rt_printf buffers are single-writer/single-reader (one per thread)<br=
>
lock-less ring buffers, they are safe on both UP and SMP.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; 2) Can the service be called from Linux tasks and Xenomai tasks? We we=
re<br>
&gt; trying to get away with a common logging interface (wrapping the servi=
ce)<br>
&gt; which would allow writing to different streams. If it can&#39;t be cal=
led from a<br>
&gt; Linux process then we will have an issue if we try to write to the sam=
e<br>
&gt; stream from different write tasks.<br>
<br>
</div>Yes, in fact the rr_printf/syslog services of rtdk even work without =
a<br>
single bit of Xenomai, so they can be used in any context.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; 3) Why is there multiple buffers allowing multiple FIFO&#39;s. I&#39;v=
e read the<br>
&gt; code and can&#39;t really see how the extra buffers are used from a us=
ers<br>
&gt; perspective (I can see how the service prints / manages them). It appe=
ars<br>
&gt; that whatever buffer you create with rt_print_init or rt_auto_init is =
the<br>
&gt; buffer that get&#39;s used for writing too. Is there a way to select t=
he buffer<br>
&gt; you want to write to? Also a call to rt_print_init causes a pre-existi=
ng<br>
&gt; buffer to be written to io from within the callers context and then cr=
eates<br>
&gt; a new buffer / ring buffer, so that no matter what you are always writ=
ing to<br>
&gt; the head of the linked list of buffers. How do I get access to an old =
buffer<br>
&gt; once it has been printed? Is there something I&#39;m missing?<br>
<br>
</div>See above, buffers are per thread so that we don&#39;t need locking.<=
br>
<div class=3D"im"><br>
&gt;<br>
&gt; I really think I must be missing something, sorry if these are obvious=
<br>
&gt; questions.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Dan Adams<br>
&gt;<br>
<br>
</div>HTH,<br>
<font color=3D"#888888">Jan<br>
<br>
</font></blockquote></div><br>

--000e0cd25c3c765e8804775f0d49--

