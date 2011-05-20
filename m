MIME-Version: 1.0
In-Reply-To: <1305900713.2109.23.camel@domain.hid>
References: <BANLkTinYewN9P3qLqRwP_XZw0HSaAvRfrw@domain.hid>
	<1305900713.2109.23.camel@domain.hid>
Date: Fri, 20 May 2011 17:30:46 +0200
Message-ID: <BANLkTikTNsFxf--9Z=7JqKNkHOkPeXadpA@mail.gmail.com>
From: Hadrien Caron <hadrienstegosaure@domain.hid>
Content-Type: multipart/alternative; boundary=0016364eebb247a89404a3b6ce39
Subject: Re: [Xenomai-help] Meaning of -ENOMEM in rt_pipe_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0016364eebb247a89404a3b6ce39
Content-Type: text/plain; charset=ISO-8859-1

Thank you very much for the fast response and clear explanation !
I will try these options and let you know how it went !

Thanks again !

Hadrien

On Fri, May 20, 2011 at 4:11 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Fri, 2011-05-20 at 15:27 +0200, Hadrien Caron wrote:
> > Hello, I am new to using the Xenomai API and I have a basic question
> > regarding
> > the error indicator I just received.
> >
> > I send large amount of data through pipe using rt_pipe_read and
>
> You likely mean rt_pipe_write().
>
> >  eventually get a return error of -ENOMEM
> >
> > On the documentation I saw that :
> >
> > -ENOMEM is returned if not enough buffer space is available to
> > complete the operation.
> >
> > I suppose the buffer refers to the internal buffer of the pipe to
> > which the data is copied.
> > I don't understand what I am supposed to do in order to free space on
> > that buffer so that there
> > is enough memory.
> >
> > Could someone give some information about how the buffer is handled ?
> >
>
> The real-time sender via rt_pipe_write() pulls memory from an internal
> allocator, and that memory is released when the non real-time side reads
> from its endpoint. So you get -ENOMEM likely because the latter does not
> read fast enough.
>
> Possible options:
>
> - increase the size of the system heap, which is being used when no
> private memory pool has been defined for the pipe. See
> CONFIG_XENO_OPT_SYS_HEAP in your kernel .config.
>
> - assign a private memory pool to the pipe via rt_pipe_create()'s
> poolsize parameter, large enough to cope with the throughput. The
> message space won't be pulled from the system heap in that case, but
> from the private pool, which will be entirely reserved for that purpose.
>
> - implement some sort of congestion control between the write and the
> read sides, to avoid depleting the memory pool on the write side, by
> waiting for the read side to pick up the messages when some watermark is
> reached. Of course, this introduces a priority inversion, so whether it
> is acceptable depends on your requirements.
>
> - read the data faster from the non real-time endpoint, or send it
> slower from the write side.
>
> > Thank you very much in advance.
> >
> > Regards,
> >
> > Hadrien Caron
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
>
>

--0016364eebb247a89404a3b6ce39
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you very much for the fast response and clear explanation !<br>
I will try these options and let you know how it went !<br>
<br>
Thanks again !<br>
<br>
Hadrien<br><br><div class=3D"gmail_quote">On Fri, May 20, 2011 at 4:11 PM, =
Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm=
@xenomai.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204);=
 padding-left: 1ex;">
<div class=3D"im">On Fri, 2011-05-20 at 15:27 +0200, Hadrien Caron wrote:<b=
r>
&gt; Hello, I am new to using the Xenomai API and I have a basic question<b=
r>
&gt; regarding<br>
&gt; the error indicator I just received.<br>
&gt;<br>
&gt; I send large amount of data through pipe using rt_pipe_read and<br>
<br>
</div>You likely mean rt_pipe_write().<br>
<div class=3D"im"><br>
&gt; =A0eventually get a return error of -ENOMEM<br>
&gt;<br>
&gt; On the documentation I saw that :<br>
&gt;<br>
&gt; -ENOMEM is returned if not enough buffer space is available to<br>
&gt; complete the operation.<br>
&gt;<br>
&gt; I suppose the buffer refers to the internal buffer of the pipe to<br>
&gt; which the data is copied.<br>
&gt; I don&#39;t understand what I am supposed to do in order to free space=
 on<br>
&gt; that buffer so that there<br>
&gt; is enough memory.<br>
&gt;<br>
&gt; Could someone give some information about how the buffer is handled ?<=
br>
&gt;<br>
<br>
</div>The real-time sender via rt_pipe_write() pulls memory from an interna=
l<br>
allocator, and that memory is released when the non real-time side reads<br=
>
from its endpoint. So you get -ENOMEM likely because the latter does not<br=
>
read fast enough.<br>
<br>
Possible options:<br>
<br>
- increase the size of the system heap, which is being used when no<br>
private memory pool has been defined for the pipe. See<br>
CONFIG_XENO_OPT_SYS_HEAP in your kernel .config.<br>
<br>
- assign a private memory pool to the pipe via rt_pipe_create()&#39;s<br>
poolsize parameter, large enough to cope with the throughput. The<br>
message space won&#39;t be pulled from the system heap in that case, but<br=
>
from the private pool, which will be entirely reserved for that purpose.<br=
>
<br>
- implement some sort of congestion control between the write and the<br>
read sides, to avoid depleting the memory pool on the write side, by<br>
waiting for the read side to pick up the messages when some watermark is<br=
>
reached. Of course, this introduces a priority inversion, so whether it<br>
is acceptable depends on your requirements.<br>
<br>
- read the data faster from the non real-time endpoint, or send it<br>
slower from the write side.<br>
<div class=3D"im"><br>
&gt; Thank you very much in advance.<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Hadrien Caron<br>
</div>&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016364eebb247a89404a3b6ce39--

