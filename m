MIME-Version: 1.0
In-Reply-To: <AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
	<4C1B7EB1.2040006@domain.hid>
	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
Date: Fri, 18 Jun 2010 20:29:09 +0530
Message-ID: <AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/alternative; boundary=0016364267577998db04894f32da
Subject: [Xenomai-core] Fwd:  problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0016364267577998db04894f32da
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jun 18, 2010 at 7:42 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Nero Fernandez wrote:
> > Hi,
> >
> > Please find an archive attached, containing :
> >  - a program for testing context-switch-latency using posix-APIs
> >    for native linux kernel and xenomai-posix-skin (userspace).
> >  - Makefile to build it using xenomai
>
> Your program is very long to tell fast. But it seems you are using the
> mutex as if they were recursive. Xenomai posix skin mutexes used to be
> recursive by default, but no longer are.
>
> Also note that your code does not check the return value of the posix
> skin services, which is a really bad idea.
>
> --
>                                             Gilles.
>

Thanks for the prompt response.

Could you explain  'recursive usage of mutex' a little further?
Are the xenomai pthread-mutexes very different in behaviour than regular
posix mutexes?

The major portions of the code are the following three methods:
 - main()
      creates resource, spawns and collects pthreads
 - rt_task_master()
      calibrates the dry-run time, controls the mutex-passing and
      reports the final timing. Measuring scheme is similar to lmbench
 - rt_task_slave()
      task for passing the mutex lock()-unlock() chain over.

The program allocates same number of mutexes as the number of processes,
so ideally only one thread would be active and each would its read and write

locks in the following fashion:
 - unlock and lock , in case of master
 - lock and unlock, in case of slave

--0016364267577998db04894f32da
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><div><div class=3D"h5"><div class=3D"gmail_q=
uote">On Fri, Jun 18, 2010 at 7:42 PM, Gilles Chanteperdrix <span dir=3D"lt=
r">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank=
">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Nero Fernandez wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Please find an archive attached, containing :<br>
&gt; =A0- a program for testing context-switch-latency using posix-APIs<br>
&gt; =A0 =A0for native linux kernel and xenomai-posix-skin (userspace).<br>
&gt; =A0- Makefile to build it using xenomai<br>
<br>
</div>Your program is very long to tell fast. But it seems you are using th=
e<br>
mutex as if they were recursive. Xenomai posix skin mutexes used to be<br>
recursive by default, but no longer are.<br>
<br>
Also note that your code does not check the return value of the posix<br>
skin services, which is a really bad idea.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div></div></div><span style=3D"font-family: courier n=
ew,monospace;"><br>Thanks for the prompt response.</span><br style=3D"font-=
family: courier new,monospace;"><br style=3D"font-family: courier new,monos=
pace;">
<span style=3D"font-family: courier new,monospace;">Could you explain=A0 &#=
39;recursive usage of mutex&#39; a little further?</span><br style=3D"font-=
family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">Are the xenomai pthread=
-mutexes very different in behaviour than regular posix mutexes?</span><br>=
<font face=3D"courier new,monospace"></font><br style=3D"font-family: couri=
er new,monospace;">

<span style=3D"font-family: courier new,monospace;">The major portions of t=
he code are the following three methods:</span><br style=3D"font-family: co=
urier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
=A0- main()</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0 creates=
 resource, spawns and collects pthreads</span><br style=3D"font-family: cou=
rier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
=A0- rt_task_master()</span><br style=3D"font-family: courier new,monospace=
;">

<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0 calibra=
tes the dry-run time, controls the mutex-passing and <br>=A0=A0=A0=A0=A0 re=
ports the final timing</span>. <span style=3D"font-family: courier new,mono=
space;">Measuring scheme is similar to lmbench</span><br style=3D"font-fami=
ly: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">=A0- rt_task_slave()</s=
pan><br style=3D"font-family: courier new,monospace;"><span style=3D"font-f=
amily: courier new,monospace;">=A0=A0=A0=A0=A0 task for passing the mutex l=
ock()-unlock() chain over.</span><br style=3D"font-family: courier new,mono=
space;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">The program allocates same number of mutexes as =
the number of processes,</span><br style=3D"font-family: courier new,monosp=
ace;">

<span style=3D"font-family: courier new,monospace;">so ideally only one thr=
ead would be active and each would its read and write </span><br style=3D"f=
ont-family: courier new,monospace;"><span style=3D"font-family: courier new=
,monospace;">locks in the following fashion:</span><br style=3D"font-family=
: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">=A0- unlock and lock , =
in case of master</span><br style=3D"font-family: courier new,monospace;"><=
span style=3D"font-family: courier new,monospace;">=A0- lock and unlock, in=
 case of slave </span><br style=3D"font-family: courier new,monospace;">

<br>
</div><br>

--0016364267577998db04894f32da--

