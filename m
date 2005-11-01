Message-ID: <4367BCD8.40405@domain.hid>
Date: Tue, 01 Nov 2005 12:07:04 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <434FD878.4090908@domain.hid> <434FF887.7020406@domain.hid>
	<43512132.6010805@domain.hid>
In-Reply-To: <43512132.6010805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Benchmarking Plan
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
Cc: Takis <panagiotis.issaris@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:

>
>>> This is a partial roadmap for the project, composed of the currently
>>
> Ah! I just _knew_ you would jump in as expected. The teasing worked :o)
>
well done !   Its the mark of a great leader to get folks to do what he 
wants,
while making them think its their idea ;-)

(and I imagine thats why you ccd Takis too :-)

[lots of snippage, thruout]

>>
>> LiveCD has a few weaknesses though:
>>
>> - cant test platforms w/o cdrom
>
>
> I also think that's a serious issue. Aside of the hw availability 
> problem (e.g. non-x86 eval boards), having to burn the CD is one step 
> too many when time is a scarce resource. It often prevents to run it 
> as a fast check procedure even in the absence of any noticeable 
> problem. IOW, you won't burn a CD to run the tests unless you are 
> really stuck with some issue. So a significant part of the interest of 
> having a generic testsuite is lost: you just don't discover potential 
> problems before the serious breakage is already in the wild.
>
One thing that would help expand LiveCD's usefullness is to be able to :

- mount pirt.iso in loopback on a host (my laptop),
- export it via NFS to box-under-test,
- use pxelinux to feed LiveCD's kernel(s?)  to box when it boots.

I tried to do this, and IIRC ran into trouble with absolute symlinks
from /etc.ro to /etc.   The absoluteness fouls things when the ISO
is mounted on forex: /media/cd.

I poked a bit at trying to convince NFS to resolve them as if they
were used within a chroot jail, but I dont know enough about that.



>> - manual re-entry of data is tedious,
>> - no collection of platform data (available for automation)
>> - spotty info about cpu, memory, mobo, etc
>
which is largely user-supplied, so it can be wrong.

>> - no unattended test (still true?)
>
>
> - unfiltered preposterous data. Sometimes, data sent are just rubbish 
> because of well-known hw-related dysfunctioning or misuse of the 
> LiveCD. This perturbates the results uselessly.
>
Any ideas on how to reject these outliers ?
(defer til we have statistical analysis in place ?)

> - difficulties so far to really get a sensible digested information 
> out of the zillions of results, aside of very general figures (e.g. 
> best performer). But this is more an issue of lack of data 
> post-processors than of the LiveCD infrastructure itself.
>
yep.  And we *need* platform data to start to categorize them by platform,
important config choices, etc. We should see narrower ranges of results,
and be more able to reject the junk.

<snip>

> Additionally, LiveCD is a really great tool when it comes to help 
> people figuring out whether their respective box or brain have a 
> problem with the tested software, i.e. by automatically providing a 
> sane software (kernel+rtos) configuration and the proper way to run it 
> quite easily, a number of people could determine if their current lack 
> of luck comes from their software configuration, or rather from a more 
> serious problem.
>
yeah.  pre-built world saves a lot of early thrashing.



>> - testsuite/cruncher ?
>>
>
> The cruncher measures the impact of using the interrupt shield, but 
> this setting is now configured out by default since a majority of 
> people don't currently need it. Shield cost/performances are still 
> useful to know though.
>
OK.  adding 1 call to cruncher is simple.  Over time we *may* collect 
enough data to
make some A (shields up!)  vs B (shields down!) comparisons. 
But I dont see the data to distinguish A, B - dont we need the 
xeno/ipipe equivalent
of /proc/config.gz to do this ?

wrt testsuite/README cruncher notes, is this useful info ?

(manual insmods here...)
soekris:/usr/realtime/2.6.14-ski9-v1/testsuite/cruncher# cruncher
Calibrating cruncher...11773, done -- ideal computation time = 10023 us.
1000 samples, 1000 hz freq (pid=4183, policy=SCHED_FIFO, prio=99)
--------
Nanosleep jitter: min = 60 us, max = 192 us, avg = 77 us
Execution jitter: min = 39 us (0%), max = 72 us (0%), avg = 51 us (0%)
--------
Segmentation fault

soekris:/usr/realtime/2.6.14-ski9-v1/testsuite/cruncher# run
*
*
* Type ^C to stop this application.
*
*
Calibrating cruncher...11769, done -- ideal computation time = 10018 us.
1000 samples, 1000 hz freq (pid=4260, policy=SCHED_FIFO, prio=99)
--------
Nanosleep jitter: min = 62 us, max = 195 us, avg = 79 us
Execution jitter: min = 46 us (0%), max = 77 us (0%), avg = 57 us (0%)
--------



>> 2. send your results to xenomai.testout-at-gmail.com
>> Obviously, an official gna.org ML might be more appropriate.
>>
>
> Will appear soon.

should this wait til xeno-test is upgraded to produce good data ?
ie prevent early bogus data from being submitted.


<snip>

> As said before, the problem that currently exists with LiveCD's data, 
> is that the results are cripled with irrelevant stuff, either because 
> some people just tried it out over a simulator (ahem...), or had a 
> serious hw-generated latency issue that basically made the whole run 
> useless (mostly x86 issues: e.g. SMI stuff, legacy USB emulation, 
> powermgmt, cpufreq artefacts etc.).
>
I added a few /proc/config.gz related checks for CPU-FREQ, X86-GENERIC,
can you suggest additional checks ?




>>
>> 4. xeno-test output parser
>>
>> - /proc/ipipe/Linux-stats parse into pairs of IRQ => CPU0 prop-times
>> - such data is only comparable across kernels with eq IRQ maps
>> - currently wont handle CPU1, SMP data
>> - /proc/interrupts is slightly better parsed.
>> - no detail-parse at all for top-data, needed?
>>
>
> I'm not sure that per-process data would help, just because those are 
> way too volatile and fragmented to be interpreted rationally over a 
> long test period; maybe using per-subsystem data (e.g. /proc/sys 
> crowd) at some point in time would better help.
>



>> prototype only, but its hackable (perl), and Im happy to graft all
>> sorts of horrible experiments on it provisionally to see whats useful.
>> Hopefully a plugin refactoring will become obvious wo too much work.
>>
>
> Warning people: JimC belongs to some kind of hybridization between a 
> Perl Monger and a Real-timer; and the resulting entity is about to go 
> wild... :o>
>
go off the deep end ?  into shark infested waters ?


>
> Generally speaking, I guess that your idea is to collect sensible raw 
> data first, and devise how to process combiantions of them later. 
> Sounds ok for me, and I especially like the idea of providing a 
> specialized ML for that which would be processed by a bot', since 
> anyone would have unlimited access to the data, which might trigger 
> some incentive for anyone to craft other/better digested figures.
>
yup.  inspired by LiveCD, and your reaction to it.

>
> We should make sure to not base all the reasoning on a lo latency / hi 
> cpufreq correlation: this just happens to be wrong, especially 
> x86-wise. Actually, a lot of recent x86 platforms with insanely high 
> CPU freqs are really out of luck when it comes to perform decently in 
> real-time mode, just because the trend of "optimization" is just about 
> killing any determinism one would expect from his hw, by various ugly 
> tricks often aimed at making gamers happy.
>
pentium 4's   31 stage instruction-processing pipeline ? :-O

Im not suggesting its a good measure, but that it would make an 
interesting graph.
latency vs mhz,  with data-points colored per the CPU type.
K6 - navy-blue, K7-royal-blue, K8- sky-blue, P2 - lime-green, P3 - 
mint-green, P4 - forest green


>
> I understand "the plan behind the plan" to be able to somehow predict 
> that some particular sw / hw combo would work and help people figuring 
> out which platform they might want to build their RT solution over 
> using Xeno, and it would be quite an achievement to do that.
>
> For the time being though, I'd suggest that we focus on gathering raw 
> data and digest them according to a few simple metrics first; I'm 
> pretty sure that once a sane and simple infrastructure to do that is 
> in place, we should be able to flesh out the available results. As 
> usual, the key issue is to make such process of producing and using 
> this data becoming a routine; once people get used to something, they 
> tend to improve it quite naturally.


agreed.  Its all blue-sky dreaming atm, and subject to ongoing reality 
checks,
and ongoing discussion ( in little trickles )

jimc

