Message-ID: <7289437c0705110124k60f56384uc0d286023f8b9f0@domain.hid>
Date: Fri, 11 May 2007 10:24:33 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <464426A7.308@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_68644_10845423.1178871873724"
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
	<4642D901.9050304@domain.hid> <1178789171.11688.142.camel@domain.hid>
	<4642E706.7000500@domain.hid> <1178808027.11688.150.camel@domain.hid>
	<464331CF.3090505@domain.hid> <1178810494.11688.188.camel@domain.hid>
	<46433E26.8040307@domain.hid>
	<7289437c0705110056o130c4fd4t419e37f573110d5d@domain.hid>
	<464426A7.308@domain.hid>
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

------=_Part_68644_10845423.1178871873724
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I solved my issue. It's because I kept a previous patch.

On 5/11/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Perrine Martignoni wrote:
> > I tested the final patch and it doesn't work on the file heap.h.
> > It seems I haven't the same code in the file at start. I use
> xenomai-2.3.1.
> > For which version is the patch?
> > Thanks
>
> The patch applies cleanly on v2.3.x branch. Are you sure you have not
> kept the changes made by a previous patch I sent ?
>
> --
>                                                 Gilles Chanteperdrix
>

------=_Part_68644_10845423.1178871873724
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I solved my issue. It&#39;s because I kept a previous patch.<br><br>
<div><span class="gmail_quote">On 5/11/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt; I tested the final patch and it doesn&#39;t work on the file heap.h.<br>
&gt; It seems I haven&#39;t the same code in the file at start. I use xenomai-2.3.1.<br>&gt; For which version is the patch?<br>&gt; Thanks<br><br>The patch applies cleanly on v2.3.x branch. Are you sure you have not<br>kept the changes made by a previous patch I sent ?
<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_68644_10845423.1178871873724--

