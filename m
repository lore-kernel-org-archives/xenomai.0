Message-ID: <7289437c0705310833m40dcef0bt188a4b3e33f4c014@domain.hid>
Date: Thu, 31 May 2007 17:33:38 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465EE3BC.7020905@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16818_31829769.1180625618971"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465E8FA8.4030507@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
	<465EC7C1.5080300@domain.hid> <465ECDEC.1030109@domain.hid>
	<465ECFCA.1070801@domain.hid> <465ED806.2060608@domain.hid>
	<7289437c0705310758o3512e5e5x4c1a6d1df444be63@domain.hid>
	<465EE3BC.7020905@domain.hid>
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
To: xenomai-help <xenomai@xenomai.org>

------=_Part_16818_31829769.1180625618971
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried to put essai_mutex.c before the flags but it's the same thing.

It compiles with no problem, and after when I want to launch it on my board
I have the error about __real_sem_init.

I noticed that with cyclictest it's the same. When I want to launch the
application, I have the same error :
 can't resolve symbol '__real_sem_init'


On 5/31/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Perrine Martignoni wrote:
> >>Same program as you posted earlier?
> > Yes. it's the same.
> >
> >>Can you confirm the issue with this procedure? Also make sure that your
> >>rebuild and re-installed the Xenomai user space part cleanly ("make
> >>clean; make install").
> >
> > I installed cleanly Xenomai.
> >
> > I compiled too with :
> > arm-linux-gcc `.../xeno-config --posix-cflags --posix-ldflags` -o
> > essai_mutex_rt essai_mutex.c
>
> try putting essai_mutex.c before the flags, as in:
>
> arm-linux-gcc -o essai_mutex_rt essai_mutex.c `xeno-config
> --posix-cflags --posix-ldflags`
>
> --
>                                                 Gilles Chanteperdrix
>

------=_Part_16818_31829769.1180625618971
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I tried to put essai_mutex.c before the flags but it&#39;s the same thing.</div>
<div>&nbsp;</div>
<div>It compiles with no problem, and after when I want to launch it on my board I have the error about __real_sem_init.</div>
<div>&nbsp;</div>
<div>I noticed that with cyclictest it&#39;s the same. When&nbsp;I want to launch the application, I have the same error :&nbsp;</div>
<div>
<div><font face="courier new,monospace">can&#39;t resolve symbol &#39;__real_sem_init&#39;<br></font></div></div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/31/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt;&gt;Same program as you posted earlier?<br>&gt; Yes. it&#39;s the same.<br>
&gt;<br>&gt;&gt;Can you confirm the issue with this procedure? Also make sure that your<br>&gt;&gt;rebuild and re-installed the Xenomai user space part cleanly (&quot;make<br>&gt;&gt;clean; make install&quot;).<br>&gt;<br>
&gt; I installed cleanly Xenomai.<br>&gt;<br>&gt; I compiled too with :<br>&gt; arm-linux-gcc `.../xeno-config --posix-cflags --posix-ldflags` -o<br>&gt; essai_mutex_rt essai_mutex.c<br><br>try putting essai_mutex.c before the flags, as in:
<br><br>arm-linux-gcc -o essai_mutex_rt essai_mutex.c `xeno-config<br>--posix-cflags --posix-ldflags`<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_16818_31829769.1180625618971--

