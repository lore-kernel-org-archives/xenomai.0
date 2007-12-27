Message-ID: <8b3b30860712271005i3e4f9eb6t4ad35205c0117b9a@domain.hid>
Date: Thu, 27 Dec 2007 19:05:12 +0100
From: "Racconico Lambrati" <racconico.lambrati@domain.hid>
In-Reply-To: <2ff1a98a0712270815r30b5e19eycf6fb44224d2ea83@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12162_1202006.1198778712243"
References: <8b3b30860712270704o1a7d0cbahe97a4e90e9455cbc@domain.hid>
	<2ff1a98a0712270815r30b5e19eycf6fb44224d2ea83@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
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

------=_Part_12162_1202006.1198778712243
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It could be a chance but for now I want to run my
application as I run it under fusion to test that everything
is ok.

I see that intLock intUnlock and sysClkConnect are present
in vxworks.h, why the linker can't find it?



2007/12/27, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Dec 27, 2007 4:04 PM, Racconico Lambrati
> <racconico.lambrati@domain.hid> wrote:
> > Hi.
> >
> > I've update my system to xenomai 2.4.0 from fusion 0.9.1 using vxworks
> skin
> >
> > I used http://www.captain.at/xenomai-porting-fusion.php to make the
> porting
> > of my application.
> >
> > now I have this linker problem:
> >
> > ... undefined reference to 'printk'
> > ... undefined reference to 'intUnlock'
> > ... undefined reference to 'intLock'
> > ... undefined reference to 'sysClkConnect'
> >
> > could you give me an hint?
>
> These functions are only available in kernel-space. The fact that you
> must use them probably means that you should split your application:
> move the part that require access to low-level functions in a driver
> using the rtdm skin.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_12162_1202006.1198778712243
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<pre>It could be a chance but for now I want to run my<br>application as I run it under fusion to test that everything<br>is ok.<br><br>I see that intLock intUnlock and sysClkConnect are present<br>in vxworks.h, why the linker can&#39;t find it?
</pre><br><br><div><span class="gmail_quote">2007/12/27, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Dec 27, 2007 4:04 PM, Racconico Lambrati<br>&lt;<a href="mailto:racconico.lambrati@domain.hid">racconico.lambrati@domain.hid</a>&gt; wrote:<br>&gt; Hi.<br>&gt;<br>&gt; I&#39;ve update my system to xenomai 2.4.0 from fusion 
0.9.1 using vxworks skin<br>&gt;<br>&gt; I used <a href="http://www.captain.at/xenomai-porting-fusion.php">http://www.captain.at/xenomai-porting-fusion.php</a> to make the porting<br>&gt; of my application.<br>&gt;<br>&gt; now I have this linker problem:
<br>&gt;<br>&gt; ... undefined reference to &#39;printk&#39;<br>&gt; ... undefined reference to &#39;intUnlock&#39;<br>&gt; ... undefined reference to &#39;intLock&#39;<br>&gt; ... undefined reference to &#39;sysClkConnect&#39;
<br>&gt;<br>&gt; could you give me an hint?<br><br>These functions are only available in kernel-space. The fact that you<br>must use them probably means that you should split your application:<br>move the part that require access to low-level functions in a driver
<br>using the rtdm skin.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_12162_1202006.1198778712243--

