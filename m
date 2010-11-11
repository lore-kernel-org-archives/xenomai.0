Message-ID: <4CDBA67D.5030100@domain.hid>
Date: Thu, 11 Nov 2010 09:17:01 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <169292FFF5F27141906C787A21B56C402E4320953C@RD01.rd.local>	<201011101343.19148.smolorz@domain.hid>
	<169292FFF5F27141906C787A21B56C402E4320954C@RD01.rd.local>
In-Reply-To: <169292FFF5F27141906C787A21B56C402E4320954C@RD01.rd.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Socket can devices?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Bach Madsen <abm@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/10/2010 03:32 PM, Anders Bach Madsen wrote:
> Thank you very much for the clarification, but this just raises my next question. How can I use canFestival and the RTDM socket api? I can't seem to find any information on this, not on the xenomai page or on the canfestival page. 

Check:

http://www.canfestival.org/documentation/supported-platforms-and-can-devices

> Are there anybody who is using canfestival together with RTDM can drivers? And can you provide a pointer to where I can find more information or provide some. That you be of great help.

There are people using CanFestival with Xenomai's RT-Socket-CAN. IIRC,
it can be selected with:

 ./configure --timers=xeno --can=socket ...

Maybe you can get more useful infos from the CanFestival mailing list.

Wolfgang.

