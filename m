MIME-Version: 1.0
In-Reply-To: <49814ED3.9080607@domain.hid>
References: <ba9b368a0901282227i705ebe80oe75782ccc5cdc17f@domain.hid>
	<49814ED3.9080607@domain.hid>
Date: Thu, 29 Jan 2009 15:46:06 +0900
Message-ID: <ba9b368a0901282246t4bece718g5b8512220e961719@domain.hid>
From: Daniel Adams <dadams81@domain.hid>
Content-Type: multipart/alternative; boundary=0016e651fa9a5b7080046199717f
Subject: Re: [Xenomai-help] Problem using sem_open and rt_sem_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016e651fa9a5b7080046199717f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks Gillies,

Is it possible to use the rt_sem_bind from a linux process that hasn't been
shadowed using rt_task_shadow?
Is this the same for named pipes created using the native skin and accessing
them from a posix interface?

What is the recommended IPC to talk between posix threads and native rt
threads?

Thanks again for your help.


On Thu, Jan 29, 2009 at 3:38 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Daniel Adams wrote:
> > Hi *,
> >
> > I'm fairly new to Xenomai and am having a few issues and was wondering if
> > anyone could provide me with help
> >
> > I have written some code to create a process which waits on a named
> > semaphore and then there is another process which posts to it. I
> originally
> > developed the code using the posix interface under a standard Linux
> > environment and have proved it works.
> > I have since ported the code so that the waiting half creates and waits
> on
> > the semaphore using the native skin and the posting half uses the posix
> > skin.
> >
> > I tried naming the semaphore using the leading '/' as the posix standard
> > suggests, but found that using the '/' causes the rt_sem_create(&rt_sem,
> > SEM_NAME, 0, S_PULSE)  to return EINVAL. Removing the '/' allows the
> > semaphore to be created but now when I try to open the semaphore
> > with sem_open(SEM_NAME, O_EXCL), I get an error that the file doesn't
> exist.
> > Is there something that I'm missing? I've check the registry and the
> > semaphore appears under /proc/xenomai/registry/native/semaphores/.
>
> The objects created by the two skins are completely separate.
>
> --
>                                             Gilles.
>

--0016e651fa9a5b7080046199717f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Gillies,<br><br>Is it possible to use the rt_sem_bind from a linux p=
rocess that hasn&#39;t been shadowed using rt_task_shadow?<br>Is this the s=
ame for named pipes created using the native skin and accessing them from a=
 posix interface?<br>
<br>What is the recommended IPC to talk between posix threads and native rt=
 threads?<br><br>Thanks again for your help.<br><br><br><div class=3D"gmail=
_quote">On Thu, Jan 29, 2009 at 3:38 PM, Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"Wj3C7c">Daniel Adams wrote:<br>
&gt; Hi *,<br>
&gt;<br>
&gt; I&#39;m fairly new to Xenomai and am having a few issues and was wonde=
ring if<br>
&gt; anyone could provide me with help<br>
&gt;<br>
&gt; I have written some code to create a process which waits on a named<br=
>
&gt; semaphore and then there is another process which posts to it. I origi=
nally<br>
&gt; developed the code using the posix interface under a standard Linux<br=
>
&gt; environment and have proved it works.<br>
&gt; I have since ported the code so that the waiting half creates and wait=
s on<br>
&gt; the semaphore using the native skin and the posting half uses the posi=
x<br>
&gt; skin.<br>
&gt;<br>
&gt; I tried naming the semaphore using the leading &#39;/&#39; as the posi=
x standard<br>
&gt; suggests, but found that using the &#39;/&#39; causes the rt_sem_creat=
e(&amp;rt_sem,<br>
&gt; SEM_NAME, 0, S_PULSE) &nbsp;to return EINVAL. Removing the &#39;/&#39;=
 allows the<br>
&gt; semaphore to be created but now when I try to open the semaphore<br>
&gt; with sem_open(SEM_NAME, O_EXCL), I get an error that the file doesn&#3=
9;t exist.<br>
&gt; Is there something that I&#39;m missing? I&#39;ve check the registry a=
nd the<br>
&gt; semaphore appears under /proc/xenomai/registry/native/semaphores/.<br>
<br>
</div></div>The objects created by the two skins are completely separate.<b=
r>
<br>
--<br>
<font color=3D"#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br>

--0016e651fa9a5b7080046199717f--

