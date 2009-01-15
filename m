Message-ID: <496F36EE.1070305@domain.hid>
Date: Thu, 15 Jan 2009 13:15:26 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <496DEB16.5060803@domain.hid> <496DEE61.80706@domain.hid>
	<496DEFEA.5000709@domain.hid> <496DF150.8050606@domain.hid>
In-Reply-To: <496DF150.8050606@domain.hid>
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
>> Philippe Gerum wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Hi,
>>>>
>>>> I run clocktest on a system here, not running NTP, using
>>>> CONFIG_GENERIC_CLOCKEVENT, with a systematic drift of 3us/s. How can
>>>> this happen? Does it come from the error due to the multiply and shift
>>>> used for tsc to/from ns conversions ?
>>>>
>>> - ipipe_request_tickdev() returning a timer freq we don't like?
>> Well, I would expect ipipe_request_tickdev() to return the same
>> frequency as the one used by Linux.
>>
> 
> Yes it does. But this value is used by Xenomai code.

It turns out that the frequency used to convert tsc to ns is the cpu
frequency (which is kind of a misnomer, since your emulated tsc on arm
does not run at cpu frequency), which is computed though it should have
the same value as the timer frequency but is suject to rounding errors.

-- 
                                                 Gilles.

