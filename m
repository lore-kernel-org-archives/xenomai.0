Message-ID: <49F6A5B3.1060909@domain.hid>
Date: Tue, 28 Apr 2009 08:44:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
	<1240487288.6990.71.camel@domain.hid>
	<Pine.LNX.4.64.0904271229410.719@domain.hid>
	<49F640A0.4010904@domain.hid> <49F64500.50901@domain.hid>
	<Pine.LNX.4.64.0904271720580.6463@domain.hid>
	<49F69187.9030402@domain.hid>
	<Pine.LNX.4.64.0904272323360.11293@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904272323360.11293@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Lockups on a new Celeron-430 system detected and
 resolved.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Martin Shepherd wrote:
> On Tue, 28 Apr 2009, Gilles Chanteperdrix wrote:
>>> ...
>> On my side, disabling NO_HZ is enough to make the issue disappear. So, I
>> am back to my first observation: it looks like a bad interaction between
>> the I-pipe and the NO_HZ code. And it happens when Linux timing is based
>> on another timer than the intercepted local APIC timer.
> 
> Given these two alternative ways of working around this problem, do
> you recommend disabling NO_HZ, or disabling the two timers? I don't
> have a clear picture of how these two options affect Xenomai,
> particularly in the case of code that has to periodically swap between
> the Xenomai and linux domains.

I would recommend disabling NO_HZ, I think it is mostly useless for a
real-time system. Having separated timer handling for Xenomai and Linux
should result in improved performance. Though I am not so sure.

-- 
					    Gilles.

