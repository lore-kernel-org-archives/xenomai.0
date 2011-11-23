MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
In-Reply-To: <4ECCB27F.3040903@domain.hid>
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
	<4ECA2FF8.7040406@domain.hid>
	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>
	<4ECA5E12.5040907@domain.hid>
	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>
	<4ECB967C.70509@domain.hid>
	<CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>
	<CAMesUR6Jx7WuZNsY6WmomD-ExoJ9hhKovKiekrr71Kbrk7Jb_A@mail.gmail.com>
	<4ECCB27F.3040903@domain.hid>
Date: Wed, 23 Nov 2011 10:53:35 +0100
Message-ID: <CA+eKTkZp5M8OTHyLBBM=S5=5C-WaVrLgSsWOtzA1_y=z4ujTJw@domain.hid>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3071cff8b72ec304b263e440
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

--20cf3071cff8b72ec304b263e440
Content-Type: text/plain; charset=ISO-8859-1

I use Xenomai 2.5.6 with drivers nipcimio. Should I try it with the latest
2.6 version ?

Thanks again for all your ideas !

Hadrien

On Wed, Nov 23, 2011 at 9:44 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 11/22/2011 11:33 PM, Alexis Berlemont wrote:
> > On Tue, Nov 22, 2011 at 2:43 PM, Hadrien Caron <hadrien.caron@domain.hid>
> wrote:
> >> Alexis : yes I am using the Analogy drivers . . . Would that mean that
> >> analog output is implemented but not digital output for National
> Instrument
> >> acquisition cards ? Has someone tried this already ? Seems strange that
> >> analog output would be implemented but not digital.
> >>
> >> Anders : Ok ! I will look into rebulding my xenomai installation then !
> >
> > According to the thread:
> > [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails with ENOSYS)
> > https://mail.gna.org/public/xenomai-core/2011-07/msg00010.html
> > The problem related by Anders Blomdell is supposed to be fixed with
> > the 2.6 release, isn't it?
> >
> > Could you tell us which version of Xenomai and which driver
> > (ni_pcimio, ...) you are using?
>
> Hi,
>
> the problem is not fixed, we can not compile xenomai without frame
> pointers.
>
> --
>                                                                Gilles.
>

--20cf3071cff8b72ec304b263e440
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I use Xenomai 2.5.6 with drivers nipcimio. Should I try it with the latest =
2.6 version ?<br><br>Thanks again for all your ideas !<br><br>Hadrien<br><b=
r><div class=3D"gmail_quote">On Wed, Nov 23, 2011 at 9:44 AM, Gilles Chante=
perdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
i.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>On 11/22/2011 11:33 PM, Alexis Berlemont wrote:<br>
</div><div class=3D"im">&gt; On Tue, Nov 22, 2011 at 2:43 PM, Hadrien Caron=
 &lt;<a href=3D"mailto:hadrien.caron@domain.hid">hadrien.caron@domain.hid</a>=
&gt; wrote:<br>
&gt;&gt; Alexis : yes I am using the Analogy drivers . . . Would that mean =
that<br>
&gt;&gt; analog output is implemented but not digital output for National I=
nstrument<br>
&gt;&gt; acquisition cards ? Has someone tried this already ? Seems strange=
 that<br>
&gt;&gt; analog output would be implemented but not digital.<br>
&gt;&gt;<br>
&gt;&gt; Anders : Ok ! I will look into rebulding my xenomai installation t=
hen !<br>
&gt;<br>
&gt; According to the thread:<br>
&gt; [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails with ENOS=
YS)<br>
&gt; <a href=3D"https://mail.gna.org/public/xenomai-core/2011-07/msg00010.h=
tml" target=3D"_blank">https://mail.gna.org/public/xenomai-core/2011-07/msg=
00010.html</a><br>
&gt; The problem related by Anders Blomdell is supposed to be fixed with<br=
>
&gt; the 2.6 release, isn&#39;t it?<br>
&gt;<br>
&gt; Could you tell us which version of Xenomai and which driver<br>
&gt; (ni_pcimio, ...) you are using?<br>
<br>
</div>Hi,<br>
<br>
the problem is not fixed, we can not compile xenomai without frame pointers=
.<br>
<font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--20cf3071cff8b72ec304b263e440--

