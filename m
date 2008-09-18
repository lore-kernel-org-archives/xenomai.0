Message-ID: <217b7eb20809180722w423f78b2qb4d7db0bfb248953@domain.hid>
Date: Thu, 18 Sep 2008 19:22:43 +0500
From: Hank <hank007@domain.hid>
In-Reply-To: <48D255E0.7000603@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27313_8666740.1221747763560"
References: <mailman.1448.1221743175.22433.adeos-main@gna.org>
	<217b7eb20809180614u28d04ef8vc63fadb0b7db1ae9@domain.hid>
	<48D255E0.7000603@domain.hid>
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

------=_Part_27313_8666740.1221747763560
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Hank wrote:
> > Hello Guys,
> > I'm porting xenomai to Freescale iMX31 processor (on iMX31 LiteKit) as
> per
> > porting guidelines. In the first phase, applied
> > adeos-ipipe-2.6.19-arm-1.7-00 patch found in xenomai-2.4.4 to kernel
> > 2.6.19.2 and have implemented required machine specific code. Everything
> > went smooth and after fixing a few bugs, kernel booted but with a problem
> -
> > init doesn't complete. Following are last few kernel boot log messages:
> >
> >
> > Looking up port of RPC 100003/2 on 192.168.1.25
> > Looking up port of RPC 100005/1 on 192.168.1.25
> > VFS: Mounted root (nfs filesystem).
> > Freeing init memory: 120K
>
> Since you are booting via NFS, wireshark may help ?
>
> Do you have the same problem if you disable support for VFP ?
>
> --
>                                                 Gilles.

Thanks Gilles.

I've tried everything. Wireshark shows NFS read requests being issued and
busybox etc. being sent back. Already played with VFP without any luck!

Regards

------=_Part_27313_8666740.1221747763560
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">On 9/18/08, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hank wrote:<br>&gt; Hello Guys,<br>&gt; I&#39;m porting xenomai to Freescale iMX31 processor (on iMX31 LiteKit) as per<br>
&gt; porting guidelines. In the first phase, applied<br>&gt; adeos-ipipe-2.6.19-arm-1.7-00 patch found in xenomai-2.4.4 to kernel<br>&gt; <a href="http://2.6.19.2">2.6.19.2</a> and have implemented required machine specific code. Everything<br>
&gt; went smooth and after fixing a few bugs, kernel booted but with a problem -<br>&gt; init doesn&#39;t complete. Following are last few kernel boot log messages:<br>&gt;<br>&gt;<br>&gt; Looking up port of RPC 100003/2 on <a href="http://192.168.1.25">192.168.1.25</a><br>
&gt; Looking up port of RPC 100005/1 on <a href="http://192.168.1.25">192.168.1.25</a><br>&gt; VFS: Mounted root (nfs filesystem).<br>&gt; Freeing init memory: 120K<br><br>Since you are booting via NFS, wireshark may help ?<br>
<br>Do you have the same problem if you disable support for VFP ?<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles.</blockquote>
<div>Thanks Gilles.</div>
<div>&nbsp;</div>
<div>I&#39;ve tried everything. Wireshark shows NFS read requests being issued and busybox etc.&nbsp;being sent back. Already played with VFP without any luck!</div><br>Regards</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_27313_8666740.1221747763560--

