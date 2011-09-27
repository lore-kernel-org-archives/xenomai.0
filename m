Message-ID: <4E81BF9B.1030401@domain.hid>
Date: Tue, 27 Sep 2011 14:20:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1316774468.git.richard.cochran@domain.hid>
	<4E7C8EB2.1020308@domain.hid>
	<20110926114118.GA2213@domain.hid>
	<4E8188CB.4040102@domain.hid>
	<20110927120122.GA10155@domain.hid>
In-Reply-To: <20110927120122.GA10155@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC 0/1] Class driver for raw Ethernet packets
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-09-27 14:01, Richard Cochran wrote:
> Again, every MAC driver needs to be tastefully and wisely adapted. I
> don't necessarily need to avoid coalescing. The goal (for me) is *not*
> to provide deterministic Ethernet performance. Instead the RT packets
> should just be delivered ASAP.

This is obviously the point I completely missed. And it makes the whole
thing fairly uninteresting IMHO. If you want to do Ethercat, PowerLink
or Profinet (RT), you do need a certain level of determinism along the
*whole* packet path. And for the latter two, you definitely need RT IRQ
support, Ethercat can be OK to poll in fast setups.

>From that POV, your approach is likely OK. But I doubt its of generic
use, specifically for industrial RT Ethernet.

Jan

PS: You do have a stack, even if you don't like it: driver, packet
layer, application. :)

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

