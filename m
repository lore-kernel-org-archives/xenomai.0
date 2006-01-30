Message-ID: <fd6a47a90601301517q77732fabm@domain.hid>
Date: Tue, 31 Jan 2006 00:17:06 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-help] RTDM timing problems
In-Reply-To: <43DE5E05.1030302@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7090_4941810.1138663026187"
References: <200601301611.53089.lbocseg@domain.hid> <43DE5E05.1030302@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_7090_4941810.1138663026187
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Jan,

Can't you start it with a short Linux user-space app upon startup ? Doesn't
even need to go realtime.

I'm planning to try this as I want to start two unrelated Xenomai processes
which need the timer for timeouts (obviously in a perpetual effort to test
the Xenomai kernel ;-))

Jeroen.


This makes me scream again for that damn timer being started
> AUTOMATICALLY! I guess Philippe knows what I'm talking about... ;)
> Meanwhile, we should state this in the docs. At least for 2.0.x, this
> will remain true anyway.
>

------=_Part_7090_4941810.1138663026187
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<div>Jan,</div>
<div>&nbsp;</div>
<div>Can't you start it with a short Linux user-space app upon startup ? Do=
esn't even need to go realtime.</div>
<div>&nbsp;</div>
<div>I'm planning to try this as I want to start two&nbsp;unrelated Xenomai=
 processes which&nbsp;need the timer for timeouts (obviously&nbsp;in a perp=
etual effort to test the Xenomai kernel ;-))</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">This makes me scream again for t=
hat damn timer being started<br>AUTOMATICALLY! I guess Philippe knows what =
I'm talking about... ;)
<br>Meanwhile, we should state this in the docs. At least for 2.0.x, this<b=
r>will remain true anyway.<br></blockquote></div>

------=_Part_7090_4941810.1138663026187--

