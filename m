Message-ID: <d3623eab0801111433h3022dc10x432fff85229e67cc@domain.hid>
Date: Fri, 11 Jan 2008 17:33:34 -0500
From: "Jerome Pasquero" <jay@domain.hid>
Sender: jerome.pasquero@domain.hid
In-Reply-To: <4787B3DB.5010507@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3428_12071761.1200090814759"
References: <d3623eab0801110744y63764ba2sb122db96a85bde80@domain.hid>
	<d3623eab0801110806y75b51c1kc31efe7d357de522@domain.hid>
	<4787B3DB.5010507@domain.hid>
Subject: Re: [Xenomai-help] cannot make system() calls anymore
Reply-To: jay@domain.hid
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

------=_Part_3428_12071761.1200090814759
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Jan 11, 2008 1:22 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Jerome Pasquero wrote:
> > Hi,
> >
> > I recently upgraded from xenomai 2.3.0 under linux 2.6.17.14 to the
> latest
> > stable version of xenomai 2.4.1 under linux 2.6.23.12.
> > Everything seems to be working just fine, except that I seem to  no
> longer
> > be able to make system calls inside a real-time task. It simply freezes
> > everything and I need to restart my computer.
> > I don't know if it was just a fluke that it was working with 2.3.0 and
> that
> > I am not supposed to do that at all. Could it be that I forgot to
> include an
> > option when recompiling the kernel?
>
> A system freeze is not a valid reaction of Xenomai on invalid user
> activity - unless that freeze just means one of your high-prio tasks
> decided to enter an endless loop. Have you already tried to enable the
> Xenomai watchdog?
>

No, I haven't tried to enable the watchdog. I'll try to take a look at that=
.


>
> >
> > Note that I have no problem making system calls from outside a real tim=
e
> > task (for instance, right before a rt_task_shadow() call).
> > Also, it seems that the problem only occurs when other libraries are
> used.
> > For instance, if one compiles the code below with no other libraries
> than
> > the xenomai libs (and stdc++), it works just fine:
> > gcc  `/usr/xenomai/bin/xeno-config --xeno-cflags`
> > `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative main.cp=
p
> >
> > However, as soon as I add the libxml2 library, it crashes:
> > gcc  -D_GNU_SOURCE -D_REENTRANT -D__XENO__  -I/usr/include/libxml2
> > -I/usr/xenomai-2.4.1/include  -L/usr/local/lib -L/usr/xenomai-2.4.1/lib
> > -lxml2 -lnative -lpthread `/usr/xenomai/bin/xeno-config --xeno-cflags`
> > `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative main.cp
> >
> > This is true with other libraries as well (e.g. gsl lib) but not of all
> > libraries (for instance, it seems to work with the math library i.e.
> -lm)
> >
> > Am I doing something wrong?
> > In case you were wondering, I want to be able to make system calls from
> > inside real time threads cause I want to load/unload realtime modules
> > directly from my application. In the code snippet below, I am simply
> trying
> > to do a  'ls'  command to keep it as simple as possible.
>
> Thanks for the demo. This one already bricks your box? But only when
> linked against libxml?
>
That's exactly it. I tried to reduce the problem to a very simple case. Not=
e
that it also bricks my box when I link it to other libraries but not to all
libraries (e.g. it works with the math library but not with the gsl).



>
> >
> > Thanks for your help in advance.
> >
> >
> > #include <iostream>
> > #include <sys/mman.h>
> > #include <signal.h>
> > #include <native/mutex.h>
> > #include <native/timer.h>
> > #include <native/task.h>
> >
> > void cleanup(int unused)
> > {
> >     // delete current task
> >     rt_task_delete(NULL);
> > }
> >
> > int main(int argc, char *argv[])
> > {
> >     signal(SIGABRT, cleanup);
> >     signal(SIGKILL, cleanup);
> >     signal(SIGINT, cleanup);
> >     signal(SIGTERM, cleanup);
> >     signal(SIGHUP, cleanup);
> >     signal(SIGALRM, cleanup);
> >
> >
> >     RT_TASK mainTask;
> >
> >     mlockall(MCL_CURRENT | MCL_FUTURE);
> >     rt_task_shadow(&mainTask, "gui", 50, T_FPU);
> >
> >     rt_task_sleep((RTIME) 1E9);
> >
> >     system("ls"); // this is what causes the problem...
>
> Ah, you mean "system" with system call - or actually any call of
> Standard-Linux kernel services?


I mean any call with the function system() made directly from the realtime
task. If I open a shell and make a system call, everything seems to work
fine.


>
>
> In any case, let's first check for runaway threads with the watchdog.


>
> Jan
>
>


--=20
Jerome Pasquero
Ph.D. Student
McGill University
Haptics Lab
3480 University Street Room 410
Montr=E9al, Qu=E9bec, Canada
H3A 2A7
T: (514) 398-8206
F: (514) 398-7348
www.cim.mcgill.ca/~jay

------=_Part_3428_12071761.1200090814759
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div class=3D"gmail_quote">On Jan 11, 2008 1:22 PM, Jan Kiszka &lt;=
<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"Ih2E3d">Jerome Pasquero wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I =
recently upgraded from xenomai 2.3.0 under linux <a href=3D"http://2.6.17.1=
4" target=3D"_blank">2.6.17.14</a> to the latest<br>&gt; stable version of =
xenomai=20
2.4.1 under linux <a href=3D"http://2.6.23.12" target=3D"_blank">2.6.23.12<=
/a>.<br>&gt; Everything seems to be working just fine, except that I seem t=
o &nbsp;no longer<br>&gt; be able to make system calls inside a real-time t=
ask. It simply freezes
<br>&gt; everything and I need to restart my computer.<br>&gt; I don&#39;t =
know if it was just a fluke that it was working with 2.3.0 and that<br>&gt;=
 I am not supposed to do that at all. Could it be that I forgot to include =
an
<br>&gt; option when recompiling the kernel?<br><br></div>A system freeze i=
s not a valid reaction of Xenomai on invalid user<br>activity - unless that=
 freeze just means one of your high-prio tasks<br>decided to enter an endle=
ss loop. Have you already tried to enable the
<br>Xenomai watchdog?<br><div class=3D"Ih2E3d"></div></blockquote><div><br>=
No, I haven&#39;t tried to enable the watchdog. I&#39;ll try to take a look=
 at that.<br>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
<div class=3D"Ih2E3d"><br>&gt;<br>&gt; Note that I have no problem making s=
ystem calls from outside a real time<br>&gt; task (for instance, right befo=
re a rt_task_shadow() call).<br>&gt; Also, it seems that the problem only o=
ccurs when other libraries are used.
<br>&gt; For instance, if one compiles the code below with no other librari=
es than<br>&gt; the xenomai libs (and stdc++), it works just fine:<br>&gt; =
gcc &nbsp;`/usr/xenomai/bin/xeno-config --xeno-cflags`<br>&gt; `/usr/xenoma=
i/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative=20
main.cpp<br>&gt;<br>&gt; However, as soon as I add the libxml2 library, it =
crashes:<br>&gt; gcc &nbsp;-D_GNU_SOURCE -D_REENTRANT -D__XENO__ &nbsp;-I/u=
sr/include/libxml2<br>&gt; -I/usr/xenomai-2.4.1/include &nbsp;-L/usr/local/=
lib -L/usr/xenomai-
2.4.1/lib<br>&gt; -lxml2 -lnative -lpthread `/usr/xenomai/bin/xeno-config -=
-xeno-cflags`<br>&gt; `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc+=
+ -lnative main.cp<br>&gt;<br>&gt; This is true with other libraries as wel=
l (
e.g. gsl lib) but not of all<br>&gt; libraries (for instance, it seems to w=
ork with the math library i.e. -lm)<br>&gt;<br>&gt; Am I doing something wr=
ong?<br>&gt; In case you were wondering, I want to be able to make system c=
alls from
<br>&gt; inside real time threads cause I want to load/unload realtime modu=
les<br>&gt; directly from my application. In the code snippet below, I am s=
imply trying<br>&gt; to do a &nbsp;&#39;ls&#39; &nbsp;command to keep it as=
 simple as possible.
<br><br></div>Thanks for the demo. This one already bricks your box? But on=
ly when<br>linked against libxml?<br><div class=3D"Ih2E3d"></div></blockquo=
te><div>That&#39;s exactly it. I tried to reduce the problem to a very simp=
le case. Note that it also bricks my box when I link it to other libraries =
but not to all libraries (
e.g. it works with the math library but not with the gsl).<br><br>&nbsp;</d=
iv><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(20=
4, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"=
Ih2E3d">
<br>&gt;<br>&gt; Thanks for your help in advance.<br>&gt;<br>&gt;<br>&gt; #=
include &lt;iostream&gt;<br>&gt; #include &lt;sys/mman.h&gt;<br>&gt; #inclu=
de &lt;signal.h&gt;<br>&gt; #include &lt;native/mutex.h&gt;<br>&gt; #includ=
e &lt;native/timer.h&gt;
<br>&gt; #include &lt;native/task.h&gt;<br>&gt;<br>&gt; void cleanup(int un=
used)<br>&gt; {<br>&gt; &nbsp; &nbsp; // delete current task<br>&gt; &nbsp;=
 &nbsp; rt_task_delete(NULL);<br>&gt; }<br>&gt;<br>&gt; int main(int argc, =
char *argv[])<br>
&gt; {<br>&gt; &nbsp; &nbsp; signal(SIGABRT, cleanup);<br>&gt; &nbsp; &nbsp=
; signal(SIGKILL, cleanup);<br>&gt; &nbsp; &nbsp; signal(SIGINT, cleanup);<=
br>&gt; &nbsp; &nbsp; signal(SIGTERM, cleanup);<br>&gt; &nbsp; &nbsp; signa=
l(SIGHUP, cleanup);<br>&gt; &nbsp; &nbsp; signal(SIGALRM, cleanup);
<br>&gt;<br>&gt;<br>&gt; &nbsp; &nbsp; RT_TASK mainTask;<br>&gt;<br>&gt; &n=
bsp; &nbsp; mlockall(MCL_CURRENT | MCL_FUTURE);<br>&gt; &nbsp; &nbsp; rt_ta=
sk_shadow(&amp;mainTask, &quot;gui&quot;, 50, T_FPU);<br>&gt;<br>&gt; &nbsp=
; &nbsp; rt_task_sleep((RTIME) 1E9);
<br>&gt;<br>&gt; &nbsp; &nbsp; system(&quot;ls&quot;); // this is what caus=
es the problem...<br><br></div>Ah, you mean &quot;system&quot; with system =
call - or actually any call of<br>Standard-Linux kernel services?</blockquo=
te><div>
<br>I mean any call with the function system() made directly from the realt=
ime task. If I open a shell and make a system call, everything seems to wor=
k fine.<br>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<br><br>In any case, let&#39;s first check for runaway threads with the wat=
chdog.</blockquote><blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">
<br><font color=3D"#888888"><br>Jan<br><br></font></blockquote></div><br><b=
r clear=3D"all"><br>-- <br>Jerome Pasquero<br>Ph.D. Student<br>McGill Unive=
rsity<br>Haptics Lab<br>3480 University Street Room 410<br>Montr=E9al, Qu=
=E9bec, Canada
<br>H3A 2A7<br>T: (514) 398-8206<br>F: (514) 398-7348<br><a href=3D"http://=
www.cim.mcgill.ca/~jay">www.cim.mcgill.ca/~jay</a>

------=_Part_3428_12071761.1200090814759--

