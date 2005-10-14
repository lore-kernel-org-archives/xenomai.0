Message-ID: <434FF887.7020406@domain.hid>
Date: Fri, 14 Oct 2005 12:27:19 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <434FD878.4090908@domain.hid>
In-Reply-To: <434FD878.4090908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Benchmarking Plan  [Was: Partial roadmap]
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
Cc: xenomai@xenomai.org

Philippe Gerum wrote:

>
> This is a partial roadmap for the project, composed of the currently


> o Web site.
>
Wiki ++ , eventually

>
> o Automated benchmarking.
>
>     - We are still considering the best way to do that; actually,
>     my take is that we would just need to bootstrap the thing and
>     flesh it out over time, writing one or two significant
>     benchmark tests to start with, choosing a tool to plot the
>     collected data and push the results to some web page for
>     public consumption on a regular basis, but so far, we did not
>     manage to spark this. It's still in the short-term plan,
>     though, because we currently have neither metrics nor data to
>     check for basics, and we deeply need both of them now.
>     ETA: Q4 2005.



A Xenomai Automatic Benchmarking plan


Goal is to test xenomai performance so we know when something breaks,
test it thoroughly enough that we can see / identify systematic, generic, or
platform specific bottlenecks.

Benchmarking

wrt bootstrap approach; scripts/xeno-test already runs 2
of 3 testsuite/* tests, and collects the results along with useful
platform data.  If new testsuite/* stuff gets added, its trivial to
call them from xeno-test.

Automatic

Automating the process is trickier than usual, due to need for
cross-compile (in some situations), NFS root mounts for remote boxes,
remote or scripted reboots, etc.  Ive cobbled up a rube-goldberg
arrangement, which is out-of-scope for this message, will discuss all
that separately.

Characterization

RPM mentioned plotting, I take that to mean heavy use of graphs to
characterize and ultimately to predict xenomai performance over a
range of criteria, for any given platform.

LiveCD had the right idea wrt this - collecting platform info and
performance data on any vanilla PC with a CD-ROM drive.  And make this
data available on a website, allowing users to compare their results
with others done on similar platforms.

LiveCD has a few weaknesses though:

- cant test platforms w/o cdrom
- manual re-entry of data is tedious,
- no collection of platform data (available for automation)
- spotty info about cpu, memory, mobo, etc
- no unattended test (still true?)

These things could be readily fixed, but xeno-test already does
everything but the data upload.

The real value of LiveCD was the collection of data across hundreds of
different platforms, and its promise was that studying the data would
reveal the secrets of better performance on any platform.


A Plan (sort of)

1. xeno-test currently (patch pending) executes following commands,
and captures output in a reasonably parseable format; a set of chunks:

- uname -a
- cat /proc/config.gz if -f /proc/config.gz
- cat /proc/cpuinfo
- cat /proc/meminfo
- cat /proc/adeos/* foreach /proc/adeos/*
- cat /proc/ipipe/* foreach /proc/ipipe/*
- xeno-config --v
- xeno-info

The info captured is a fairly complete picture of the platform, it
should support careful selection of data-sets for use in analysing,
characterizing, and improving xenomai performance.

Several chunks are collected optionally, ex config.gz.  Although each
chunk has some cost (config.gz kernels are larger, kernels with
/proc/ipipe/Linux_stats are slower), Id encourage you to build your
kernels with this stuff enabled, as it enriches the data.  Besides,
with baseline data collected, you can then accurately demonstrate each
config-tweak's performance effect, and put it in a nice graph.

also need these:
- xenomai svn revision-level, perhaps as part of xeno-info,config ?
- what else ?  Anything added now is info-opportunity later
- testsuite/cruncher ?

2. send your results to xenomai.testout-at-gmail.com

Please run xeno-test, attach the resulting file(s), and send it to
above address.  This collects data now, we can decide where to host it
when website is up.  Obviously, an official gna.org ML might be more
appropriate.

# run something like this
xeno-test -T300 -sh -w2 -L -N ~/xenotest-outputs/foo

xeno-test will write all test output to a file:
~/xenotest-outputs/foo-$timestamp.  The timestamp gives unique-ness,
and you can choose which files 'look right' after inspecting several
trial-runs

FWIW - I could poach LiveCD code to upload to LiveCD site.
That might be handy if it doesnt break the process that populates the data
onto the web-page (which must parse for the data).

3. mail handler

Ive previously written a mail-bot to do poll a pop-mbox, and collect
attachments.  I just need to dredge it out or rewrite it.  Once I do,
I'll just run it on that inbox to collect your results.  Eventually,
the data will be uploaded somewhere for everyone to peruse.

If we go with a xenotest-results-at-gna.org, I can just subscribe my new
acct to the new list :-)

4. xeno-test output parser

Ive written a parser to chop the formatted output into chunks, and
then parse some of those chunks into hashes.  Soon Ill define some
matching db-tables for the (well mannered) data

'well mannered' means lots of limitations atm;

- /proc/ipipe/Linux-stats parse into pairs of IRQ => CPU0 prop-times
- such data is only comparable across kernels with eq IRQ maps
- currently wont handle CPU1, SMP data
- /proc/interrupts is slightly better parsed.
- no detail-parse at all for top-data, needed?

prototype only, but its hackable (perl), and Im happy to graft all
sorts of horrible experiments on it provisionally to see whats useful.
Hopefully a plugin refactoring will become obvious wo too much work.


5. Data-Base

The data extracted above needs to be written to a database, perhaps in
multiple, increasingly cooked, redundant forms.  Point is, we can do
it incrementally, a chunk at a time.

- store chunks as raw-text, along w indexing
- write a query to replicate full-report text from the chunks
- many chunk-types have table designed to match
- some chunk-types insert 1 row into chunk-typeX-table, others 2+
- latency-data has lots of data
--- raw interval data (min, avg, max, ovfl)
--- histograms of data (for min, avg, max)
- chunk-types index VS md5(raw-text)
-- ok: uname - semi-regular, (various kernel suffixes)
-- ok: /prc/cpuinfo - almost (fuzz on  mhz, bogomips)
-- no: /proc/config.gz - contains arbitrary date, reveals no commonality

At first, I dont plan on much data-normalization, indexification.  Id
like to be able to later go back, and 'histogram' each field; many
will have a discrete set of values (ex: config setting of
CONFIG_PREEMPT, presense of /proc/ipipe/Linux_stats, etc)

makefile-esque production semantics would be useful here, esp as a
cross-check against same implemented in the DB.


6. Plotting

The best use of any collected data is to graph it many different ways,
and so to understand it.  Gnuplot is a clear choice for this. (maybe
Octave?)

Biggest issue is preparing data for gnuplot, which seems to want files
of space/tab-separated data.  We'll have to provide some db-extract
mechanism (or direct from file-set, using parser+plugin) to select the
right data for each plot, format it accordingly, and run the plot.

Ive yet to try to plot anything from my collected files, so I dont
have real insight into the issues/difficulties.  But heres a few
hastily-concieved examples:

judging the data-set itself:

- select count(*) from .. where X group.by Y
- see dist of samples across Y
- identify strongly bucketized vars
- ex:
-- how many of each cpuinfo.model-name ? (expect finite set)
-- how many of each cpuinfo.cpu-mhz foreach above ? (1..dozen foreach model)
-- how many old cpuinfo.steppings ? (curiosity)
--- select count(*)
---  group by cpuinfo.model_name
---  having count(cpuinfo.stepping) > 1

looking for performance factors:

- correlations (outputs vs inputs/features)
- boolean features should correlate strongly if related
- multi-val features too
- ex:
-- max-latency vs bogo-mips foreach arch/cpu-type

- histograms of correlated variables (as idenfified above)
-- display for hints wrt causes

- for variables/fields with certian value-distributions,
-- group-by those fields
-- plot, and look for clustering
-- when kernel.config.PREEMPT becomes a queryable-field, analysis flows
--- =PREEMPT_NONE, =PREEMPT_RT, etc... with

- curve fitting vs data subsets
-- posit: latency is-inverse-to bogo-mips
-- hypothesize: latency * bogo-mips == quality-metric-weak
-- graph it, per cputype
-- select different subsets of cputype
--- x86, 586 +/- TSC, MMX, GENERIC, etc..
--- does spread narrow as subset is narrowed ?


GOALS - MILESTONES

0. that which is measured, is quantitatively improved (fact, not goal)

1. rich, automatically collected data makes it possible to compare
data from different people.

Most of us are stuck with 1 platform, so its difficult to find out
what effects clock-rate has on latency, for a given platform. IOW,
what is the "latency vs clock-rate" (Lat-v-clk)

With pooled data, for common PC platforms at least (ex p4, k8), we can
collect a large pool of data, enough to make predictions about
Lat-v-clk.  Graphs are encouraged.

2. Repeat for Lat = f(clk-rate, mem-size) over (select ..)
   Plot as elevation-map

3. Somebody hacks the cpufreq clock-control, and reruns the test on a
progressively throttled cpu.  This represents a (more) highly
controlled study, and comes with lots of pretty graph jpegs showing
the effect clearly.  This becomes pseudo-reference data.

4. Somebody examines predictions against ref3-data.
Start actually doing the analysis that I handwaved in L<Plotting>

5. Others start to repeat earlier experiments, attempting to replicate
the results.  Where differences persist, they collaborate to
distinguish the reasons.  We improve our understanding of the tests,
and the processes around them.

6. people explore xeno-test options.

They run batteries of tests while varying -options, and create many
graphs which illustrate various performances:

- what happens when sampling period shrinks towards the max-latency
seen in the previous test-run ?  Does xenomai panic, muddle on,
error-out, give proper warning, etc ??

- whats the histogram look like when number of buckets is greatly
increased ?  Does it start to look like a comb with lots of broken
teeth ?  Can it be adequately smoothed by a plotting function ?

- what kind of results can you get from using -W "$command $args"
with the wide range of benchmark tests (which themselves serve as a 
workload).

7. people hack parse-testout.pl.

Each person in 6 should consider hacking the chunk-specific text
processing into parse-testout.pl.  I'll look for a workable plug-in
scheme to simplify & extend how and what can be done.  We get
use-cases at least, maybe bits of automation, and probably a workable
alpha version.  (Ill try this at some point)

8. Patterns of analysis emerge, and develop into a "howto gnuplot your
xenotest-perfdata".  With these, we better understand what the
automation must do.

Presumably this is gnuplot centric; we start with a gnuplot script,
and template/parametrize it.  With it, some plugin code to prep the
data-files to produce plots.

This is also where Im most uncertain how things will look.


9. workable plotting automation ?

10. Growing sample-set attracts study

Growth of a quality-assessable dataset, and workable automation (9)
lures hackers to madly correlate performance numbers against possible
causal factors.  Much of this is likely in x86 data, since platform is
so widely available.

11. somebody rewrites xeno-test

Its currently in bash, and (prolly) uses constructs that wont work on
busybox.  It also has some bugs in workload management.

12. and I want a pony.



NOTES

theres a difference between benchmarks and tests, and Ive munged
things already by saying test until now.  But calling everything a
benchmark is just as clumsy.

Tests are things that can pass or fail, good ones give an indication
of what broke.  Ideally, a test demonstrates that a bug exists, and
that the patch it was submitted with fixes that bug.  Then the test
gets added to the regression-test framework that uses them to guard
against breakage. (hey - I said ideally).

Turning benchmark tests into regression tests is easy - once we know
how a given platform *should* perform.  Obviously, thats the goal
stated at the top.



COMMENTS ?

Lets pretend that we're developing content for a wiki ;-)

Im accepting 2 kinds of comments

- those where you change the subject
- the rest ;-)

Im making the inference that if you change the message-subject;

- you think the topic is a proto-wiki-node (not necessarily a page)
- youre keeping the message on that topic
- youre actively adapting subjects on such threads that you participate in
-- we strike balance on node-growth rate (is there a just right ?)

if you dont change subject,
- above rules dont apply, stream of conciousness is fine.
- or youre adding to / correcting the previous 'wiki-node'

I dont prefer either kind of post a-priori; this is an experiment in
social/community self-organization on an ML.  Its not supposed to be 
laborious.
Lets see what happens.

tia
jimc



