Message-ID: <8b3b30860712271035s24933c63wf981b32dcf5b4a7b@domain.hid>
Date: Thu, 27 Dec 2007 19:35:16 +0100
From: "Racconico Lambrati" <racconico.lambrati@domain.hid>
In-Reply-To: <8b3b30860712271028p12db5801mb156e6d58a01008f@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12263_14017386.1198780516640"
References: <8b3b30860712270704o1a7d0cbahe97a4e90e9455cbc@domain.hid>
	<2ff1a98a0712270815r30b5e19eycf6fb44224d2ea83@domain.hid>
	<8b3b30860712271005i3e4f9eb6t4ad35205c0117b9a@domain.hid>
	<18291.60209.715762.159719@domain.hid>
	<8b3b30860712271028p12db5801mb156e6d58a01008f@domain.hid>
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

------=_Part_12263_14017386.1198780516640
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

How can I run it in kernel space?
The application is designed to be little and stable, and with fusion
0.9.1run without problem

2007/12/27, Gilles Chanteperdrix < gilles.chanteperdrix@xenomai.org>:
> >
> > Racconico Lambrati wrote:
> > > 2007/12/27, Gilles Chanteperdrix < gilles.chanteperdrix@xenomai.org>:
> > > >
> > > > On Dec 27, 2007 4:04 PM, Racconico Lambrati
> > > > < racconico.lambrati@domain.hid> wrote:
> > > > > Hi.
> > > > >
> > > > > I've update my system to xenomai 2.4.0 from fusion 0.9.1 using
> > vxworks
> > > > skin
> > > > >
> > > > > I used http://www.captain.at/xenomai-porting-fusion.php to make
> > the
> > > > porting
> > > > > of my application.
> > > > >
> > > > > now I have this linker problem:
> > > > >
> > > > > ... undefined reference to 'printk'
> > > > > ... undefined reference to 'intUnlock'
> > > > > ... undefined reference to 'intLock'
> > > > > ... undefined reference to 'sysClkConnect'
> > > > >
> > > > > could you give me an hint?
> > > >
> > > > These functions are only available in kernel-space. The fact that
> > you
> > > > must use them probably means that you should split your application:
> > > > move the part that require access to low-level functions in a driver
> > > > using the rtdm skin.
> > > >
> > > It could be a chance but for now I want to run my
> > > application as I run it under fusion to test that everything
> > > is ok.
> > >
> > > I see that intLock intUnlock and sysClkConnect are present
> > > in vxworks.h, why the linker can't find it?
> > >
> >
> > As I already told these functions are only available in kernel-space,
> > they can not be implemented in user-space, they are not present in
> > the vxworks library so the linker can not find them.
> >
> > Your only chance is to run your application in kernel-space. But this
> > will make it harder to debug.
> >
> > Without seeing the parts of your code requiring these low-level calls,
> > it is hard to say anything.
> >
> > --
> >
> >
> >                                             Gilles Chanteperdrix.
> >
>
>

------=_Part_12263_14017386.1198780516640
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><span class="gmail_quote"></span>How can I run it in kernel space?<br>The application is designed to be little and stable, and with fusion 0.9.1 run without problem<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><span class="q" id="q_1171cdc72115d806_1"><div><span class="gmail_quote">2007/12/27, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Racconico Lambrati wrote:<br> &gt; 2007/12/27, Gilles Chanteperdrix &lt;
<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">gilles.chanteperdrix@xenomai.org</a>&gt;:<br> &gt; &gt;<br> &gt; &gt; On Dec 27, 2007 4:04 PM, Racconico Lambrati
<br> &gt; &gt; &lt;<a href="mailto:racconico.lambrati@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
racconico.lambrati@domain.hid</a>&gt; wrote:<br> &gt; &gt; &gt; Hi.<br> &gt; &gt; &gt;<br> &gt; &gt; &gt; I&#39;ve update my system to xenomai 2.4.0 from fusion 0.9.1 using vxworks<br> &gt; &gt; skin<br> &gt; &gt; &gt;<br>

 &gt; &gt; &gt; I used <a href="http://www.captain.at/xenomai-porting-fusion.php" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.captain.at/xenomai-porting-fusion.php</a> to make the<br>
 &gt; &gt; porting<br> &gt; &gt; &gt; of my application.<br> &gt; &gt; &gt;
<br> &gt; &gt; &gt; now I have this linker problem:<br> &gt; &gt; &gt;<br> &gt; &gt; &gt; ... undefined reference to &#39;printk&#39;<br> &gt; &gt; &gt; ... undefined reference to &#39;intUnlock&#39;<br> &gt; &gt; &gt; ... undefined reference to &#39;intLock&#39;
<br> &gt; &gt; &gt; ... undefined reference to &#39;sysClkConnect&#39;<br> &gt; &gt; &gt;<br> &gt; &gt; &gt; could you give me an hint?<br> &gt; &gt;<br> &gt; &gt; These functions are only available in kernel-space. The fact that you
<br> &gt; &gt; must use them probably means that you should split your application:<br> &gt; &gt; move the part that require access to low-level functions in a driver<br> &gt; &gt; using the rtdm skin.<br> &gt; &gt;<br> &gt; It could be a chance but for now I want to run my
<br> &gt; application as I run it under fusion to test that everything<br> &gt; is ok.<br> &gt;<br> &gt; I see that intLock intUnlock and sysClkConnect are present<br> &gt; in vxworks.h, why the linker can&#39;t find it?
<br>
 &gt;<br><br>As I already told these functions are only available in kernel-space,<br>they can not be implemented in user-space, they are not present in<br>the vxworks library so the linker can not find them.<br><br>Your only chance is to run your application in kernel-space. But this
<br>will make it harder to debug.<br><br>Without seeing the parts of your code requiring these low-level calls,<br>it is hard to say anything.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.
<br></blockquote></div><br>
</span></div></blockquote></div><br>

------=_Part_12263_14017386.1198780516640--

