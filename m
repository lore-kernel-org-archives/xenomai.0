Message-ID: <e4ef24880710271153qb9c0b27y937f3d87e16f0922@domain.hid>
Date: Sat, 27 Oct 2007 11:53:31 -0700
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <47234083.4000602@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7305_12728872.1193511211403"
References: <e4ef24880710261838l4d1961a5s8117d116be499cee@domain.hid>
	<e4ef24880710262040r718b58f7xa2e5f89156d9024b@domain.hid>
	<e4ef24880710262126g658f3f7ci534ca13df32b2e0e@domain.hid>
	<4723118D.9060807@domain.hid> <472326E6.9080103@domain.hid>
	<47232A0C.60705@domain.hid> <47234083.4000602@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] RTNet in non-TDMA mode?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_7305_12728872.1193511211403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> But my question remains -purely out of interest- why non-rt devices and
> rt devices can _fundamentally_ not share an IRQ?
>


My understanding is adeos-ipipe/xenomai provide an interrupt abstraction
layer underneath Linux.  If there is more than one consumer of an interrupt
it has to be copied/forwarded to all those that need it.  If an IRQ is
shared with an RT application, and the Linux kernel I would imagine this
would create some level of indeterministic RT software.

This is probably a good question for the xenomai, or adeos-ipipe mailing
list.  I am new to these packages, so hopefully I am not providing
misinformation on its functionality.

-Rob

------=_Part_7305_12728872.1193511211403
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">But my question remains -purely out of interest- why non-rt devices and<br>rt devices can _fundamentally_ not share an IRQ?
<br></blockquote></div><br><br>My understanding is adeos-ipipe/xenomai provide an interrupt abstraction layer underneath Linux.&nbsp; If there is more than one consumer of an interrupt it has to be copied/forwarded to all those that need it.&nbsp; If an IRQ is shared with an RT application, and the Linux kernel I would imagine this would create some level of indeterministic RT software.
<br><br>This is probably a good question for the xenomai, or adeos-ipipe
mailing list.&nbsp; I am new to these packages, so hopefully I am not
providing misinformation on its functionality.<br><br>-Rob<br>

------=_Part_7305_12728872.1193511211403--

