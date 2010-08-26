MIME-Version: 1.0
In-Reply-To: <1282746138.1709.133.camel@domain.hid>
References: <AANLkTikXsjX5oRTUYR3Tg_ew9-VEFVMiyTnFUGWRq9Sm@domain.hid>
	<1282730000.1709.49.camel@domain.hid>
	<AANLkTi=43FWOyWKFnbEdq3zjgS2s8NsVk6BJ+x-39P7G@mail.gmail.com>
	<1282746138.1709.133.camel@domain.hid>
Date: Thu, 26 Aug 2010 09:20:38 +0200
Message-ID: <AANLkTikiVe_qz3BzwfPUh-1nf6UV7GG1gBZEmv5NU3+f@domain.hid>
From: Bharath Achuta Bhat <baambekar@domain.hid>
Content-Type: multipart/alternative; boundary=0016367fb11fcb6545048eb4d5cc
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

--0016367fb11fcb6545048eb4d5cc
Content-Type: text/plain; charset=ISO-8859-1

Hi Philippe,
Thank you for the suggestion. I will give it a try and let you know.

Regards
Bharath

On Wed, Aug 25, 2010 at 4:22 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Wed, 2010-08-25 at 12:06 +0200, Bharath Achuta Bhat wrote:
> > Hi  Philippe,
> > It is an mmap-ed I/O memory.
>
> This is a TLB miss which ends up in a heavyweight call to fill the linux
> page table entry. Try to pre-fault the I/O memory region if possible,
> reading some bytes within the same 4k page.
>
> >
> >
> > Regards
> > Bharath
> >
> > On Wed, Aug 25, 2010 at 11:53 AM, Philippe Gerum <rpm@xenomai.org>
> > wrote:
> >         On Wed, 2010-08-25 at 11:12 +0200, Bharath Achuta Bhat wrote:
> >         > Hello Xenomai experts,
> >         >
> >         >
> >         > I am running a xenomai-2.5.1 patched kernel (v 2.6.30.3)
> >         with ipipe
> >         > version 2.7-06.
> >         > The target is powerpc (MPC8533E).
> >         > My application is switching to the secondary mode (I guess
> >         because of
> >         > a page-fault) when ntohl() is called.
> >         > This is a libc function and I am wondering why only this
> >         function
> >         > (ntohl()) is causing a page-fault.
> >
> >
> >         What memory are you reading from / writing to in the statement
> >         involving
> >         ntohl()? Is this plain RAM, or mapped I/O memory?
> >
> >         >
> >         >
> >         > Here is how the application looks like
> >         >
> >         >
> >         > main ()
> >         > {
> >         > ...
> >         > ...
> >         > /* Avoids memory swapping for this program */
> >         > mlockall(MCL_CURRENT | MCL_FUTURE);
> >         >
> >         >
> >         > ......
> >         > ......
> >         > /* signal handlers */
> >         > .....
> >         > .....
> >         > /* create communication pipes */
> >         > rt_pipe_create(&tPipe1, .....
> >         > rt_pipe_create(&tPipe2,.......
> >         >
> >         >
> >         > /* create RT tasks */
> >         > rt_task_create(&tTask1,.....
> >         > rt_task_create(&tTask2,......
> >         > ...........
> >         > ..........
> >         >
> >         >
> >         > /* start the RT tasks */
> >         > rt_task_start(&tTask1,.....
> >         > ..............
> >         > ..............
> >         >
> >         >
> >         > /* turn the current thread into RT function */
> >         > ret = rt_task_shadow(NULL, "RT main function", 1, T_SUSP);
> >         >
> >         >
> >         > ....
> >         > ....
> >         >
> >         >
> >         > }
> >         >
> >         >
> >         > One of the rt tasks created calls ntohl() and switches to
> >         secondary
> >         > mode.
> >         > Is there a way to avoid it ?
> >         >
> >         >
> >         > --
> >         > Thanks and regards
> >         > Bharath
> >         >
> >
> >         > _______________________________________________
> >         > Xenomai-help mailing list
> >         > Xenomai-help@domain.hid
> >         > https://mail.gna.org/listinfo/xenomai-help
> >
> >         --
> >         Philippe.
> >
> >
> >
> >
> >
> > --
> > Thanks and regards
> > Bharath
> >
>
> --
> Philippe.
>
>
>


-- 
Thanks and regards
Bharath

--0016367fb11fcb6545048eb4d5cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi=A0Philippe,<div>Thank you for the suggestion. I will give it a try and l=
et you know.</div><div><br></div><div>Regards</div><div>Bharath<br><br><div=
 class=3D"gmail_quote">On Wed, Aug 25, 2010 at 4:22 PM, Philippe Gerum <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Wed, 2010-08-25 at 12:=
06 +0200, Bharath Achuta Bhat wrote:<br>
&gt; Hi =A0Philippe,<br>
&gt; It is an mmap-ed I/O memory.<br>
<br>
</div>This is a TLB miss which ends up in a heavyweight call to fill the li=
nux<br>
page table entry. Try to pre-fault the I/O memory region if possible,<br>
reading some bytes within the same 4k page.<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; Regards<br>
&gt; Bharath<br>
&gt;<br>
&gt; On Wed, Aug 25, 2010 at 11:53 AM, Philippe Gerum &lt;<a href=3D"mailto=
:rpm@xenomai.org">rpm@xenomai.org</a>&gt;<br>
&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 On Wed, 2010-08-25 at 11:12 +0200, Bharath Achuta Bhat=
 wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; Hello Xenomai experts,<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I am running a xenomai-2.5.1 patched kernel (v 2.=
6.30.3)<br>
&gt; =A0 =A0 =A0 =A0 with ipipe<br>
&gt; =A0 =A0 =A0 =A0 &gt; version 2.7-06.<br>
&gt; =A0 =A0 =A0 =A0 &gt; The target is powerpc (MPC8533E).<br>
&gt; =A0 =A0 =A0 =A0 &gt; My application is switching to the secondary mode=
 (I guess<br>
&gt; =A0 =A0 =A0 =A0 because of<br>
&gt; =A0 =A0 =A0 =A0 &gt; a page-fault) when ntohl() is called.<br>
&gt; =A0 =A0 =A0 =A0 &gt; This is a libc function and I am wondering why on=
ly this<br>
&gt; =A0 =A0 =A0 =A0 function<br>
&gt; =A0 =A0 =A0 =A0 &gt; (ntohl()) is causing a page-fault.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 What memory are you reading from / writing to in the s=
tatement<br>
&gt; =A0 =A0 =A0 =A0 involving<br>
&gt; =A0 =A0 =A0 =A0 ntohl()? Is this plain RAM, or mapped I/O memory?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Here is how the application looks like<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; main ()<br>
&gt; =A0 =A0 =A0 =A0 &gt; {<br>
&gt; =A0 =A0 =A0 =A0 &gt; ...<br>
&gt; =A0 =A0 =A0 =A0 &gt; ...<br>
&gt; =A0 =A0 =A0 =A0 &gt; /* Avoids memory swapping for this program */<br>
&gt; =A0 =A0 =A0 =A0 &gt; mlockall(MCL_CURRENT | MCL_FUTURE);<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; ......<br>
&gt; =A0 =A0 =A0 =A0 &gt; ......<br>
&gt; =A0 =A0 =A0 =A0 &gt; /* signal handlers */<br>
&gt; =A0 =A0 =A0 =A0 &gt; .....<br>
&gt; =A0 =A0 =A0 =A0 &gt; .....<br>
&gt; =A0 =A0 =A0 =A0 &gt; /* create communication pipes */<br>
&gt; =A0 =A0 =A0 =A0 &gt; rt_pipe_create(&amp;tPipe1, .....<br>
&gt; =A0 =A0 =A0 =A0 &gt; rt_pipe_create(&amp;tPipe2,.......<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; /* create RT tasks */<br>
&gt; =A0 =A0 =A0 =A0 &gt; rt_task_create(&amp;tTask1,.....<br>
&gt; =A0 =A0 =A0 =A0 &gt; rt_task_create(&amp;tTask2,......<br>
&gt; =A0 =A0 =A0 =A0 &gt; ...........<br>
&gt; =A0 =A0 =A0 =A0 &gt; ..........<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; /* start the RT tasks */<br>
&gt; =A0 =A0 =A0 =A0 &gt; rt_task_start(&amp;tTask1,.....<br>
&gt; =A0 =A0 =A0 =A0 &gt; ..............<br>
&gt; =A0 =A0 =A0 =A0 &gt; ..............<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; /* turn the current thread into RT function */<br=
>
&gt; =A0 =A0 =A0 =A0 &gt; ret =3D rt_task_shadow(NULL, &quot;RT main functi=
on&quot;, 1, T_SUSP);<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; ....<br>
&gt; =A0 =A0 =A0 =A0 &gt; ....<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; }<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; One of the rt tasks created calls ntohl() and swi=
tches to<br>
&gt; =A0 =A0 =A0 =A0 secondary<br>
&gt; =A0 =A0 =A0 =A0 &gt; mode.<br>
&gt; =A0 =A0 =A0 =A0 &gt; Is there a way to avoid it ?<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; --<br>
&gt; =A0 =A0 =A0 =A0 &gt; Thanks and regards<br>
&gt; =A0 =A0 =A0 =A0 &gt; Bharath<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; _______________________________________________<b=
r>
&gt; =A0 =A0 =A0 =A0 &gt; Xenomai-help mailing list<br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-h=
elp@domain.hid</a><br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-=
help" target=3D"_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Philippe.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Thanks and regards<br>
&gt; Bharath<br>
&gt;<br>
<br>
</div></div>--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Thanks and regar=
ds<br>Bharath<br><br>
</div>

--0016367fb11fcb6545048eb4d5cc--

