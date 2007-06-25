Message-ID: <7289437c0706250633o678a56b7n1854c459b0e2b765@domain.hid>
Date: Mon, 25 Jun 2007 15:33:29 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <18047.39887.117650.552218@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1441_27068651.1182778409126"
References: <7289437c0706250217g7cab3109ic2d5079deded5069@domain.hid>
	<18047.39887.117650.552218@domain.hid>
Subject: Re: [Xenomai-help] Problem to have load module support
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

------=_Part_1441_27068651.1182778409126
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks. I solve my issue, it was a problem of memory space.

On 6/25/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Perrine Martignoni wrote:
> > Hello,
> >
> > I use xenomai 2.3.1 on an ARM9 board.
> > And I want to put the option "enable loadable module support" in my
> kernel.
> >
> > When I put this option in the Linux kernel with xenomai, the kernel
> doesn't
> > run.
> > I have this error of Bad CRC :
> > Booting image at 10080000
> > .....
> > Verifying Checksum... Bad Data CRC
> >
> > I noticed that when I remove xenomai and I put the option, the Linux
> kernel
> > run with no problem.
> >
> > Is this behavior normal?
>
> No, your boot loader likely has a size limit which the kernel with
> loadable module support exceeds. Increase this limit and everything
> should be fine.
>
> --
>
>
>                                            Gilles Chanteperdrix.
>

------=_Part_1441_27068651.1182778409126
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks. I solve my issue, it was a problem of memory space.<br><br>
<div><span class="gmail_quote">On 6/25/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I use xenomai 2.3.1 on an ARM9 board.<br>&gt; And I want to put the option &quot;enable loadable module support&quot; in my kernel.
<br>&gt;<br>&gt; When I put this option in the Linux kernel with xenomai, the kernel doesn&#39;t<br>&gt; run.<br>&gt; I have this error of Bad CRC :<br>&gt; Booting image at 10080000<br>&gt; .....<br>&gt; Verifying Checksum... Bad Data CRC
<br>&gt;<br>&gt; I noticed that when I remove xenomai and I put the option, the Linux kernel<br>&gt; run with no problem.<br>&gt;<br>&gt; Is this behavior normal?<br><br>No, your boot loader likely has a size limit which the kernel with
<br>loadable module support exceeds. Increase this limit and everything<br>should be fine.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix.<br></blockquote></div><br>

------=_Part_1441_27068651.1182778409126--

