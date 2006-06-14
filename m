Message-ID: <448FD5EC.4060109@domain.hid>
Date: Wed, 14 Jun 2006 03:25:00 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid>	<448E9E8B.70809@domain.hid>	<448EA7F7.5000802@domain.hid>	<448EB038.8070802@domain.hid>	<448EE593.7010809@domain.hid>	<448EF022.1040901@domain.hid>	<17550.61982.685449.470866@domain.hid>
	<448EFCC5.60308@domain.hid>
In-Reply-To: <448EFCC5.60308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > Redone the check here on a Centrino 1.6Mhz, and still have roughly 
>> x20  > improvement (a bit better actually). I'm using Debian/sarge 
>> gcc 3.3.5.
>>
>> I think I remember that Pentium M has a much shorter mull instruction
>> than other processors of the family.
>>
>
> That would explain. Anyway, as John Stulz put it:
> "math is hard, lets go shopping!"
>

Heh.  Appropriate that his name (Stultz) comes up here, as his 
generic-time (GTOD)
patchset looks headed for 2.6.18, bringing with it a full re-working
of linux timers / timeofday.  IN this new world, time is kept on 
free-running counters.

Ive been running this patchset on my soekris for some time, since
GTOD detects that the TSC counts slowly, calls it insane, and does timing
with the PIT.

With GTOD, writing a new clocksource driver is easy, enough so I could 
do it.
My clocksource patch uses the 27 mhz timer on the Geode CPU.
Once the TSC is de-rated, mine becomes the best clocksource, and GTOD 
switches to it.

All of which is to say ..
new mainline code is coming, should this current rework notion wait,
given that its will all need revisited again later

