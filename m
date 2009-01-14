Message-ID: <496DEFEA.5000709@domain.hid>
Date: Wed, 14 Jan 2009 14:00:10 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <496DEB16.5060803@domain.hid> <496DEE61.80706@domain.hid>
In-Reply-To: <496DEE61.80706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Clock drift.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai core <Xenomai-core@domain.hid>

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> I run clocktest on a system here, not running NTP, using
>> CONFIG_GENERIC_CLOCKEVENT, with a systematic drift of 3us/s. How can
>> this happen? Does it come from the error due to the multiply and shift
>> used for tsc to/from ns conversions ?
>>
> 
> - ipipe_request_tickdev() returning a timer freq we don't like?

Well, I would expect ipipe_request_tickdev() to return the same
frequency as the one used by Linux.

> - does using your generic arith ops instead of the arch-dependent fast ops help?

Linux itself uses a multiply and shift strategy, so maybe the
computation of the multiply and shift factors done by Xenomai does not
find the same result as the one used by Linux?

-- 
                                                 Gilles.

