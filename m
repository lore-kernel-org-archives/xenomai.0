Message-ID: <7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
Date: Tue, 29 May 2007 10:30:03 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <1180360288.4727.50.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_130083_10899802.1180427403634"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465ADB44.2070705@domain.hid> <1180360288.4727.50.camel@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_130083_10899802.1180427403634
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I applied the patch xeno-2.3-posix-shm.diff and the installation of Xenomai
works fine.
Thanks

But after when I want to compile an application (who works with glibc), I
have this error :


/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
`__wrap_mmap'

/usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference
to`__wrap_close'

/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
`__wrap_munmap'

collect2: ld returned 1 exit status

This error appears with any example of code.



On 5/28/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Mon, 2007-05-28 at 15:38 +0200, Gilles Chanteperdrix wrote:
> > Fillod Stephane wrote:
> > > You may also need this patch:
> > >
> > > --- skins/native/task.c 20 Mar 2007 08:16:41 -0000      1.1.1.1
> > > +++ skins/native/task.c 28 Mar 2007 13:53:03 -0000      1.2
> > > @@ -135,7 +135,12 @@
> > >         pthread_attr_setstacksize(&thattr, stksize);
> > >         if (!(mode & T_JOINABLE))
> > >                 pthread_attr_setdetachstate(&thattr,
> PTHREAD_CREATE_DETACHED);
> > > -       if (prio > 0) {
> > > +       /* There's a limitation in libpthread
> > > +        * that returns EPERM upon SCHED_FIFO
> > > +        * for non priviledged users.
> > > +        * So workaround this for now. FIXME (in uClibc/pthread).
> > > +        */
> > > +       if (prio > 0 && geteuid() == 0) {
> > >                 pthread_attr_setschedpolicy(&thattr, SCHED_FIFO);
> > >                 param.sched_priority =
> sched_get_priority_max(SCHED_FIFO);
> > >         }
> >
> > I do not think it is a good idea, I prefer rt_task_create to fail loudly
> > because it needs root priviledge, rather than silently creating a non
> > real-time thread.
> >
>
> Agreed.
>
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_130083_10899802.1180427403634
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I applied the patch xeno-2.3-posix-shm.diff and the installation of Xenomai works fine.</div>
<div>Thanks</div>
<div>&nbsp;</div>
<div>But after when I want to compile an application (who works with glibc), I have this error : </div>
<div>&nbsp;</div>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face="Times New Roman">/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to `__wrap_mmap&#39;
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face="Times New Roman">/usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference to`__wrap_close&#39;
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face="Times New Roman">/usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to `__wrap_munmap&#39;
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face="Times New Roman">collect2: ld returned 1 exit status</font></span></p>
<p>This error appears with any example of code.</p>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/28/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Mon, 2007-05-28 at 15:38 +0200, Gilles Chanteperdrix wrote:<br>&gt; Fillod Stephane wrote:<br>&gt; &gt; You may also need this patch:
<br>&gt; &gt;<br>&gt; &gt; --- skins/native/task.c 20 Mar 2007 08:16:41 -0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://1.1.1.1">1.1.1.1</a><br>&gt; &gt; +++ skins/native/task.c 28 Mar 2007 13:53:03 -0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.2<br>&gt; &gt; @@ -135,7 +135,12 @@
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setstacksize(&amp;thattr, stksize);<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(mode &amp; T_JOINABLE))<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setdetachstate(&amp;thattr, PTHREAD_CREATE_DETACHED);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prio &gt; 0) {<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* There&#39;s a limitation in libpthread<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* that returns EPERM upon SCHED_FIFO<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* for non priviledged users.<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* So workaround this for now. FIXME (in uClibc/pthread).
<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prio &gt; 0 &amp;&amp; geteuid() == 0) {<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setschedpolicy(&amp;thattr, SCHED_FIFO);<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; param.sched_priority
 = sched_get_priority_max(SCHED_FIFO);<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt; I do not think it is a good idea, I prefer rt_task_create to fail loudly<br>&gt; because it needs root priviledge, rather than silently creating a non
<br>&gt; real-time thread.<br>&gt;<br><br>Agreed.<br><br>--<br>Philippe.<br><br><br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid
</a><br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br></blockquote></div><br>

------=_Part_130083_10899802.1180427403634--

