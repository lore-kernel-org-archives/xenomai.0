MIME-Version: 1.0
In-Reply-To: <1282730000.1709.49.camel@domain.hid>
References: <AANLkTikXsjX5oRTUYR3Tg_ew9-VEFVMiyTnFUGWRq9Sm@domain.hid>
	<1282730000.1709.49.camel@domain.hid>
Date: Wed, 25 Aug 2010 12:06:44 +0200
Message-ID: <AANLkTi=43FWOyWKFnbEdq3zjgS2s8NsVk6BJ+x-39P7G@mail.gmail.com>
From: Bharath Achuta Bhat <baambekar@domain.hid>
Content-Type: multipart/alternative; boundary=001485f63058f669d3048ea30976
Subject: Re: [Xenomai-help] Page-fault, switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--001485f63058f669d3048ea30976
Content-Type: text/plain; charset=ISO-8859-1

Hi  Philippe,
It is an mmap-ed I/O memory.

Regards
Bharath

On Wed, Aug 25, 2010 at 11:53 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Wed, 2010-08-25 at 11:12 +0200, Bharath Achuta Bhat wrote:
> > Hello Xenomai experts,
> >
> >
> > I am running a xenomai-2.5.1 patched kernel (v 2.6.30.3) with ipipe
> > version 2.7-06.
> > The target is powerpc (MPC8533E).
> > My application is switching to the secondary mode (I guess because of
> > a page-fault) when ntohl() is called.
> > This is a libc function and I am wondering why only this function
> > (ntohl()) is causing a page-fault.
>
> What memory are you reading from / writing to in the statement involving
> ntohl()? Is this plain RAM, or mapped I/O memory?
>
> >
> >
> > Here is how the application looks like
> >
> >
> > main ()
> > {
> > ...
> > ...
> > /* Avoids memory swapping for this program */
> > mlockall(MCL_CURRENT | MCL_FUTURE);
> >
> >
> > ......
> > ......
> > /* signal handlers */
> > .....
> > .....
> > /* create communication pipes */
> > rt_pipe_create(&tPipe1, .....
> > rt_pipe_create(&tPipe2,.......
> >
> >
> > /* create RT tasks */
> > rt_task_create(&tTask1,.....
> > rt_task_create(&tTask2,......
> > ...........
> > ..........
> >
> >
> > /* start the RT tasks */
> > rt_task_start(&tTask1,.....
> > ..............
> > ..............
> >
> >
> > /* turn the current thread into RT function */
> > ret = rt_task_shadow(NULL, "RT main function", 1, T_SUSP);
> >
> >
> > ....
> > ....
> >
> >
> > }
> >
> >
> > One of the rt tasks created calls ntohl() and switches to secondary
> > mode.
> > Is there a way to avoid it ?
> >
> >
> > --
> > Thanks and regards
> > Bharath
> >
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


-- 
Thanks and regards
Bharath

--001485f63058f669d3048ea30976
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; f=
ont-size: 13px; border-collapse: collapse; ">Hi=A0<span style=3D"font-famil=
y: verdana, arial, sans-serif; font-size: 13px; ">=A0<span>Philippe,</span>=
</span><div>
<span></span><font face=3D"verdana, arial, sans-serif">It is an mmap-ed I/O=
 memory.</font></div><div><font face=3D"verdana, arial, sans-serif"><br></f=
ont></div><div><font face=3D"verdana, arial, sans-serif">Regards</font></di=
v>
<div><font face=3D"verdana, arial, sans-serif">Bharath</font></div></span><=
br><div class=3D"gmail_quote">On Wed, Aug 25, 2010 at 11:53 AM, Philippe Ge=
rum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
g</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Wed, 2010-08-25 at 11:=
12 +0200, Bharath Achuta Bhat wrote:<br>
&gt; Hello Xenomai experts,<br>
&gt;<br>
&gt;<br>
&gt; I am running a xenomai-2.5.1 patched kernel (v 2.6.30.3) with ipipe<br=
>
&gt; version 2.7-06.<br>
&gt; The target is powerpc (MPC8533E).<br>
&gt; My application is switching to the secondary mode (I guess because of<=
br>
&gt; a page-fault) when ntohl() is called.<br>
&gt; This is a libc function and I am wondering why only this function<br>
&gt; (ntohl()) is causing a page-fault.<br>
<br>
</div>What memory are you reading from / writing to in the statement involv=
ing<br>
ntohl()? Is this plain RAM, or mapped I/O memory?<br>
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; Here is how the application looks like<br>
&gt;<br>
&gt;<br>
&gt; main ()<br>
&gt; {<br>
&gt; ...<br>
&gt; ...<br>
&gt; /* Avoids memory swapping for this program */<br>
&gt; mlockall(MCL_CURRENT | MCL_FUTURE);<br>
&gt;<br>
&gt;<br>
&gt; ......<br>
&gt; ......<br>
&gt; /* signal handlers */<br>
&gt; .....<br>
&gt; .....<br>
&gt; /* create communication pipes */<br>
&gt; rt_pipe_create(&amp;tPipe1, .....<br>
&gt; rt_pipe_create(&amp;tPipe2,.......<br>
&gt;<br>
&gt;<br>
&gt; /* create RT tasks */<br>
&gt; rt_task_create(&amp;tTask1,.....<br>
&gt; rt_task_create(&amp;tTask2,......<br>
&gt; ...........<br>
&gt; ..........<br>
&gt;<br>
&gt;<br>
&gt; /* start the RT tasks */<br>
&gt; rt_task_start(&amp;tTask1,.....<br>
&gt; ..............<br>
&gt; ..............<br>
&gt;<br>
&gt;<br>
&gt; /* turn the current thread into RT function */<br>
&gt; ret =3D rt_task_shadow(NULL, &quot;RT main function&quot;, 1, T_SUSP);=
<br>
&gt;<br>
&gt;<br>
&gt; ....<br>
&gt; ....<br>
&gt;<br>
&gt;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; One of the rt tasks created calls ntohl() and switches to secondary<br=
>
&gt; mode.<br>
&gt; Is there a way to avoid it ?<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Thanks and regards<br>
&gt; Bharath<br>
&gt;<br>
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
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Thanks and regar=
ds<br>Bharath<br><br>

--001485f63058f669d3048ea30976--

