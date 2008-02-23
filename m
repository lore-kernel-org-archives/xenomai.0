Message-ID: <47C0B12D.5010200@domain.hid>
Date: Sun, 24 Feb 2008 00:50:05 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C02113.7070005@domain.hid>	<18368.23256.85461.492726@domain.hid>	<47C06052.2020406@domain.hid>	<18368.26112.776987.660255@domain.hid>
	<47C06CAD.6060200@domain.hid>
In-Reply-To: <47C06CAD.6060200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/4] Fix and optimize xnlock_put
Reply-To: philippe.gerum@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > Gilles Chanteperdrix wrote:
>>  > > Jan Kiszka wrote:
>>  > >  > As the #ifdef forest was cut down, I once again looked at xnlock_put.
>>  > >  > Why do you have this safety check for the owner also in production code?
>>  > > 
>>  > > Because only one broken xnlock_put could entail a chain reaction of
>>  > > broken xnlock sections with code on multiple CPU violating critical
>>  > > sections. With the test, we prevent the chain reaction. But I agree this
>>  > > check should not be silent.
>>  > 
>>  > When there is a bug, then there is bug and we are hosed. That's why we
>>  > have debug checks for finding such cases in advance. Here I was talking
>>  > about such a debug check in a hot path on a _production_ system, and
>>  > that check even had no fault recovery. That appeared pointless to me.
>>  > 
>>  > Just to avoid misunderstandings: This version is not different from the
>>  > old one if XENO_OPT_DEBUG_NUCLEUS is on, the switch which was introduced
>>  > to cover specifically lock debugging.
>>  > 
>>  > Do you have an idea for some cheap fault recovery for broken locking
>>  > that we should put in instead?
>>
>> The fault recovery is to leave the xnlock untouched, in order to avoid
>> the chain reaction I was talking about.
> 
> But you may later deadlock on it when trying to reacquire this
> unbalanced lock. It can help against double releases, granted. Still,
> such cases should be eliminated _ahead_ of release via review, so that
> one can finally go for the fast unchecked version in the matured system.
> 
>> Anyway, I think even production
>> code should contain some sanity checks, and this one looks cheap.
> 
> I'm fine with a simple check as well. But there should be an _option_
> for such checks, even more if they are supposed to be inlined.
> Uninlining reduces this pressure, but it still adds text size to the hot
> path.

I don't think this is strictly equivalent. The cause of deadlock is no
rocket science to diagnose even if it may be painful to fix, so our main
problem is critical section breakage. And this particular kind of bugs
is extremely sensitive to the instrumentation overhead, to the point
where enabling a debug option would turn it into a damned Heisenbug.
Unless you want to create a unique debug option to control each and
every tiny check, you will likely bind it to a more general debug
option, turning on a significant amount of unrelated debug code, which
could in turn affect the bug itself. This is where I agree with Gilles,
I would rather pay peanuts cycles when acquiring a lock on SMP machines
to run this check, than chase wild gooses for days.

Some key issues like obvious critical section breakage deserve
systematic detection, including in the field. Due to their very nature,
maybe you won't be able to trigger some of them elsewhere anyway,
because in some complex application cases (the ones we more often have
with SMP configs), you may just fake part of the operating environment
to debug the application (network feed simulation and so on).

But, and there I tend to agree with you, uninlining the containing code
is definitely something I would combine with such approach, since
I-cache is a precious thing to save. Anyway, measurements will tell.

-- 
Philippe.

