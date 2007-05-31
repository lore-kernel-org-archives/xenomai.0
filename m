Message-ID: <7289437c0705310645w5e8bf8dfg6ed75d777d5b5ed9@domain.hid>
Date: Thu, 31 May 2007 15:45:14 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465ECFCA.1070801@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15118_2133780.1180619114780"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
	<465D664E.3040700@domain.hid> <465E8FA8.4030507@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
	<465EC7C1.5080300@domain.hid> <465ECDEC.1030109@domain.hid>
	<465ECFCA.1070801@domain.hid>
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

------=_Part_15118_2133780.1180619114780
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All compile fine.
But now I have a problem when I launch my application on my board :

can't resolve symbol '__real_sem_init'
I don't see the reason.


On 5/31/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Wolfgang Grandegger wrote:
> > Jan Kiszka wrote:
> >> Perrine Martignoni wrote:
> >>>> Perrine, did you happen to configure Xenomai with "configure
> --host=arm
> >>>> ..."? If yes (see config.log), please use "--host=arm-linux". This
> >>>> solved all issues for me.
> >>>>
> >>>> Awaiting your feedback!
> >>> I configure Xenomai with --host=arm.
> >>> I tried to configure like this but it doesn't work :
> >>>
> >>> ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc
> >>                       ^^^^^^^^^
> >> I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
> >> Try --build=i686-linux here.
> >
> > Or just omit it. Also CC=, CXX=, LD= ist not necessary. For PowerPC with
> > the ELDK, I just use
> >
> >   ./configure --host=ppc-linux
> >
> > to configure Xenomai.
>
> Can we define a common ground for this in README.INSTALL, for all archs?
> The simpler, the better.
>
> I was heavily misled by the PPC section, because I do not cross-compile
> everyday, thus had to look up the procedure again and managed to pick
> the bad example...
>
> Jan
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
>

------=_Part_15118_2133780.1180619114780
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>All compile fine.</div>
<div>But now I have a problem when I launch my application on my board : </div>
<div>&nbsp;</div>
<div><font face="courier new,monospace">can&#39;t resolve symbol &#39;__real_sem_init&#39;<br></font></div>
<div>I don&#39;t see the reason.<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/31/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Wolfgang Grandegger wrote:<br>&gt; Jan Kiszka wrote:<br>&gt;&gt; Perrine Martignoni wrote:<br>&gt;&gt;&gt;&gt; Perrine, did you happen to configure Xenomai with &quot;configure --host=arm
<br>&gt;&gt;&gt;&gt; ...&quot;? If yes (see config.log), please use &quot;--host=arm-linux&quot;. This<br>&gt;&gt;&gt;&gt; solved all issues for me.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Awaiting your feedback!<br>&gt;&gt;&gt; I configure Xenomai with --host=arm.
<br>&gt;&gt;&gt; I tried to configure like this but it doesn&#39;t work :<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^<br>&gt;&gt; I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
<br>&gt;&gt; Try --build=i686-linux here.<br>&gt;<br>&gt; Or just omit it. Also CC=, CXX=, LD= ist not necessary. For PowerPC with<br>&gt; the ELDK, I just use<br>&gt;<br>&gt;&nbsp;&nbsp; ./configure --host=ppc-linux<br>&gt;<br>&gt; to configure Xenomai.
<br><br>Can we define a common ground for this in README.INSTALL, for all archs?<br>The simpler, the better.<br><br>I was heavily misled by the PPC section, because I do not cross-compile<br>everyday, thus had to look up the procedure again and managed to pick
<br>the bad example...<br><br>Jan<br><br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help">
https://mail.gna.org/listinfo/xenomai-help</a><br><br><br></blockquote></div><br>

------=_Part_15118_2133780.1180619114780--

