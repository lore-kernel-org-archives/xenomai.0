Message-ID: <7289437c0705020042w3a69a976l40bfe6be32650315@domain.hid>
Date: Wed, 2 May 2007 09:42:41 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4632148D.4060401@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1937_32772862.1178091761209"
References: <7289437c0704270747g122b5c84p1c4decbd31e2e4fe@domain.hid>
	<463211B8.7060509@domain.hid> <46321237.6080509@domain.hid>
	<4632148D.4060401@domain.hid>
Subject: Re: [Xenomai-help] Benchmark for Xenomai
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

------=_Part_1937_32772862.1178091761209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your answers.
I have already compiled Xenomai for the CSB637 board and run some xeno-test.
Now, I would like to write my own tests and I wanted only some ideas.
Thanks for the help on how to compile Posix programs for Xenomai because I'm
a beginner.


On 4/27/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Jan Kiszka wrote:
> > Gilles Chanteperdrix wrote:
> >
> >>Perrine Martignoni wrote:
> >>
> >>>Hello,
> >>>
> >>>I would like to know if you have a list of benchmark for the board
> >>>CSB637 or a board with an ARM9.
> >>
> >>I sent a mail last week about some latencies result on the CSB637.
> >>https://mail.gna.org/public/adeos-main/2007-04/msg00058.html
> >>
> >>
> >>>I want to test performances of Xenomai with API Posix and I don't know
> >>>how to begin.
> >>
> >>A starting point would be to compile Xenomai for your CSB637 board, and
> >>run the "xeno-test" script. Among the tests run by the xeno-test script,
> >>cyclictest uses the POSIX API and is equivalent to the native API
> >>latency test. If you want other results than latency, I am afraid you
> >>will have to write the tests yourself. But if you do so, we will be
> >>pleased to add them to Xenomai.
> >
> >
> > Here is some potential source for further benchmarks:
> >
> > http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/
> >
> > They were written for -rt Linux, but should (in theory) work for
> > Xenomai's POSIX skin as well (haven't looked nor tried yet) -- except
> > for tests that may use silly signals.
>
> And for a little help on how to compile POSIX programs for Xenomai POSIX
> skin, read:
>
>
> http://svn.gna.org/viewcvs/xenomai/trunk/doc/txt/pse51-skin.txt?rev=&view=auto
>
> --
>                                                  Gilles Chanteperdrix
>

------=_Part_1937_32772862.1178091761209
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your answers.<br>I have already compiled Xenomai for the CSB637 board and run some xeno-test.<br>Now, I would like to write my own tests and I wanted only some ideas.<br>Thanks for the help on how to compile Posix programs for Xenomai because I&#39;m a beginner. 
<br><br><br>
<div><span class="gmail_quote">On 4/27/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank">
gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">Jan Kiszka wrote:<br>&gt; Gilles Chanteperdrix wrote:<br>&gt;<br>&gt;&gt;Perrine Martignoni wrote:
<br>&gt;&gt;<br>&gt;&gt;&gt;Hello,<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;I would like to know if you have a list of benchmark for the board <br>&gt;&gt;&gt;CSB637 or a board with an ARM9.<br>&gt;&gt;<br>&gt;&gt;I sent a mail last week about some latencies result on the CSB637.
<br>&gt;&gt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="https://mail.gna.org/public/adeos-main/2007-04/msg00058.html" target="_blank">https://mail.gna.org/public/adeos-main/2007-04/msg00058.html </a><br>
&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;&gt;I want to test performances of Xenomai with API Posix and I don&#39;t know<br>&gt;&gt;&gt;how to begin.<br>&gt;&gt;<br>&gt;&gt;A starting point would be to compile Xenomai for your CSB637 board, and 
<br>&gt;&gt;run the &quot;xeno-test&quot; script. Among the tests run by the xeno-test script,<br>&gt;&gt;cyclictest uses the POSIX API and is equivalent to the native API<br>&gt;&gt;latency test. If you want other results than latency, I am afraid you 
<br>&gt;&gt;will have to write the tests yourself. But if you do so, we will be<br>&gt;&gt;pleased to add them to Xenomai.<br>&gt;<br>&gt;<br>&gt; Here is some potential source for further benchmarks:<br>&gt;<br>&gt; <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/" target="_blank">
http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/</a><br>&gt;<br>&gt; They were written for -rt Linux, but should (in theory) work for<br>&gt; Xenomai&#39;s POSIX skin as well (haven&#39;t looked nor tried yet) -- except 
<br>&gt; for tests that may use silly signals.<br><br>And for a little help on how to compile POSIX programs for Xenomai POSIX<br>skin, read:<br><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://svn.gna.org/viewcvs/xenomai/trunk/doc/txt/pse51-skin.txt?rev=&amp;view=auto" target="_blank">
http://svn.gna.org/viewcvs/xenomai/trunk/doc/txt/pse51-skin.txt?rev=&amp;view=auto</a><br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_1937_32772862.1178091761209--

