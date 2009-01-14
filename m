Message-ID: <496DF150.8050606@domain.hid>
Date: Wed, 14 Jan 2009 15:06:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <496DEB16.5060803@domain.hid> <496DEE61.80706@domain.hid>
	<496DEFEA.5000709@domain.hid>
In-Reply-To: <496DEFEA.5000709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Clock drift.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Hi,
>>>
>>> I run clocktest on a system here, not running NTP, using
>>> CONFIG_GENERIC_CLOCKEVENT, with a systematic drift of 3us/s. How can
>>> this happen? Does it come from the error due to the multiply and shift
>>> used for tsc to/from ns conversions ?
>>>
>> - ipipe_request_tickdev() returning a timer freq we don't like?
> 
> Well, I would expect ipipe_request_tickdev() to return the same
> frequency as the one used by Linux.
>

Yes it does. But this value is used by Xenomai code.

>> - does using your generic arith ops instead of the arch-dependent fast ops help?
> 
> Linux itself uses a multiply and shift strategy, so maybe the
> computation of the multiply and shift factors done by Xenomai does not
> find the same result as the one used by Linux?
> 

Time to involve printk() in this battle.

-- 
Philippe.

