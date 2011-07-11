MIME-Version: 1.0
In-Reply-To: <4E1AD8DD.3060904@domain.hid>
References: <CALiYb9uRfYeG4NTV7Oy1bMpxtJz0skKsxM9D2k_G5uOZsWWQBQ@mail.gmail.com>
	<4E1AD8DD.3060904@domain.hid>
Date: Mon, 11 Jul 2011 13:48:13 +0200
Message-ID: <CALiYb9t21ijjNnpU4dVjfaKF3V_8XxGypUiiOkVROQdVyx-u8g@domain.hid>
From: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Content-Type: multipart/alternative; boundary=20cf303bfb3017338d04a7c9c2a5
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

--20cf303bfb3017338d04a7c9c2a5
Content-Type: text/plain; charset=ISO-8859-1

2011/7/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 07/11/2011 11:50 AM, Adrien LEMAITRE wrote:
> > Hello,
> >
> > I have two problems. Just before explain my problems i would like to
> clarify
> > the context. This exercice is for student. In this exercice, they program
> a
> > WorkingTask (infini loop)
>
> That is the problem, there should not busy inifinite loops.
> rt_task_sleep(100) asks for 100ns sleep, which is equivalent to not
> sleeping at all.
>
> I seem to remember that I already told you this in answer to your
> previous post.
>

yes and thanks you, i have a better understanding now. So ok if i would like
to make an infini loop i must add a sleep of 5ms, otherwise i have problems.
That is why i had needed rt_task_suspend(). And the problem with gdb is
gone.

But i don't see information of this in the wiki, could you show me exactly
where i can find it?



>
> --
>                                                                 Gilles.
>

--20cf303bfb3017338d04a7c9c2a5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/7/11 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 07/11/2011 11:50 AM, Adrien LEMAITRE wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I have two problems. Just before explain my problems i would like to c=
larify<br>
&gt; the context. This exercice is for student. In this exercice, they prog=
ram a<br>
&gt; WorkingTask (infini loop)<br>
<br>
</div>That is the problem, there should not busy inifinite loops.<br>
rt_task_sleep(100) asks for 100ns sleep, which is equivalent to not<br>
sleeping at all.<br>
<br>
I seem to remember that I already told you this in answer to your<br>
previous post.<br></blockquote><div><br></div><div>yes and thanks you, i ha=
ve a better understanding now. So ok if i would like to make an infini loop=
 i must add a sleep of 5ms, otherwise i have problems. That is why i had ne=
eded rt_task_suspend(). And the problem with gdb is gone.=A0</div>
<div><br></div><div>But i don&#39;t see information of this in the wiki, co=
uld you show me exactly where i can find it?</div><div><br></div><div>=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex;">

<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--20cf303bfb3017338d04a7c9c2a5--

