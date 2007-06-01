Message-ID: <7289437c0706010211y2efca8d9n7c25745303dd2b2c@domain.hid>
Date: Fri, 1 Jun 2007 11:11:08 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465FE255.90801@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2825_24283268.1180689068392"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465E8FA8.4030507@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
	<465EC7C1.5080300@domain.hid> <465ECDEC.1030109@domain.hid>
	<465ECFCA.1070801@domain.hid> <465FD824.6010902@domain.hid>
	<465FDD44.1050404@domain.hid> <465FE255.90801@domain.hid>
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

------=_Part_2825_24283268.1180689068392
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Looks like wrappers.c is missing. Could you show us the command line
>used when xenomai builds libpthread_rt.so ?

Yes. it's because of wrappers.c.
It's my fault. I did an experiment.

Now, it works fine.

Thanks a lot

On 6/1/07, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Jan Kiszka wrote:
> > Wolfgang Grandegger wrote:
> >> Jan Kiszka wrote:
> >>> Wolfgang Grandegger wrote:
> >>>> Jan Kiszka wrote:
> >>>>> Perrine Martignoni wrote:
> >>>>>>> Perrine, did you happen to configure Xenomai with "configure
> >>>>>>> --host=arm
> >>>>>>> ..."? If yes (see config.log), please use "--host=arm-linux". This
> >>>>>>> solved all issues for me.
> >>>>>>>
> >>>>>>> Awaiting your feedback!
> >>>>>> I configure Xenomai with --host=arm.
> >>>>>> I tried to configure like this but it doesn't work :
> >>>>>>
> >>>>>> ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc
> >>>>>                       ^^^^^^^^^
> >>>>> I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
> >>>>> Try --build=i686-linux here.
> >>>> Or just omit it. Also CC=, CXX=, LD= ist not necessary. For PowerPC
> >>>> with the ELDK, I just use
> >>>>
> >>>>   ./configure --host=ppc-linux
> >>>>
> >>>> to configure Xenomai.
> >>> Can we define a common ground for this in README.INSTALL, for all
> archs?
> >>> The simpler, the better.
> >>>
> >>> I was heavily misled by the PPC section, because I do not
> cross-compile
> >>> everyday, thus had to look up the procedure again and managed to pick
> >>> the bad example...
> >> I had a closer look and realized, that passing just CC, CXX and LD to
> >> the configure script is not enough. There should at least also AR and
> >> RANLIB, otherwise the corresponding host tools are used. Then I think,
> >> it should be equivalent to automatic tool assignment via --host.
> >>
> >> Also note, that "--host=arm" will also work with the ELDK, because
> there
> >> are links arm-* to the tools arm-linux-*. I Perrine's configure
> examples
> >> above, arm-ar and arm-ranlib will then be used.
> >
> > But the issue is that in this case configure is unable to find the
> > target OS and fails to detect that shared libs are supported for the
> > target. Non-shared build fails with ELDK for unknown reasons.
>
> Why it is unable to find the target OS. Can you provide an example? And
> non-shared builds only fail with the ARM uClibc toolchain from the ELDK.
> It builds fine with the normal ARM tool-chain.
>
> Wolfgang.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_2825_24283268.1180689068392
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&gt;Looks like wrappers.c is missing. Could you show us the command line<br>&gt;used when xenomai builds libpthread_rt.so ?</div>
<div>&nbsp;</div>
<div>Yes. it&#39;s because of wrappers.c.</div>
<div>It&#39;s my fault. I did an experiment.</div>
<div><br>Now, it works fine.</div>
<div>&nbsp;</div>
<div>Thanks a lot<br>&nbsp;</div>
<div><span class="gmail_quote">On 6/1/07, <b class="gmail_sendername">Wolfgang Grandegger</b> &lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Jan Kiszka wrote:<br>&gt; Wolfgang Grandegger wrote:<br>&gt;&gt; Jan Kiszka wrote:<br>&gt;&gt;&gt; Wolfgang Grandegger wrote:
<br>&gt;&gt;&gt;&gt; Jan Kiszka wrote:<br>&gt;&gt;&gt;&gt;&gt; Perrine Martignoni wrote:<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Perrine, did you happen to configure Xenomai with &quot;configure<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; --host=arm
<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; ...&quot;? If yes (see config.log), please use &quot;--host=arm-linux&quot;. This<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; solved all issues for me.<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Awaiting your feedback!
<br>&gt;&gt;&gt;&gt;&gt;&gt; I configure Xenomai with --host=arm.<br>&gt;&gt;&gt;&gt;&gt;&gt; I tried to configure like this but it doesn&#39;t work :<br>&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt; ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc
<br>&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^<br>&gt;&gt;&gt;&gt;&gt; I guess you are not compiling Xenomai _on_ an ARM box, are you? :)<br>&gt;&gt;&gt;&gt;&gt; Try --build=i686-linux here.<br>&gt;&gt;&gt;&gt; Or just omit it. Also CC=, CXX=, LD= ist not necessary. For PowerPC
<br>&gt;&gt;&gt;&gt; with the ELDK, I just use<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp; ./configure --host=ppc-linux<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; to configure Xenomai.<br>&gt;&gt;&gt; Can we define a common ground for this in 
README.INSTALL, for all archs?<br>&gt;&gt;&gt; The simpler, the better.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; I was heavily misled by the PPC section, because I do not cross-compile<br>&gt;&gt;&gt; everyday, thus had to look up the procedure again and managed to pick
<br>&gt;&gt;&gt; the bad example...<br>&gt;&gt; I had a closer look and realized, that passing just CC, CXX and LD to<br>&gt;&gt; the configure script is not enough. There should at least also AR and<br>&gt;&gt; RANLIB, otherwise the corresponding host tools are used. Then I think,
<br>&gt;&gt; it should be equivalent to automatic tool assignment via --host.<br>&gt;&gt;<br>&gt;&gt; Also note, that &quot;--host=arm&quot; will also work with the ELDK, because there<br>&gt;&gt; are links arm-* to the tools arm-linux-*. I Perrine&#39;s configure examples
<br>&gt;&gt; above, arm-ar and arm-ranlib will then be used.<br>&gt;<br>&gt; But the issue is that in this case configure is unable to find the<br>&gt; target OS and fails to detect that shared libs are supported for the<br>
&gt; target. Non-shared build fails with ELDK for unknown reasons.<br><br>Why it is unable to find the target OS. Can you provide an example? And<br>non-shared builds only fail with the ARM uClibc toolchain from the ELDK.
<br>It builds fine with the normal ARM tool-chain.<br><br>Wolfgang.<br><br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a>
<br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br></blockquote></div><br>

------=_Part_2825_24283268.1180689068392--

