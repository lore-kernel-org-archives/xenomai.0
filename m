MIME-Version: 1.0
In-Reply-To: <4A606C1A.9050800@domain.hid>
References: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid> 
	<4A299794.6010504@domain.hid>
	<6a782b880906101236l625792d5p6fcd3dad53e965a2@domain.hid> 
	<4A3010BE.9020107@domain.hid>
	<6a782b880907170418q6bd4fbe7p6fde0f0c6bae551c@domain.hid> 
	<4A606C1A.9050800@domain.hid>
From: Thiago Lima <thiagolims@domain.hid>
Date: Tue, 21 Jul 2009 18:46:54 +0000
Message-ID: <6a782b880907211146l438da963k2297955701bf20b2@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd6ae8cd97e3f046f3baea2
Subject: Re: [Xenomai-help] Get ready queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org, rpm@xenomai.org

--000e0cd6ae8cd97e3f046f3baea2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks for all suggestions and help.

Well, i have extended xenomai nucleus with some data (wcet, activation
period (latency)). Then, i have created system calls so that applications
can inform to system these parameters.

All tasks in the system should pass for schedulability test because we need
to ensure that real time processes worst case computation time will be
respected. So, i cannot create another scheduler class and, for this reason,
i have extended kernel threads. (i could not think another solution)

Indeed, i have applied a patch suggested by Philippe to catch user land
tasks whenever they start. As soon as possible, I will update to xenomai 2.5
core to test the module and an application.

There, now, 2 main questions:

1) I need to do some divisions in this module, but i could not use FPU in
kernel. How do you handle this in xenomai nucleus ? Are there some examples
of use in xenomai kernel code ?

2) I am not yet considering threads with same priority. (cause i know
xenomai uses RR or FIFO with them). How can i get list of threads with an
specific priority ? Is there some example (reference) in xenomai kernel
code?


Thanks for help,

Thiago.


On Fri, Jul 17, 2009 at 12:18 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Thiago Lima wrote:
> > I am doing an schedulability test of real time processes in Xenomai.
> (...)
> > My question is: how can i get all ready xenomai tasks ? Because i need
> > to get the amount of threads to do this test.
> >
> > Sorry for my last email. I have not so much time to write and it was
> vague.
>
> I do not think you can do this schedulability test in general, you need
> some additional data for each task, such as activation period and WCET,
> so, what you should do is use Xenomai 2.5 and create your own scheduler
> classes, and keep the list of tasks using these classes, presumably in
> the per-class data. Then you would do the schedulatbility test only for
> tasks in these classes.
>
> --
>                                           Gilles
>
>

--000e0cd6ae8cd97e3f046f3baea2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for all suggestions and help.<br><br>Well, i have extended xenomai n=
ucleus with some data (wcet, activation period (latency)). Then, i have cre=
ated system calls so that applications can inform to system these parameter=
s.<br>

<br>All tasks in the system should pass for schedulability test because we =
need to ensure that real time processes worst case computation time will be=
 respected. So, i cannot create another scheduler class and, for this reaso=
n, i have extended kernel threads. (i could not think another solution)<br>

<br>Indeed, i have applied a patch suggested by Philippe to catch user land=
 tasks whenever they start. As soon as possible, I will update to xenomai 2=
.5 core to test the module and an application.<br><br>There, now, 2 main qu=
estions:<br>

<br>1) I need to do some divisions in this module, but i could not use FPU =
in kernel. How do you handle this in xenomai nucleus ? Are there some examp=
les of use in xenomai kernel code ?<br><br>2) I am not yet considering thre=
ads with same priority. (cause i know xenomai uses RR or FIFO with them). H=
ow can i get list of threads with an specific priority ? Is there some exam=
ple (reference) in xenomai kernel code?<br>

<br><br>Thanks for help,<br><br>Thiago.<br><br><br><div class=3D"gmail_quot=
e">On Fri, Jul 17, 2009 at 12:18 PM, Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Thiago Lima wrote=
:<br>
&gt; I am doing an schedulability test of real time processes in Xenomai. (=
...)<br>
<div class=3D"im">&gt; My question is: how can i get all ready xenomai task=
s ? Because i need<br>
&gt; to get the amount of threads to do this test.<br>
&gt;<br>
&gt; Sorry for my last email. I have not so much time to write and it was v=
ague.<br>
<br>
</div>I do not think you can do this schedulability test in general, you ne=
ed<br>
some additional data for each task, such as activation period and WCET,<br>
so, what you should do is use Xenomai 2.5 and create your own scheduler<br>
classes, and keep the list of tasks using these classes, presumably in<br>
the per-class data. Then you would do the schedulatbility test only for<br>
tasks in these classes.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles<br>
<br>
</font></blockquote></div><br><br>

--000e0cd6ae8cd97e3f046f3baea2--

