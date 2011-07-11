MIME-Version: 1.0
In-Reply-To: <4E1AE8AD.9060703@domain.hid>
References: <CALiYb9uRfYeG4NTV7Oy1bMpxtJz0skKsxM9D2k_G5uOZsWWQBQ@mail.gmail.com>
	<4E1AD8DD.3060904@domain.hid>
	<CALiYb9t21ijjNnpU4dVjfaKF3V_8XxGypUiiOkVROQdVyx-u8g@domain.hid>
	<4E1AE8AD.9060703@domain.hid>
Date: Mon, 11 Jul 2011 14:20:29 +0200
Message-ID: <CALiYb9tSjoDQhj+RPEVp-LgV+c7haTC-yh1SZ_ChXHVz1pPAUg@domain.hid>
From: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Content-Type: multipart/alternative; boundary=20cf305e2551815ba004a7ca356f
Subject: Re: [Xenomai-help] Problems with gdb and rt_task_delete
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--20cf305e2551815ba004a7ca356f
Content-Type: text/plain; charset=ISO-8859-1

2011/7/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 07/11/2011 01:48 PM, Adrien LEMAITRE wrote:
> > 2011/7/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 07/11/2011 11:50 AM, Adrien LEMAITRE wrote:
> >>> Hello,
> >>>
> >>> I have two problems. Just before explain my problems i would like to
> >> clarify
> >>> the context. This exercice is for student. In this exercice, they
> program
> >> a
> >>> WorkingTask (infini loop)
> >>
> >> That is the problem, there should not busy inifinite loops.
> >> rt_task_sleep(100) asks for 100ns sleep, which is equivalent to not
> >> sleeping at all.
> >>
> >> I seem to remember that I already told you this in answer to your
> >> previous post.
> >>
> >
> > yes and thanks you, i have a better understanding now. So ok if i would
> like
> > to make an infini loop i must add a sleep of 5ms, otherwise i have
> problems.
> > That is why i had needed rt_task_suspend(). And the problem with gdb is
> > gone.
> >
> > But i don't see information of this in the wiki, could you show me
> exactly
> > where i can find it?
> >
>
> You can probably sleep for shorter times than 5ms, 100us should be
> enough. This is not documented, because it is an unwanted shortcoming,
> which we hope to avoid one day, by implementing signals for xenomai,
> working even for interrupting an infinite busy loop.
>
>
Yes sorry it's not 5ms but 5us. Thanks a lot.


> --
>                                             Gilles.
>

--20cf305e2551815ba004a7ca356f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/7/11 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5">On 07/11/2011 01:48 PM, Adrien LEMAITRE w=
rote:<br>
&gt; 2011/7/11 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; On 07/11/2011 11:50 AM, Adrien LEMAITRE wrote:<br>
&gt;&gt;&gt; Hello,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I have two problems. Just before explain my problems i would l=
ike to<br>
&gt;&gt; clarify<br>
&gt;&gt;&gt; the context. This exercice is for student. In this exercice, t=
hey program<br>
&gt;&gt; a<br>
&gt;&gt;&gt; WorkingTask (infini loop)<br>
&gt;&gt;<br>
&gt;&gt; That is the problem, there should not busy inifinite loops.<br>
&gt;&gt; rt_task_sleep(100) asks for 100ns sleep, which is equivalent to no=
t<br>
&gt;&gt; sleeping at all.<br>
&gt;&gt;<br>
&gt;&gt; I seem to remember that I already told you this in answer to your<=
br>
&gt;&gt; previous post.<br>
&gt;&gt;<br>
&gt;<br>
&gt; yes and thanks you, i have a better understanding now. So ok if i woul=
d like<br>
&gt; to make an infini loop i must add a sleep of 5ms, otherwise i have pro=
blems.<br>
&gt; That is why i had needed rt_task_suspend(). And the problem with gdb i=
s<br>
&gt; gone.<br>
&gt;<br>
&gt; But i don&#39;t see information of this in the wiki, could you show me=
 exactly<br>
&gt; where i can find it?<br>
&gt;<br>
<br>
</div></div>You can probably sleep for shorter times than 5ms, 100us should=
 be<br>
enough. This is not documented, because it is an unwanted shortcoming,<br>
which we hope to avoid one day, by implementing signals for xenomai,<br>
working even for interrupting an infinite busy loop.<br>
<br></blockquote><div><br></div><div>Yes sorry it&#39;s not 5ms but 5us. Th=
anks a lot.</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--20cf305e2551815ba004a7ca356f--

