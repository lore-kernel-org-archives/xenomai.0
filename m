Message-ID: <3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
Date: Fri, 10 Aug 2007 17:05:30 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0708100951160.23969@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_170776_21236327.1186758330861"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>
	<46BAF956.5090401@domain.hid>
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
	<1186676576.4978.12.camel@domain.hid> <46BC1494.2010303@domain.hid>
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>
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
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_170776_21236327.1186758330861
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/8/10, Klaas Gadeyne <klaas.gadeyne@domain.hid>:
>
> On Fri, 10 Aug 2007, Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >>> The linux kernel used now is 2.6.20.9 with ipipe patch 1.8-08.
> >>> We use branch 2.3.x of Xenomai (Last changed Revision 2898)
> >>>
> >>> While running xeno-test, the system locks-up just after the latency
> >>> test.
> >>
> >> Confirmed here. Houston, we do have a problem with the switchtest, or
> >> soimething this test triggers (and not necessarily the FPU mgmt)...
> >
> > Any news on this? Does it already happen by just running switchtest
> > stand-alone (it doesn't do so here at least)? Is this a pure 2.3.x
> > issue, or is it also visible for 2.4? /me currently rebuilds some trees
> > to assess the local situation.
>
> Andy will probably continue testing today, so more info will follow, but
> (see
> <https://mail.gna.org/public/xenomai-help/2007-08/msg00044.html>) at
> first sight we encountered similar issues on trunk (2.2.x seems
> unaffected).
>
> Klaas


We have disabled NMI watchdog like Gilles Chanteperdrix suggested in his
previous message.

For the moment We have no hard locks anymore. The linux kernel used is still
2.6.20.9 with ipipe patch 1.8-08.
We use branch 2.3.x of Xenomai (Last changed Revision 2898). The only thing
We have changed is turning off the "NMI watchdog".

There is no obvious reason why this happened (according to us), but it may
have something to do with the AGP bus (we turned it OFF in this kernel, it
was already turned OFF in the previous tests, but it was ON in the first
tests).

For seeing if this system will not hard lock anymore, the system will stay
on this weekend (continuously running xeno-tests with high loads). We will
inform you of the results after the weekend.

thanks and greetings, andy

------=_Part_170776_21236327.1186758330861
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/8/10, Klaas Gadeyne &lt;<a href="mailto:klaas.gadeyne@domain.hid">klaas.gadeyne@domain.hid</a>&gt;:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, 10 Aug 2007, Jan Kiszka wrote:<br>&gt; Philippe Gerum wrote:<br>&gt;&gt;&gt; The linux kernel used now is <a href="http://2.6.20.9">2.6.20.9</a> with ipipe patch 1.8-08.<br>&gt;&gt;&gt; We use branch 2.3.x of Xenomai (Last changed Revision 2898)
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; While running xeno-test, the system locks-up just after the latency<br>&gt;&gt;&gt; test.<br>&gt;&gt;<br>&gt;&gt; Confirmed here. Houston, we do have a problem with the switchtest, or<br>&gt;&gt; soimething this test triggers (and not necessarily the FPU mgmt)...
<br>&gt;<br>&gt; Any news on this? Does it already happen by just running switchtest<br>&gt; stand-alone (it doesn&#39;t do so here at least)? Is this a pure 2.3.x<br>&gt; issue, or is it also visible for 2.4? /me currently rebuilds some trees
<br>&gt; to assess the local situation.<br><br>Andy will probably continue testing today, so more info will follow, but (see<br>&lt;<a href="https://mail.gna.org/public/xenomai-help/2007-08/msg00044.html">https://mail.gna.org/public/xenomai-help/2007-08/msg00044.html
</a>&gt;) at<br>first sight we encountered similar issues on trunk (2.2.x seems unaffected).<br><br>Klaas</blockquote><div><br>We have disabled NMI watchdog like Gilles Chanteperdrix suggested in his previous message.<br>
<br>For the moment We have no hard locks anymore. The linux kernel used is still <a href="http://2.6.20.9">2.6.20.9</a> with ipipe patch 1.8-08.<br>We use branch 2.3.x of Xenomai (Last changed Revision 2898). The only thing We have changed is turning off the &quot;NMI watchdog&quot;.
<br><br>There is no obvious reason why this happened (according to us), but it may have something to do with the AGP bus (we turned it OFF in this kernel, it was already turned OFF in the previous tests, but it was ON in the first tests).
<br><br>For seeing if this system will not hard lock anymore, the system will stay on this weekend (continuously running xeno-tests with high loads). We will inform you of the results after the weekend.<br><br>thanks and greetings, andy
<br></div><br></div><br>

------=_Part_170776_21236327.1186758330861--

