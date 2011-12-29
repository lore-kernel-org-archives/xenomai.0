MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
In-Reply-To: <4EEB5ABF.8020201@domain.hid>
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
	<4ECA2FF8.7040406@domain.hid>
	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>
	<4ECA5E12.5040907@domain.hid>
	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>
	<4ECB967C.70509@domain.hid>
	<CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>
	<CAMesUR6Jx7WuZNsY6WmomD-ExoJ9hhKovKiekrr71Kbrk7Jb_A@mail.gmail.com>
	<4ECCB27F.3040903@domain.hid>
	<CA+eKTkZp5M8OTHyLBBM=S5=5C-WaVrLgSsWOtzA1_y=z4ujTJw@domain.hid>
	<CA+eKTkZFiMTFZe4jyhhD3b064bQDQMMcgVW+YMU5SJKeVnCiZA@mail.gmail.com>
	<CA+eKTkbcuv6GkD1mwz_p++F7144fF3Eq0gisg69yAdH9KneD3w@domain.hid>
	<4EEB4599.3030707@domain.hid> <4EEB590A.2090108@domain.hid>
	<4EEB5ABF.8020201@domain.hid>
Date: Thu, 29 Dec 2011 18:22:44 +0100
Message-ID: <CA+eKTkanSObCHedoDfLEJAJrpxB-8AoO_Q-RosTNykxOhqCM-A@mail.gmail.com>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307f33be56269104b53e5db0
Subject: Re: [Xenomai-help] [xenomai-help] Error return with a4l_sync_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--20cf307f33be56269104b53e5db0
Content-Type: text/plain; charset=ISO-8859-1

Hello !

Sorry for the delay, I was out of town for the week.
Hope you all had a nice christmas.
Thanks for the input. In fact I am sorry but I didn't find what it means to
compile with -fno-omit-frame-pointer

I found a SCHED_OMIT_FRAME_POINTER option in the kernel but it was already
enabled so I doubt you were talking about that.

Is it an option to pass to the compiler ? I found -fomit-frame-pointer in
the gcc manual . . . Should I modify xenomai's Makefile to add this option
to the compilation ?

Thanks again ! And happy new year ;)

Hadrien

On Fri, Dec 16, 2011 at 3:50 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 12/16/2011 03:43 PM, Anders Blomdell wrote:
> > On 12/16/2011 02:20 PM, Gilles Chanteperdrix wrote:
> >> On 12/16/2011 01:39 PM, Hadrien Caron wrote:
> >>> Hello again !
> >>> I am kind of stuck right now, anybody has an idea regarding my post ?
> >>> Anyone able to help ?
> >>>
> >>> Thanks in advance,
> >>
> >> Have you tried compiling with -fno-omit-frame-pointer (like Anders told
> >> you)?
> > How about adding this to be automatically done?
>
> It is on the todo list for 2.6.1.
>
> --
>                                            Gilles.
>

--20cf307f33be56269104b53e5db0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello !<br><br>Sorry for the delay, I was out of town for the week.<br>Hope=
 you all had a nice christmas.<br>Thanks for the input. In fact I am sorry =
but I didn&#39;t find what it means to compile with  -fno-omit-frame-pointe=
r<br>
<br>I found a SCHED_OMIT_FRAME_POINTER option in the kernel but it was alre=
ady enabled so I doubt you were talking about that.<br><br>Is it an option =
to pass to the compiler ? I found -fomit-frame-pointer in the gcc manual . =
. . Should I modify xenomai&#39;s Makefile to add this option to the compil=
ation ?<br>
<br>Thanks again ! And happy new year ;)<br><br>Hadrien<br><br><div class=
=3D"gmail_quote">On Fri, Dec 16, 2011 at 3:50 PM, Gilles Chanteperdrix <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gille=
s.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"im">On 12/1=
6/2011 03:43 PM, Anders Blomdell wrote:<br>
&gt; On 12/16/2011 02:20 PM, Gilles Chanteperdrix wrote:<br>
&gt;&gt; On 12/16/2011 01:39 PM, Hadrien Caron wrote:<br>
&gt;&gt;&gt; Hello again !<br>
&gt;&gt;&gt; I am kind of stuck right now, anybody has an idea regarding my=
 post ?<br>
&gt;&gt;&gt; Anyone able to help ?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks in advance,<br>
&gt;&gt;<br>
&gt;&gt; Have you tried compiling with -fno-omit-frame-pointer (like Anders=
 told<br>
&gt;&gt; you)?<br>
&gt; How about adding this to be automatically done?<br>
<br>
</div>It is on the todo list for 2.6.1.<br>
<font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--20cf307f33be56269104b53e5db0--

