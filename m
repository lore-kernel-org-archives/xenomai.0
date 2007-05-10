Message-ID: <7289437c0705100547q208b9ec0n9600d2b18206bc49@domain.hid>
Date: Thu, 10 May 2007 14:47:13 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <46430ADC.2050706@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_62270_22274841.1178801233610"
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
	<17986.15326.243315.427529@domain.hid>
	<1178748178.11688.45.camel@domain.hid>
	<17986.20728.617772.991566@domain.hid>
	<1178784303.11688.108.camel@domain.hid> <4642D901.9050304@domain.hid>
	<1178789171.11688.142.camel@domain.hid> <4642E706.7000500@domain.hid>
	<7289437c0705100441l4f9e8cd9l7e7c447cedd1e5c2@domain.hid>
	<46430ADC.2050706@domain.hid>
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

------=_Part_62270_22274841.1178801233610
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried to apply the patch xeno-safer-xnfreesafe and enable RPI.
It doesn't work. I have the same problem :


pthread_create: failed to allocate TCB

pthread_create returned 11

__pthread_shadow: -11
Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
unavailable



On 5/10/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Perrine Martignoni wrote:
> > It works fine when I disable RPI.
> > Thanks.
>
> It appears to be working, but the memory is accessed after it was freed,
> so it may have other unwanted effects.
>
> >
> > The patch xeno-safer-xnfreesafe allows to enable RPI?
>
> Yes.
>
> --
>                                                 Gilles Chanteperdrix
>

------=_Part_62270_22274841.1178801233610
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I tried to apply the patch xeno-safer-xnfreesafe and enable RPI.</div>
<div>It doesn&#39;t work. I have the same problem : </div>
<div>&nbsp;</div>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">pthread_create: failed to allocate TCB</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">pthread_create returned 11</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">__pthread_shadow: -11</font></p>
<div class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Xenomai Posix skin init: pthread_setschedparam: Resource temporarily unavailable</font></div>
<div class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/10/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt; It works fine when I disable RPI.<br>&gt; Thanks.<br><br>It appears to be working, but the memory is accessed after it was freed,
<br>so it may have other unwanted effects.<br><br>&gt;<br>&gt; The patch xeno-safer-xnfreesafe allows to enable RPI?<br><br>Yes.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix<br></blockquote>
</div><br>

------=_Part_62270_22274841.1178801233610--

