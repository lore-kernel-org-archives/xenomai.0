Message-ID: <444D40AC.3010507@domain.hid>
Date: Mon, 24 Apr 2006 17:18:36 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: xeno-test updates [patch]
References: <4447D9CA.9010809@domain.hid> <444AED9A.7040009@domain.hid>
	<444D3889.8060209@domain.hid>
In-Reply-To: <444D3889.8060209@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jim Cromie wrote:
>>
>> cycletest now has decent options passed in.
>> I havent given any thought to exposing options thru xeno-test's 
>> command line.
>>
>> Instead, Im thinking of adding statistics, ala latency.
>> for that, Im also pondering a new -g 100 option to group the tests 
>> for stats-calcs,
>> ie given: -g 100 -l 1000 -v
>> it would compute statistics on 10 sets of 100 cycles, and report 10 
>> lines.
>> Again, this is notional, comments/feedback needed.
>>
>
> This would be mainly useful for running different test scenarii - i.e. 
> one per cycle? - I guess. But then, would not we have problems 
> interpreting the results, since different testcases might lead to 
> unrelated data sets? IOW, how would we use such data sets?
>

Several observations led me to this idea.
- in normal mode, the prog rewrites the same display line over and over
    it plays-back oddly when you more/cat the file.
- with -v, it prints successive lines, but less info per line (no avg)
    which makes sense, since the avg is at the bottom.
- 1000 lines of output is a boat-load, each is individually 
uninteresting / almost same as others.

with latency, each line/second of the output contains the average of 
*many* samples
10,000 samples of 100uS measures IIRC, and the inner min,max,avg tell us
about the high-frequency jitter,etc in the processes.
Then the multiple samples tell us something about the low-freq jitter.
IOW, we get a glimpse into the ergodicity of the noise
    (I say that, pretending I _understand_ ergodicity)

Whether it applies / makes sense here, Im not at all sure.



>> I hope thats everything for now,
>> it needs a good shakedown, and I need a beer.
>>
>
> Eh, I hope you had it by now, otherwise, you must be so damn 
> thirsty... :o>
>
:-)  Ya gotta try this - simple, but highly addictive.  A sport we can 
*all* play.

http://www.wagenschenke.ch/site/homerun.htm



