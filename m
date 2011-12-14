Message-ID: <4EE8717B.3010500@domain.hid>
Date: Wed, 14 Dec 2011 10:50:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1320342817.94951.YahooMailNeo@domain.hid>
	<1320705884.27846.YahooMailNeo@domain.hid>
	<4EB889C1.6020500@domain.hid>
	<990B36E792F1A4488D3E2B1C46FD62D68954BC2EB6@domain.hid>
	<4EB941C8.4010306@domain.hid>
	<1320764897.5719.YahooMailNeo@domain.hid>
	<4EB9572F.3020205@domain.hid>
	<20111203095253.GA2163@domain.hid>
In-Reply-To: <20111203095253.GA2163@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is there Xenomai support for the Freescale P1020
 processor?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org, MichaelPustylnik@domain.hid

On 12/03/2011 10:52 AM, Richard Cochran wrote:
> On Tue, Nov 08, 2011 at 05:22:07PM +0100, Philippe Gerum wrote:
>> So, the answer is maybe, maybe.
>>
>> Maybe it already works, given that P2020 is supported and I don't
>> see much changes in P1020 wrt what the interrupt pipeline needs to
>> know. I won't know before I put my hands on such a beast.
>
> BTW, Philippe, about six weeks ago I tried to run the 3.0 powerpc
> ipipe kernel on the P2020, but it won't compile.  The various irq_
> functions have changed names and signatures, and so the ipipe
> interrupt #ifdef code is out of date.
>

Ok, thanks for the heads up. That should be better now,
http://download.gna.org/adeos/patches/v3.x/powerpc/

> Richard
>


-- 
Philippe.

