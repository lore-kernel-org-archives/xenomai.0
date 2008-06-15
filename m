Message-ID: <4854CF37.20001@domain.hid>
Date: Sun, 15 Jun 2008 10:13:43 +0200
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <4850DC9D.4010607@domain.hid>	<2ff1a98a0806120208n48d15ed6m4e67b582dced1ba3@domain.hid>
	<48510808.9020304@domain.hid> <485174A7.7040505@domain.hid>
	<485227E2.3030603@domain.hid> <48523BE4.8070403@domain.hid>
	<48523E11.40702@domain.hid>
In-Reply-To: <48523E11.40702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High latencies on Core2Duo
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Philippe Gerum wrote:
>> Sebastian Smolorz wrote:
>>> Philippe Gerum wrote:
>>>> Could you run another trace with that patch applied? TIA,
>>>
>>> Here it comes.
>>>
>>
>> Thanks. Is the latency spot regularly happening at the same place
>> after a few runs,
>> or rather randomly?
> 
> 
> I can for sure activate it with a kernel compilation with make -j2.
> Without load, it is more or less random and more seldom.
> 

Could you try booting with idle=poll just to make sure that we don't get trapped
into long wakeup latency from some idling instruction? We explicitly avoid mwait
unless forced to use it by a bootparam, but maybe something goes wrong with the
default idle code as well.

FYI, I have latency spots of the same magnitude on a Dell precision m65 laptop
here too, but I also have latency figures  < 5 us under extreme load on a
four-way Opteron-based workstation (Fujitsu Siemens) with the very same
pipeline+Xenomai combo, so there is a significant risk that a hw issue (possibly
chipset) bites us here.

TIA,

-- 
Philippe.

