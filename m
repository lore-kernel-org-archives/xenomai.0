Message-ID: <4BF438F6.3050807@domain.hid>
Date: Wed, 19 May 2010 21:16:06 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>	<4BF251EC.7040605@domain.hid>	<4BF267D3.4040500@domain.hid>	<4BF28401.6060503@domain.hid>	<4BF28B0C.3080705@domain.hid>	<4BF2AB19.5060701@domain.hid>	<4BF2DF77.90806@domain.hid>	<4BF2F73C.7070605@domain.hid>	<4BF3045E.5080707@domain.hid>
	<4BF31010.2080003@domain.hid>	<4BF31386.4030402@domain.hid>
	<4BF31C83.5070109@domain.hid> <4BF37BFD.6030709@domain.hid>
In-Reply-To: <4BF37BFD.6030709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Question about getting system time
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On 19/05/10 07:49, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Just like it seems to be the case for Steve (unless I misunderstood his
>> reply), it is very useful for us being able to time-stamp events in RT
>> context that need to be correlated with events stamped in non-RT
>> (including non-Xenomai) parts or even on other systems: (offline) data
>> fusion, logging, tracing. I even bet that this is currently the major
>> use case for synchronized clocks, only a smaller part already has the
>> need to synchronize timed activities on a common clock source. But there
>> is huge potential in the second part once we can provide a stable
>> infrastructure.
> 
> I already had such issues, and I did not solve them by modifying Xenomai
> core.

I'm using Xenomai for scientific data acquisition, so I'm quite
interested to the issue. Can I ask you to detail how you solved the issue?

Maybe it's not much related, but there is any possibility to synchronize
either linux or xenomay clocks to an external clock source, let say the
GPS timing signal from a GPS receiver?

Thanks. Cheers,
-- 
Daniele

