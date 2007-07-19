Message-ID: <2862c2c80707190223mc3986a9y2b5567d1bcb96789@domain.hid>
Date: Thu, 19 Jul 2007 17:23:47 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707190136o48f3934ar55a5fc579f719775@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_74345_22275618.1184837027345"
References: <2862c2c80707190105j79e9357ehbba9285c2f8a250c@domain.hid>
	<2ff1a98a0707190136o48f3934ar55a5fc579f719775@domain.hid>
Subject: Re: [Xenomai-help] Cross Compile the Xenomai-2.3.2 for AT91 - ld
	terminated with signal 11
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
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_74345_22275618.1184837027345
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Try out the xenomai-2.3.1, the error remains the same. Any recommendation of
the toolchain that works?

regards,
chun yeow

On 7/19/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 7/19/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> > Dear all,
> >
> > I have tried to cross compile the xenomai-2.3.2 for AT91RM9200 but run
> in to
> > the following problems:
> >
> > (...)
> > collect2: ld terminated with signal 11 [Segmentation fault]
> > (...)
>
> No, Xenomai compilation flags trigger a bug of the toolchain you use.
> Could you try xenomai-2.3.1 to see if the bug does not come from some
> recent changes ?
> If you have the same problem with xenomai-2.3.1, I am afraid you will
> have to change your toolchain.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_74345_22275618.1184837027345
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Try out the xenomai-2.3.1, the error remains the same. Any recommendation of the toolchain that works?<br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">On 7/19/07, <b class="gmail_sendername">
Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 7/19/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt; Dear all,<br>&gt;<br>&gt; I have tried to cross compile the xenomai-2.3.2 for AT91RM9200 but run in to<br>
&gt; the following problems:<br>&gt;<br>&gt; (...)<br>&gt; collect2: ld terminated with signal 11 [Segmentation fault]<br>&gt; (...)<br><br>No, Xenomai compilation flags trigger a bug of the toolchain you use.<br>Could you try 
xenomai-2.3.1 to see if the bug does not come from some<br>recent changes ?<br>If you have the same problem with xenomai-2.3.1, I am afraid you will<br>have to change your toolchain.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix
<br></blockquote></div><br>

------=_Part_74345_22275618.1184837027345--

