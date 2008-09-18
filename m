Message-ID: <217b7eb20809180807j9bf19ecnb43d69355d2e4ff6@domain.hid>
Date: Thu, 18 Sep 2008 20:07:18 +0500
From: Hank <hank007@domain.hid>
In-Reply-To: <48D264B6.6080504@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_28705_28259180.1221750438558"
References: <mailman.1448.1221743175.22433.adeos-main@gna.org>
	<217b7eb20809180614u28d04ef8vc63fadb0b7db1ae9@domain.hid>
	<48D255E0.7000603@domain.hid>
	<217b7eb20809180722w423f78b2qb4d7db0bfb248953@domain.hid>
	<48D264B6.6080504@domain.hid>
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

------=_Part_28705_28259180.1221750438558
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Hank wrote:
> > On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> wrote:
> >> Hank wrote:
> >>> Hello Guys,
> >>> I'm porting xenomai to Freescale iMX31 processor (on iMX31 LiteKit) as
> >> per
> >>> porting guidelines. In the first phase, applied
> >>> adeos-ipipe-2.6.19-arm-1.7-00 patch found in xenomai-2.4.4 to kernel
> >>> 2.6.19.2 and have implemented required machine specific code.
> Everything
> >>> went smooth and after fixing a few bugs, kernel booted but with a
> problem
> >> -
> >>> init doesn't complete. Following are last few kernel boot log messages:
> >>>
> >>>
> >>> Looking up port of RPC 100003/2 on 192.168.1.25
> >>> Looking up port of RPC 100005/1 on 192.168.1.25
> >>> VFS: Mounted root (nfs filesystem).
> >>> Freeing init memory: 120K
> >> Since you are booting via NFS, wireshark may help ?
> >>
> >> Do you have the same problem if you disable support for VFP ?
> >>
> >> --
> >>                                                 Gilles.
> >
> > Thanks Gilles.
> >
> > I've tried everything. Wireshark shows NFS read requests being issued and
> > busybox etc. being sent back. Already played with VFP without any luck!
>
> And the advice in the "tips and tricks" section of the howto ?
>
> --
>                                                 Gilles.


Well, some of the tricks helped during initial stages but other don't seem
to apply now as there is no crash here!

------=_Part_28705_28259180.1221750438558
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">On 9/18/08, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hank wrote:<br>&gt; On 9/18/08, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt; Hank wrote:<br>&gt;&gt;&gt; Hello Guys,<br>&gt;&gt;&gt; I&#39;m porting xenomai to Freescale iMX31 processor (on iMX31 LiteKit) as<br>&gt;&gt; per<br>&gt;&gt;&gt; porting guidelines. In the first phase, applied<br>
&gt;&gt;&gt; adeos-ipipe-2.6.19-arm-1.7-00 patch found in xenomai-2.4.4 to kernel<br>&gt;&gt;&gt; <a href="http://2.6.19.2">2.6.19.2</a> and have implemented required machine specific code. Everything<br>&gt;&gt;&gt; went smooth and after fixing a few bugs, kernel booted but with a problem<br>
&gt;&gt; -<br>&gt;&gt;&gt; init doesn&#39;t complete. Following are last few kernel boot log messages:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Looking up port of RPC 100003/2 on <a href="http://192.168.1.25">192.168.1.25</a><br>
&gt;&gt;&gt; Looking up port of RPC 100005/1 on <a href="http://192.168.1.25">192.168.1.25</a><br>&gt;&gt;&gt; VFS: Mounted root (nfs filesystem).<br>&gt;&gt;&gt; Freeing init memory: 120K<br>&gt;&gt; Since you are booting via NFS, wireshark may help ?<br>
&gt;&gt;<br>&gt;&gt; Do you have the same problem if you disable support for VFP ?<br>&gt;&gt;<br>&gt;&gt; --<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles.<br>&gt;<br>&gt; Thanks Gilles.<br>&gt;<br>&gt; I&#39;ve tried everything. Wireshark shows NFS read requests being issued and<br>
&gt; busybox etc. being sent back. Already played with VFP without any luck!<br><br>And the advice in the &quot;tips and tricks&quot; section of the howto ?<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles.</blockquote>

<div>&nbsp;</div>
<div>Well, some of the tricks helped during initial stages but&nbsp;other don&#39;t seem to apply now as there is no crash here!<br clear="all"></div>
<div>&nbsp;</div></div>

------=_Part_28705_28259180.1221750438558--

