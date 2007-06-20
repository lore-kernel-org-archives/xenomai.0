Message-ID: <f48df4840706201516t46de8c46ga048f576be5550ca@domain.hid>
Date: Thu, 21 Jun 2007 00:16:38 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
In-Reply-To: <46793E22.7070107@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_116846_32833319.1182377798664"
References: <op.tt74pfqvt06gyn@domain.hid> <1182349939.6137.2.camel@domain.hid>
	<46793E22.7070107@domain.hid>
Subject: Re: [Xenomai-help] Status Codes in /proc/xenomai/sched
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
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

------=_Part_116846_32833319.1182377798664
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/6/20, Jan Kiszka <jan.kiszka@domain.hid>:
>
> Philippe Gerum wrote:
> > On Wed, 2007-06-20 at 16:18 +0200, Axel Beierlein wrote:
> >> Hello,
> >>
> >> Where can i find the meaning of the status code at the column STAT
> >> in /proc/xenomai/sched ? I am a little bit confused of the Status UX.
> >>
> >
> > include/nucleus/thread.h for now, until this eventually gets more
> > formally documented:
> >
> >   'S' -> Forcibly suspended.
> >   'w'/'W' -> Waiting for a resource, with or without timeout.
> >   'D' -> Delayed (without any other wait condition).
> >   'R' -> Runnable.
> >   'U' -> Unstarted or dormant.
> >   'X' -> Relaxed shadow.
> >   'H' -> Held thread.
> >   'b' -> Priority boost undergoing.
> >   'T' -> Ptraced and stopped.
> >   'l' -> Locks scheduler.
> >   'r' -> Undergoes round-robin.
> >   's' -> Interrupt shield enabled.
> >   't' -> Mode switches trapped.
> >   'o' -> Priority coupling off.
> >   'f' -> FPU enabled (for kernel threads).
> >
>
> Well, I thought to remember some related stuff in the wiki. What I find
> is /proc/xenomai/stat, and that is broken here:
>
> http://www.xenomai.org/index.php/FAQs ->
> http://www.xenomai.org/index.php//proc/xenomai/stat


This page looks like it's never been created/edited...

Bruno, could you have a look if you can recover the content -- and
> likely rename it then? Slashes don't appear to be a smart choice in wiki
> page names...


I don't find any content in the database although the entry
/proc/xenomai/stat exist.

I never to do some more research. I keep you informed...

Jan
>
>
>
--Bruno

------=_Part_116846_32833319.1182377798664
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/6/20, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Philippe Gerum wrote:<br>&gt; On Wed, 2007-06-20 at 16:18 +0200, Axel Beierlein wrote:<br>&gt;&gt; Hello,<br>&gt;&gt;<br>&gt;&gt; Where can i find the meaning of the status code at the column STAT<br>&gt;&gt; in /proc/xenomai/sched ? I am a little bit confused of the Status UX.
<br>&gt;&gt;<br>&gt;<br>&gt; include/nucleus/thread.h for now, until this eventually gets more<br>&gt; formally documented:<br>&gt;<br>&gt;&nbsp;&nbsp; &#39;S&#39; -&gt; Forcibly suspended.<br>&gt;&nbsp;&nbsp; &#39;w&#39;/&#39;W&#39; -&gt; Waiting for a resource, with or without timeout.
<br>&gt;&nbsp;&nbsp; &#39;D&#39; -&gt; Delayed (without any other wait condition).<br>&gt;&nbsp;&nbsp; &#39;R&#39; -&gt; Runnable.<br>&gt;&nbsp;&nbsp; &#39;U&#39; -&gt; Unstarted or dormant.<br>&gt;&nbsp;&nbsp; &#39;X&#39; -&gt; Relaxed shadow.<br>&gt;&nbsp;&nbsp; &#39;H&#39; -&gt; Held thread.
<br>&gt;&nbsp;&nbsp; &#39;b&#39; -&gt; Priority boost undergoing.<br>&gt;&nbsp;&nbsp; &#39;T&#39; -&gt; Ptraced and stopped.<br>&gt;&nbsp;&nbsp; &#39;l&#39; -&gt; Locks scheduler.<br>&gt;&nbsp;&nbsp; &#39;r&#39; -&gt; Undergoes round-robin.<br>&gt;&nbsp;&nbsp; &#39;s&#39; -&gt; Interrupt shield enabled.
<br>&gt;&nbsp;&nbsp; &#39;t&#39; -&gt; Mode switches trapped.<br>&gt;&nbsp;&nbsp; &#39;o&#39; -&gt; Priority coupling off.<br>&gt;&nbsp;&nbsp; &#39;f&#39; -&gt; FPU enabled (for kernel threads).<br>&gt;<br><br>Well, I thought to remember some related stuff in the wiki. What I find
<br>is /proc/xenomai/stat, and that is broken here:<br><br><a href="http://www.xenomai.org/index.php/FAQs">http://www.xenomai.org/index.php/FAQs</a> -&gt;<br><a href="http://www.xenomai.org/index.php//proc/xenomai/stat">http://www.xenomai.org/index.php//proc/xenomai/stat
</a></blockquote><div><br>This page looks like it&#39;s never been created/edited... <br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Bruno, could you have a look if you can recover the content -- and<br>likely rename it then? Slashes don&#39;t appear to be a smart choice in wiki<br>page names...</blockquote><div><br>I don&#39;t find any content in the database although the entry /proc/xenomai/stat exist.
<br><br>I never to do some more research. I keep you informed...<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br>
</blockquote></div><br>--Bruno

------=_Part_116846_32833319.1182377798664--

