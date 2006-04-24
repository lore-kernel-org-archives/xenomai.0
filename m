Message-ID: <444D3889.8060209@domain.hid>
Date: Mon, 24 Apr 2006 22:43:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: xeno-test updates [patch]
References: <4447D9CA.9010809@domain.hid> <444AED9A.7040009@domain.hid>
In-Reply-To: <444AED9A.7040009@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
> Jim Cromie wrote:
> 
>>
>>
>> Ive started adding to xeno-test, as outlined previously (plus some)
>>
> <snipped>, except where noted
> 
>> - now run cyclictest and switch, in addition to latency -t 0,1,2
>>
> cycletest now has decent options passed in.
> I havent given any thought to exposing options thru xeno-test's command 
> line.
> 
> Instead, Im thinking of adding statistics, ala latency.
> for that, Im also pondering a new -g 100 option to group the tests for 
> stats-calcs,
> ie given: -g 100 -l 1000 -v
> it would compute statistics on 10 sets of 100 cycles, and report 10 lines.
> Again, this is notional, comments/feedback needed.
>

This would be mainly useful for running different test scenarii - i.e. 
one per cycle? - I guess. But then, would not we have problems 
interpreting the results, since different testcases might lead to 
unrelated data sets? IOW, how would we use such data sets?

>> -  changed the prewired -m email-addy to xenotest.output@domain.hid
> 
> email options now work w/o actually writing a file.
> Also changed default location of file writes to /tmp,
> they no longer get written to $PWD by default
> 

Nice for embedded setups.

> added a -U <url>,  completely untested, but mostly lifted from LiveCD
> This looks necessary, since
>    my hobby-box doesnt have a working mail setup
>    my laptop (and presumably yours) doesnt have a FQDN,
>        which pretty well precludes sending mail to anywhere useful.
>          (Id bet we could span the unwashed winbloze masses, but wheres 
> the sport in that ?  ;-)
> 
> 
> 
>>
>> - now grep more config-items out of config (for non-verbose mode)
>>   latency-killers, PREEMPT, others ?
>>
> added items per RPMs email.
> 
> Im considering stripping the warning issued when CPU_FREQ ia xonfig'd
> warning: CONFIG_CPU_FREQ=y may be problematic.
> I have it in cuz nothing actually changes (can change) it, so its 
> harmless. (I think)
> Its easier than making the list complete,
> and the .config dump covers the reporting.
> 

Sounds reasonable; in any case, .config would be analyzed in case of 
problem.

>>
>>
>> Dont apply yet, not tested recently.
>>
> 
> Its reasonbly tested; we can shake out some more with some distributed 
> testing
> (hint - try it !)
> 

Merged, now. Thanks.

> Heres some tests I ran, files got written..
> 
> ./xeno-test -T 30 -l30 -m
> ./xeno-test -T 30 -l30
> ./xeno-test -T 30 -l30 -L
> ./xeno-test -T 30 -l30 -N foo
> ./xeno-test -T 30 -l30 -LN bar
> ./xeno-test -T 30 -l30 -LN buzz -m
> ./xeno-test -T 5 -l30 -L -m
> ./xeno-test -T 5 -l30 -N /tmp/box- -m
> ./xeno-test -T 5 -l30 -N ~/trucklab/ -w2 -W 'dd if=/dev/hda1 of=/dev/null'
> 
> 
>> Qs
>>
>> - should I run boxstatus just after latency tests or b4 and after (as 
>> currently) ?
>>
>> - /proc/xenomai/* contents are dynamic (ie run by boxstatus) ?
>>
>> - any bits of  boxinfo and boxstatus that should be shuffled around ?
>>
>> - check NPTL availability (kinda overkill, since its absence when 
>> needed is already detected)
>>
>>
>> - anything else come to mind ?
> 
> 
> 
> these are still open, but not crtical.
> 

I think we will discover new stuff to add incrementally, after getting 
some practical experience on the automated data collection issue.

> 
> I hope thats everything for now,
> it needs a good shakedown, and I need a beer.
> 

Eh, I hope you had it by now, otherwise, you must be so damn thirsty... :o>

-- 

Philippe.

