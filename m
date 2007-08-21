Message-ID: <8b3b30860708210039n1e8d9eaaxe5d9f933cea816fc@domain.hid>
Date: Tue, 21 Aug 2007 09:39:22 +0200
From: "Racconico Lambrati" <racconico.lambrati@domain.hid>
In-Reply-To: <18121.36630.239612.20521@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_102161_9131762.1187681962764"
References: <8b3b30860708192302s906f0e0nfbb5ce9152ac8d@domain.hid>
	<18121.36630.239612.20521@domain.hid>
Subject: Re: [Xenomai-help] old version's bug
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

------=_Part_102161_9131762.1187681962764
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Because I'm having some problem with the compilation for a xenomai's kernel
(why don't you create a .conf for a standard kernel, or make a live distro
with xen?) I have take the decision to port my program under native API.

I'm searching without succes the corrisponding for these vxworks function.

intLock, intUnLock, sysClkConnect and tickGet

thanks for the help

Racconico

2007/8/20, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> Racconico Lambrati wrote:
> > Hi all.
> >
> > I'm working with fusion 0.9.1 but now I found a bug... in vxworks skin,
> when
> > I spawn a task from another task all system crushes.
> >
> > I want to know if in xenomai this problem was resolved or I must trash
> my
> > old program and rewrite it under the native api...
> >
> > thanks, Racconico
>
> Try a more recent Xenomai release, if you still observe the bug, we will
> try and find a fix.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_102161_9131762.1187681962764
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Because I&#39;m having some problem with the compilation for a xenomai&#39;s
kernel (why don&#39;t you create a .conf for a standard kernel, or make a
live distro with xen?) I have take the decision to port my program
under native API.<br>

<br>

I&#39;m searching without succes the corrisponding for these vxworks function.<br>

<br>

intLock, intUnLock, sysClkConnect and tickGet<br>

<br>

thanks for the help<br>

<br>

Racconico<br><br><div><span class="gmail_quote">2007/8/20, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Racconico Lambrati wrote:<br> &gt; Hi all.<br> &gt;<br> &gt; I&#39;m working with fusion 0.9.1 but now I found a bug... in vxworks skin, when<br> &gt; I spawn a task from another task all system crushes.<br> &gt;<br> &gt; I want to know if in xenomai this problem was resolved or I must trash my
<br> &gt; old program and rewrite it under the native api...<br> &gt;<br> &gt; thanks, Racconico<br><br>Try a more recent Xenomai release, if you still observe the bug, we will<br>try and find a fix.<br><br>--<br><br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles
Chanteperdrix.<br></blockquote></div><br>

------=_Part_102161_9131762.1187681962764--

