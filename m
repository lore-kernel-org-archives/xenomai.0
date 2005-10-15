Message-ID: <43512132.6010805@domain.hid>
Date: Sat, 15 Oct 2005 17:33:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <434FD878.4090908@domain.hid> <434FF887.7020406@domain.hid>
In-Reply-To: <434FF887.7020406@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: Takis <panagiotis.issaris@domain.hid>, xenomai@xenomai.org

Hi Jim,

Jim Cromie wrote:
> Philippe Gerum wrote:
> 
>>
>> This is a partial roadmap for the project, composed of the currently
> 
> 
> 

Ah! I just _knew_ you would jump in as expected. The teasing worked :o)

>> o Web site.
>>
> Wiki ++ , eventually
>

Yes, separate issue to deal with Bruno and anyone who has some thoughts about 
how to efficiently help people using Xeno, especially newcomers.

>>
>> o Automated benchmarking.
>>
>>     - We are still considering the best way to do that; actually,
>>     my take is that we would just need to bootstrap the thing and
>>     flesh it out over time, writing one or two significant
>>     benchmark tests to start with, choosing a tool to plot the
>>     collected data and push the results to some web page for
>>     public consumption on a regular basis, but so far, we did not
>>     manage to spark this. It's still in the short-term plan,
>>     though, because we currently have neither metrics nor data to
>>     check for basics, and we deeply need both of them now.
>>     ETA: Q4 2005.
> 
> 
> 
> 
> A Xenomai Automatic Benchmarking plan
> 
> 
> Goal is to test xenomai performance so we know when something breaks,
> test it thoroughly enough that we can see / identify systematic, 
> generic, or
> platform specific bottlenecks.
> 

Yes; as a corollary, a tool to routinely, better and earlier check whether we 
are on the good track or not regarding core updates without having to wait for a 
blatant breakage to send us the wake up call.

> Benchmarking
> 
> wrt bootstrap approach; scripts/xeno-test already runs 2
> of 3 testsuite/* tests, and collects the results along with useful
> platform data.  If new testsuite/* stuff gets added, its trivial to
> call them from xeno-test.

Indeed; xeno-test has always been meant to provide a simple client-side tool 
available from regular Xenomai distros for running tests/benchmarks that could 
be extended over time. The idea underlying this being that giving people easy 
means to send us the test data output by plain simple standard stuff they find 
in their Xeno distro is way more efficient than asking them to connect to some 
site and download specialized tools to do that. The extra middle step is often 
the one too many that kills the initial incentive to help.

> 
> Automatic
> 
> Automating the process is trickier than usual, due to need for
> cross-compile (in some situations), NFS root mounts for remote boxes,
> remote or scripted reboots, etc.  Ive cobbled up a rube-goldberg
> arrangement, which is out-of-scope for this message, will discuss all
> that separately.
> 
> Characterization
> 
> RPM mentioned plotting, I take that to mean heavy use of graphs to
> characterize and ultimately to predict xenomai performance over a
> range of criteria, for any given platform.
>

At least characterize the current state, yes.

> LiveCD had the right idea wrt this - collecting platform info and
> performance data on any vanilla PC with a CD-ROM drive.  And make this
> data available on a website, allowing users to compare their results
> with others done on similar platforms.
> 
> LiveCD has a few weaknesses though:
> 
> - cant test platforms w/o cdrom

I also think that's a serious issue. Aside of the hw availability problem (e.g. 
non-x86 eval boards), having to burn the CD is one step too many when time is a 
scarce resource. It often prevents to run it as a fast check procedure even in 
the absence of any noticeable problem. IOW, you won't burn a CD to run the tests 
unless you are really stuck with some issue. So a significant part of the 
interest of having a generic testsuite is lost: you just don't discover 
potential problems before the serious breakage is already in the wild.

> - manual re-entry of data is tedious,
> - no collection of platform data (available for automation)
> - spotty info about cpu, memory, mobo, etc
> - no unattended test (still true?)

- unfiltered preposterous data. Sometimes, data sent are just rubbish because of 
well-known hw-related dysfunctioning or misuse of the LiveCD. This perturbates 
the results uselessly.

- difficulties so far to really get a sensible digested information out of the 
zillions of results, aside of very general figures (e.g. best performer). But 
this is more an issue of lack of data post-processors than of the LiveCD 
infrastructure itself.

> 
> These things could be readily fixed, but xeno-test already does
> everything but the data upload.
> 
> The real value of LiveCD was the collection of data across hundreds of
> different platforms, and its promise was that studying the data would
> reveal the secrets of better performance on any platform.
> 

Additionally, LiveCD is a really great tool when it comes to help people 
figuring out whether their respective box or brain have a problem with the 
tested software, i.e. by automatically providing a sane software (kernel+rtos) 
configuration and the proper way to run it quite easily, a number of people 
could determine if their current lack of luck comes from their software 
configuration, or rather from a more serious problem.

> 
> A Plan (sort of)
> 
> 1. xeno-test currently (patch pending) executes following commands,
> and captures output in a reasonably parseable format; a set of chunks:
> 

[snip]

> also need these:
> - xenomai svn revision-level, perhaps as part of xeno-info,config ?

Ok, Gilles is handling this.

> - what else ?  Anything added now is info-opportunity later
> - testsuite/cruncher ?
> 

The cruncher measures the impact of using the interrupt shield, but this setting 
is now configured out by default since a majority of people don't currently need 
it. Shield cost/performances are still useful to know though.

> 2. send your results to xenomai.testout-at-gmail.com
> 
> Please run xeno-test, attach the resulting file(s), and send it to
> above address.  This collects data now, we can decide where to host it
> when website is up.  Obviously, an official gna.org ML might be more
> appropriate.
> 

Will appear soon.

> # run something like this
> xeno-test -T300 -sh -w2 -L -N ~/xenotest-outputs/foo
> 
> xeno-test will write all test output to a file:
> ~/xenotest-outputs/foo-$timestamp.  The timestamp gives unique-ness,
> and you can choose which files 'look right' after inspecting several
> trial-runs
> 
> FWIW - I could poach LiveCD code to upload to LiveCD site.
> That might be handy if it doesnt break the process that populates the data
> onto the web-page (which must parse for the data).
> 

As said before, the problem that currently exists with LiveCD's data, is that 
the results are cripled with irrelevant stuff, either because some people just 
tried it out over a simulator (ahem...), or had a serious hw-generated latency 
issue that basically made the whole run useless (mostly x86 issues: e.g. SMI 
stuff, legacy USB emulation, powermgmt, cpufreq artefacts etc.).

> 3. mail handler
> 
> Ive previously written a mail-bot to do poll a pop-mbox, and collect
> attachments.  I just need to dredge it out or rewrite it.  Once I do,
> I'll just run it on that inbox to collect your results.  Eventually,
> the data will be uploaded somewhere for everyone to peruse.
> 
> If we go with a xenotest-results-at-gna.org, I can just subscribe my new
> acct to the new list :-)
> 
> 4. xeno-test output parser
> 
> Ive written a parser to chop the formatted output into chunks, and
> then parse some of those chunks into hashes.  Soon Ill define some
> matching db-tables for the (well mannered) data
> 
> 'well mannered' means lots of limitations atm;
> 
> - /proc/ipipe/Linux-stats parse into pairs of IRQ => CPU0 prop-times
> - such data is only comparable across kernels with eq IRQ maps
> - currently wont handle CPU1, SMP data
> - /proc/interrupts is slightly better parsed.
> - no detail-parse at all for top-data, needed?
> 

I'm not sure that per-process data would help, just because those are way too 
volatile and fragmented to be interpreted rationally over a long test period; 
maybe using per-subsystem data (e.g. /proc/sys crowd) at some point in time 
would better help.

> prototype only, but its hackable (perl), and Im happy to graft all
> sorts of horrible experiments on it provisionally to see whats useful.
> Hopefully a plugin refactoring will become obvious wo too much work.
> 

Warning people: JimC belongs to some kind of hybridization between a Perl Monger 
and a Real-timer; and the resulting entity is about to go wild... :o>

> 
> 5. Data-Base
> 
> The data extracted above needs to be written to a database, perhaps in
> multiple, increasingly cooked, redundant forms.  Point is, we can do
> it incrementally, a chunk at a time.
> 
> - store chunks as raw-text, along w indexing
> - write a query to replicate full-report text from the chunks
> - many chunk-types have table designed to match
> - some chunk-types insert 1 row into chunk-typeX-table, others 2+
> - latency-data has lots of data
> --- raw interval data (min, avg, max, ovfl)
> --- histograms of data (for min, avg, max)
> - chunk-types index VS md5(raw-text)
> -- ok: uname - semi-regular, (various kernel suffixes)
> -- ok: /prc/cpuinfo - almost (fuzz on  mhz, bogomips)
> -- no: /proc/config.gz - contains arbitrary date, reveals no commonality
> 
> At first, I dont plan on much data-normalization, indexification.  Id
> like to be able to later go back, and 'histogram' each field; many
> will have a discrete set of values (ex: config setting of
> CONFIG_PREEMPT, presense of /proc/ipipe/Linux_stats, etc)
> 
> makefile-esque production semantics would be useful here, esp as a
> cross-check against same implemented in the DB.
> 

Generally speaking, I guess that your idea is to collect sensible raw data 
first, and devise how to process combiantions of them later. Sounds ok for me, 
and I especially like the idea of providing a specialized ML for that which 
would be processed by a bot', since anyone would have unlimited access to the 
data, which might trigger some incentive for anyone to craft other/better 
digested figures.

> 
> 6. Plotting
> 
> The best use of any collected data is to graph it many different ways,
> and so to understand it.  Gnuplot is a clear choice for this. (maybe
> Octave?)
> 

No idea. I'll come back discussing this issue when I'm older...

> Biggest issue is preparing data for gnuplot, which seems to want files
> of space/tab-separated data.  We'll have to provide some db-extract
> mechanism (or direct from file-set, using parser+plugin) to select the
> right data for each plot, format it accordingly, and run the plot.
> 
> Ive yet to try to plot anything from my collected files, so I dont
> have real insight into the issues/difficulties.  But heres a few
> hastily-concieved examples:
> 
> judging the data-set itself:
> 
> - select count(*) from .. where X group.by Y
> - see dist of samples across Y
> - identify strongly bucketized vars
> - ex:
> -- how many of each cpuinfo.model-name ? (expect finite set)
> -- how many of each cpuinfo.cpu-mhz foreach above ? (1..dozen foreach 
> model)
> -- how many old cpuinfo.steppings ? (curiosity)
> --- select count(*)
> ---  group by cpuinfo.model_name
> ---  having count(cpuinfo.stepping) > 1
> 
> looking for performance factors:
> 
> - correlations (outputs vs inputs/features)
> - boolean features should correlate strongly if related
> - multi-val features too
> - ex:
> -- max-latency vs bogo-mips foreach arch/cpu-type
> 
> - histograms of correlated variables (as idenfified above)
> -- display for hints wrt causes
> 
> - for variables/fields with certian value-distributions,
> -- group-by those fields
> -- plot, and look for clustering
> -- when kernel.config.PREEMPT becomes a queryable-field, analysis flows
> --- =PREEMPT_NONE, =PREEMPT_RT, etc... with
> 
> - curve fitting vs data subsets
> -- posit: latency is-inverse-to bogo-mips
> -- hypothesize: latency * bogo-mips == quality-metric-weak
> -- graph it, per cputype
> -- select different subsets of cputype
> --- x86, 586 +/- TSC, MMX, GENERIC, etc..
> --- does spread narrow as subset is narrowed ?
>

We should make sure to not base all the reasoning on a lo latency / hi cpufreq 
correlation: this just happens to be wrong, especially x86-wise. Actually, a lot 
of recent x86 platforms with insanely high CPU freqs are really out of luck when 
it comes to perform decently in real-time mode, just because the trend of 
"optimization" is just about killing any determinism one would expect from his 
hw, by various ugly tricks often aimed at making gamers happy.

> 
> GOALS - MILESTONES
> 
> 0. that which is measured, is quantitatively improved (fact, not goal)
> 
> 1. rich, automatically collected data makes it possible to compare
> data from different people.
> 
> Most of us are stuck with 1 platform, so its difficult to find out
> what effects clock-rate has on latency, for a given platform. IOW,
> what is the "latency vs clock-rate" (Lat-v-clk)
> 
> With pooled data, for common PC platforms at least (ex p4, k8), we can
> collect a large pool of data, enough to make predictions about
> Lat-v-clk.  Graphs are encouraged.
> 
> 2. Repeat for Lat = f(clk-rate, mem-size) over (select ..)
>   Plot as elevation-map
> 
> 3. Somebody hacks the cpufreq clock-control, and reruns the test on a
> progressively throttled cpu.  This represents a (more) highly
> controlled study, and comes with lots of pretty graph jpegs showing
> the effect clearly.  This becomes pseudo-reference data.
> 
> 4. Somebody examines predictions against ref3-data.
> Start actually doing the analysis that I handwaved in L<Plotting>
> 
> 5. Others start to repeat earlier experiments, attempting to replicate
> the results.  Where differences persist, they collaborate to
> distinguish the reasons.  We improve our understanding of the tests,
> and the processes around them.
> 
> 6. people explore xeno-test options.
> 
> They run batteries of tests while varying -options, and create many
> graphs which illustrate various performances:
> 
> - what happens when sampling period shrinks towards the max-latency
> seen in the previous test-run ?  Does xenomai panic, muddle on,
> error-out, give proper warning, etc ??
> 
> - whats the histogram look like when number of buckets is greatly
> increased ?  Does it start to look like a comb with lots of broken
> teeth ?  Can it be adequately smoothed by a plotting function ?
> 
> - what kind of results can you get from using -W "$command $args"
> with the wide range of benchmark tests (which themselves serve as a 
> workload).
> 
> 7. people hack parse-testout.pl.
> 
> Each person in 6 should consider hacking the chunk-specific text
> processing into parse-testout.pl.  I'll look for a workable plug-in
> scheme to simplify & extend how and what can be done.  We get
> use-cases at least, maybe bits of automation, and probably a workable
> alpha version.  (Ill try this at some point)
> 
> 8. Patterns of analysis emerge, and develop into a "howto gnuplot your
> xenotest-perfdata".  With these, we better understand what the
> automation must do.
> 
> Presumably this is gnuplot centric; we start with a gnuplot script,
> and template/parametrize it.  With it, some plugin code to prep the
> data-files to produce plots.
> 
> This is also where Im most uncertain how things will look.
> 
> 
> 9. workable plotting automation ?
> 
> 10. Growing sample-set attracts study
> 
> Growth of a quality-assessable dataset, and workable automation (9)
> lures hackers to madly correlate performance numbers against possible
> causal factors.  Much of this is likely in x86 data, since platform is
> so widely available.
> 
> 11. somebody rewrites xeno-test
> 
> Its currently in bash, and (prolly) uses constructs that wont work on
> busybox.  It also has some bugs in workload management.
> 
> 12. and I want a pony.
> 
> 
> 
> NOTES
> 
> theres a difference between benchmarks and tests, and Ive munged
> things already by saying test until now.  But calling everything a
> benchmark is just as clumsy.
> 
> Tests are things that can pass or fail, good ones give an indication
> of what broke.  Ideally, a test demonstrates that a bug exists, and
> that the patch it was submitted with fixes that bug.  Then the test
> gets added to the regression-test framework that uses them to guard
> against breakage. (hey - I said ideally).
> 
> Turning benchmark tests into regression tests is easy - once we know
> how a given platform *should* perform.  Obviously, thats the goal
> stated at the top.
> 

I understand "the plan behind the plan" to be able to somehow predict that some 
particular sw / hw combo would work and help people figuring out which platform 
they might want to build their RT solution over using Xeno, and it would be 
quite an achievement to do that.

For the time being though, I'd suggest that we focus on gathering raw data and 
digest them according to a few simple metrics first; I'm pretty sure that once a 
sane and simple infrastructure to do that is in place, we should be able to 
flesh out the available results. As usual, the key issue is to make such process 
of producing and using this data becoming a routine; once people get used to 
something, they tend to improve it quite naturally.

> 
> 
> COMMENTS ?
>
> Lets pretend that we're developing content for a wiki ;-)
> 
> Im accepting 2 kinds of comments
> 
> - those where you change the subject
> - the rest ;-)
> 
> Im making the inference that if you change the message-subject;
> 
> - you think the topic is a proto-wiki-node (not necessarily a page)
> - youre keeping the message on that topic
> - youre actively adapting subjects on such threads that you participate in
> -- we strike balance on node-growth rate (is there a just right ?)
> 
> if you dont change subject,
> - above rules dont apply, stream of conciousness is fine.
> - or youre adding to / correcting the previous 'wiki-node'
> 
> I dont prefer either kind of post a-priori; this is an experiment in
> social/community self-organization on an ML.  Its not supposed to be 
> laborious.
> Lets see what happens.
> 
> tia
> jimc
> 
> 
> 


-- 

Philippe.

