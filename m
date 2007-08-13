Message-ID: <3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
Date: Mon, 13 Aug 2007 17:10:09 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <18112.1512.506911.608273@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_198914_4917708.1187017809236"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<46BAF956.5090401@domain.hid>
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
	<1186676576.4978.12.camel@domain.hid> <46BC1494.2010303@domain.hid>
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
	<46BC8074.3090104@domain.hid>
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>
	<18112.1512.506911.608273@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_198914_4917708.1187017809236
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Klaas Gadeyne wrote:
> > On Fri, 10 Aug 2007, Jan Kiszka wrote:
> > [..]
> > > BTW, given that the SMI workaround is infunctional on your system: Do
> > > you get reasonable latencies ATM? It looked to me like the NMI
> watchdog
> > > might have triggered due to SMI-related delays.
> >
> > We do get very reasonable latencies once the AGP functionality is
> > turned off (otherwise, latencies are pathetic).  Note that we haven't
> > sorted out whether the buggy behaviour and huge latencies are due to
> > the AGP bus in general or too the specific intel_something_els_here
> > driver.
>
> Did you try the "noaccel" option, as explained in the FAQ ?
>

Yes, but there was no change in performance.

We have tried several configurations of the system, and we get no hard
lockups anymore.
Even the configurations that used to lockup are working now without a
problem.

Maybe we forget something, but to be honest, we have no idea what triggered
this change in behavior.
Thanks for all the help.
As soon as we know something more about this 'random' behavior, We will post
it.

greetings, andy

------=_Part_198914_4917708.1187017809236
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Klaas Gadeyne wrote:<br> &gt; On Fri, 10 Aug 2007, Jan Kiszka wrote:
<br> &gt; [..]<br> &gt; &gt; BTW, given that the SMI workaround is infunctional on your system: Do<br> &gt; &gt; you get reasonable latencies ATM? It looked to me like the NMI watchdog<br> &gt; &gt; might have triggered due to SMI-related delays.
<br> &gt;<br> &gt; We do get very reasonable latencies once the AGP functionality is<br> &gt; turned off (otherwise, latencies are pathetic).&nbsp;&nbsp;Note that we haven&#39;t<br> &gt; sorted out whether the buggy behaviour and huge latencies are due to
<br> &gt; the AGP bus in general or too the specific intel_something_els_here<br> &gt; driver.<br><br>Did you try the &quot;noaccel&quot; option, as explained in the FAQ ?<br></blockquote></div><br>Yes, but there was no change in performance.
<br><br>We have tried several configurations of the system, and we get no hard lockups anymore. <br>Even the configurations that used to lockup are working now without a problem.<br><br>Maybe we forget something, but to be honest, we have no idea what triggered this change in behavior.
<br>Thanks for all the help. <br>As soon as we know something more about this &#39;random&#39; behavior, We will post it.<br><br>greetings, andy<br><br><br>

------=_Part_198914_4917708.1187017809236--

