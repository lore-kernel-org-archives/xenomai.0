Message-ID: <7289437c0705090431x28f68aacxd4f28da514dff60c@domain.hid>
Date: Wed, 9 May 2007 13:31:28 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4641951C.4020008@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_53795_22913755.1178710288498"
References: <7289437c0705090155ma97b0et930b53336849a56f@domain.hid>
	<4641951C.4020008@domain.hid>
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
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

------=_Part_53795_22913755.1178710288498
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have exactly the same problem with cyclictest.

And here is the context of /proc/xenomai/heap before :

size=130560:used=64:pagesz=512

and after :


size=130560:used=64:pagesz=512



It doesn't change.



On 5/9/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Perrine Martignoni wrote:
> > Hello,
> >
> > I've build a xenomai test application with Posix skin wich run on an
> > ARM9. The application works well one time, and when I want to launch
> > again my application, I have this error message :
> >
> >
> > Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
> > unavailable
> >
> >
> >
> > I think something was bad cancelled but I don't see.
>
> Resource temporarily unavailable is EAGAIN, it means that there is not
> enough memory to create the real-time thread. Could you send us the
> contents of /proc/xenomai/heap before and after running your
> application  ?
>
> --
>                                                 Gilles Chanteperdrix
>

------=_Part_53795_22913755.1178710288498
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I have exactly the same problem with cyclictest.</div>
<div>&nbsp;</div>
<div>And here is the context of /proc/xenomai/heap before : </div>
<div>&nbsp;</div>
<div><span style="FONT-SIZE: 12pt; FONT-FAMILY: &#39;Nimbus Roman No9 L&#39;; mso-fareast-font-family: &#39;Luxi Sans&#39;; mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-ansi-language: FR; mso-fareast-language: #00FF; mso-bidi-language: #00FF">
<font face="Times New Roman">size=130560:used=64:pagesz=512</font></span></div>
<div><span style="FONT-SIZE: 12pt; FONT-FAMILY: &#39;Nimbus Roman No9 L&#39;; mso-fareast-font-family: &#39;Luxi Sans&#39;; mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-ansi-language: FR; mso-fareast-language: #00FF; mso-bidi-language: #00FF">
<font face="Times New Roman"></font></span>&nbsp;</div>
<div><span style="FONT-SIZE: 12pt; FONT-FAMILY: &#39;Nimbus Roman No9 L&#39;; mso-fareast-font-family: &#39;Luxi Sans&#39;; mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-ansi-language: FR; mso-fareast-language: #00FF; mso-bidi-language: #00FF">
<font face="Times New Roman"><font face="">and after :</font> </font></span></div>
<div><span style="FONT-SIZE: 12pt; FONT-FAMILY: &#39;Nimbus Roman No9 L&#39;; mso-fareast-font-family: &#39;Luxi Sans&#39;; mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-ansi-language: FR; mso-fareast-language: #00FF; mso-bidi-language: #00FF">
<font face="Times New Roman"></font></span>&nbsp;</div>
<div><span style="FONT-SIZE: 12pt; FONT-FAMILY: &#39;Nimbus Roman No9 L&#39;; mso-fareast-font-family: &#39;Luxi Sans&#39;; mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-ansi-language: FR; mso-fareast-language: #00FF; mso-bidi-language: #00FF">

<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face="Times New Roman">size=130560:used=64:pagesz=512</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face="Times New Roman"></font></span>&nbsp;</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-bidi-language: #00FF"><font face="Times New Roman">It doesn&#39;t change.</font></span></p></span></div>
<div><span style="FONT-SIZE: 12pt; FONT-FAMILY: &#39;Nimbus Roman No9 L&#39;; mso-fareast-font-family: &#39;Luxi Sans&#39;; mso-bidi-font-family: &#39;Luxi Sans&#39;; mso-ansi-language: FR; mso-fareast-language: #00FF; mso-bidi-language: #00FF">
<font face="Times New Roman"></font></span>&nbsp;</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/9/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I&#39;ve build a xenomai test application with Posix skin wich run on an
<br>&gt; ARM9. The application works well one time, and when I want to launch<br>&gt; again my application, I have this error message :<br>&gt;<br>&gt;<br>&gt; Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
<br>&gt; unavailable<br>&gt;<br>&gt;<br>&gt;<br>&gt; I think something was bad cancelled but I don&#39;t see.<br><br>Resource temporarily unavailable is EAGAIN, it means that there is not<br>enough memory to create the real-time thread. Could you send us the
<br>contents of /proc/xenomai/heap before and after running your application&nbsp;&nbsp;?<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_53795_22913755.1178710288498--

