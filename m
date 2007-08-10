Date: Fri, 10 Aug 2007 09:54:51 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
In-Reply-To: <46BC1494.2010303@domain.hid>
Message-ID: <Pine.LNX.4.64.0708100951160.23969@domain.hid>
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid> 
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid> 
	<46BAF956.5090401@domain.hid>
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
	<1186676576.4978.12.camel@domain.hid> <46BC1494.2010303@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 10 Aug 2007, Jan Kiszka wrote:
> Philippe Gerum wrote:
>>> The linux kernel used now is 2.6.20.9 with ipipe patch 1.8-08.
>>> We use branch 2.3.x of Xenomai (Last changed Revision 2898)
>>>
>>> While running xeno-test, the system locks-up just after the latency
>>> test.
>>
>> Confirmed here. Houston, we do have a problem with the switchtest, or
>> soimething this test triggers (and not necessarily the FPU mgmt)...
>
> Any news on this? Does it already happen by just running switchtest
> stand-alone (it doesn't do so here at least)? Is this a pure 2.3.x
> issue, or is it also visible for 2.4? /me currently rebuilds some trees
> to assess the local situation.

Andy will probably continue testing today, so more info will follow, but (see
<https://mail.gna.org/public/xenomai-help/2007-08/msg00044.html>) at
first sight we encountered similar issues on trunk (2.2.x seems unaffected).

Klaas


