Message-ID: <217b7eb20809180855r77889497y9e599c525bc4f6a8@domain.hid>
Date: Thu, 18 Sep 2008 20:55:40 +0500
From: Hank <hank007@domain.hid>
In-Reply-To: <48D272B9.2080304@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_30166_18862083.1221753340716"
References: <mailman.1448.1221743175.22433.adeos-main@gna.org>
	<217b7eb20809180614u28d04ef8vc63fadb0b7db1ae9@domain.hid>
	<48D255E0.7000603@domain.hid>
	<217b7eb20809180722w423f78b2qb4d7db0bfb248953@domain.hid>
	<48D264B6.6080504@domain.hid>
	<217b7eb20809180807j9bf19ecnb43d69355d2e4ff6@domain.hid>
	<48D26F8F.8030401@domain.hid>
	<217b7eb20809180817p15cb4161o8ef6482fe835f143@domain.hid>
	<48D272B9.2080304@domain.hid>
Subject: Re: [Adeos-main] adeos-ipipe-2.6.19-arm-1.7-00 on iMX31: init
	doesn't complete!
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

------=_Part_30166_18862083.1221753340716
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Hank wrote:
> > On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> wrote:
> >> Hank wrote:
> >>> Well, some of the tricks helped during initial stages but other don't
> >> seem
> >>> to apply now as there is no crash here!
> >> Oh yes ? Are you sure the timer is ticking correctly ?
> >>
> >> --
> >>                                                 Gilles.
> >
> >
> > Yes. Also, forced it to a soft lockup crash in ret_to_user() and trace
> > showed timer interrupt ticking and updating process timers all the way
> up!
>
> I am afraid I can not help much. The patch you use is too old, I fixed
> some bugs recently in the traps interception code which should lead to a
> clear crash instead of some lockup. I also added support for VFP.
>
> So, do you observe the same phenomenon with a vanilla 2.6.26 and the
> latest patch (AFAIK Litekit is supported by mainline) ?
>
> I also suspect a bug when using Xenomai with NO_HZ on ARM. So, you may
> try to disable NO_HZ.
>
> --
>                                                 Gilles.


Thanks Gilles. Well, looks like your suspicions about VFP were right! I
certainly didn't test it recently without VFP. It just booted to shell after
disabling VFP.

Thanks for helping out.

------=_Part_30166_18862083.1221753340716
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">On 9/18/08, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hank wrote:<br>&gt; On 9/18/08, Gilles Chanteperdrix &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt; Hank wrote:<br>&gt;&gt;&gt; Well, some of the tricks helped during initial stages but other don&#39;t<br>&gt;&gt; seem<br>&gt;&gt;&gt; to apply now as there is no crash here!<br>&gt;&gt; Oh yes ? Are you sure the timer is ticking correctly ?<br>
&gt;&gt;<br>&gt;&gt; --<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles.<br>&gt;<br>&gt;<br>&gt; Yes. Also, forced it to a soft lockup crash in ret_to_user() and trace<br>&gt; showed timer interrupt ticking and updating process timers all the way up!<br>
<br>I am afraid I can not help much. The patch you use is too old, I fixed<br>some bugs recently in the traps interception code which should lead to a<br>clear crash instead of some lockup. I also added support for VFP.<br>
<br>So, do you observe the same phenomenon with a vanilla 2.6.26 and the<br>latest patch (AFAIK Litekit is supported by mainline) ?<br><br>I also suspect a bug when using Xenomai with NO_HZ on ARM. So, you may<br>try to disable NO_HZ.<br>
<br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles.</blockquote>
<div>&nbsp;</div>
<div>Thanks Gilles. Well, looks like your suspicions about VFP were right! I certainly didn&#39;t test it recently without VFP. It just booted to shell after disabling VFP.</div>
<div>&nbsp;</div>
<div>Thanks for helping out.</div><br>&nbsp;</div>

------=_Part_30166_18862083.1221753340716--

